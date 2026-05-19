import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import '../models/audio_device_info.dart';
import '../protocol/protocol.dart';
import 'peer_audio.dart';
import 'native_audio_ffi.dart';

/// High-level audio orchestrator.
/// Wraps the native DLL for capture + playback, owns all PeerAudio buffers,
/// and drives the playback mix loop.
class AudioEngine {
  final Map<int, PeerAudio> _peers = {};
  NativeAudio? _native; // null if DLL not available
  Timer?       _mixTimer;
  bool         _capturing   = false;
  bool         _playing     = false;
  final _captureQueue = <Int16List>[];

  /// Notifies listeners (UI VU meters) of the current capture RMS (0.0 to 1.0).
  final ValueNotifier<double> captureRms = ValueNotifier(0.0);

  /// Notifies listeners (UI VU meters) of the current playback RMS (0.0 to 1.0).
  final ValueNotifier<double> playbackRms = ValueNotifier(0.0);

  /// Called once for each captured frame immediately after it is popped.
  /// Receives a *copy* of the frame so it can be used without competing with
  /// the sender loop.  Set by [LocalTestController] to feed the test peer.
  void Function(Int16List frame)? onCaptureFrame;

  /// When true the mix loop adds the most-recent captured frame at full gain
  /// so you hear your own input immediately (monitor / sidetone).
  bool monitorEnabled = false;
  Int16List? _lastCaptured; // kept for monitor mix — updated by popCapture()

  AudioEngine() {
    try {
      _native = NativeAudio.instance;
    } catch (_) {
      // DLL not yet compiled — device lists return empty, capture/playback are no-ops
    }
  }

  // ── Device enumeration ──────────────────────────────────────────────────

  Future<List<AudioDeviceInfo>> listInputDevices() async {
    if (_native == null) return [];
    try {
      final json = _native!.listInputDevicesJson();
      final list = jsonDecode(json) as List;
      return list.asMap().entries.map((e) => AudioDeviceInfo(
        index: e.key,
        name:  e.value['name'] as String? ?? 'Device ${e.key}',
      )).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<AudioDeviceInfo>> listOutputDevices() async {
    if (_native == null) return [];
    try {
      final json = _native!.listOutputDevicesJson();
      final list = jsonDecode(json) as List;
      return list.asMap().entries.map((e) => AudioDeviceInfo(
        index:    e.key,
        name:     e.value['name'] as String? ?? 'Device ${e.key}',
        isOutput: true,
      )).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<AudioSessionInfo>> listAudioSessions() async {
    if (_native == null) return [];
    try {
      final json = _native!.listAudioSessionsJson();
      final list = jsonDecode(json) as List;
      return list.map((e) => AudioSessionInfo(
        pid:          (e['pid'] as num).toInt(),
        exeName:      e['exe'] as String? ?? '',
        displayName:  e['name'] as String? ?? e['exe'] as String? ?? 'Unknown',
        loopbackIndex:(e['loopback_idx'] as num?)?.toInt() ?? 0,
        deviceName:   e['device_name'] as String? ?? '',
        sharedWith:   (e['shared_with'] as num?)?.toInt() ?? 1,
      )).toList();
    } catch (_) {
      return [];
    }
  }

  // ── Capture start ───────────────────────────────────────────────────────

  bool startMicCapture(int deviceIndex) {
    if (_native == null || _capturing) return false;
    _capturing = _native!.startMicCapture(deviceIndex);
    return _capturing;
  }

  bool startLoopbackCapture(int deviceIndex) {
    if (_native == null || _capturing) return false;
    _capturing = _native!.startLoopbackCapture(deviceIndex);
    return _capturing;
  }

  bool startProcessCapture(int pid) {
    if (_native == null || _capturing) return false;
    _capturing = _native!.startProcessCapture(pid);
    return _capturing;
  }

  /// Starts playback on [deviceIndex] (-1 = system default) and launches
  /// the 20 ms mix timer.
  bool startPlayback(int deviceIndex) {
    if (_native == null || _playing) return false;
    _playing = _native!.startPlayback(deviceIndex);
    if (_playing) _startMixLoop();
    return _playing;
  }

  // ── Frame I/O ───────────────────────────────────────────────────────────

  /// Returns the next captured frame, or null if none available yet.
  ///
  /// **Side-effects:**
  /// - Saves a copy in [_lastCaptured] for the monitor mix.
  /// - Calls [onCaptureFrame] with a copy so the local-test loopback can
  ///   receive frames without racing with the sender loop.
  Int16List? popCapture() {
    Int16List? frame;

    // Try the native ring buffer first
    if (_native != null) {
      frame = _native!.readFrame();
    }
    if (frame == null && _captureQueue.isNotEmpty) {
      frame = _captureQueue.removeLast();
    }

    if (frame != null) {
      // Calculate RMS for VU meter
      double sumSq = 0.0;
      for (var i = 0; i < kFrameSamples; i++) {
        final s = frame[i] / 32768.0;
        sumSq += s * s;
      }
      captureRms.value = sqrt(sumSq / kFrameSamples);

      // Keep a copy for monitor mix
      _lastCaptured = Int16List.fromList(frame);
      // Notify tap listeners (e.g. LocalTestController)
      onCaptureFrame?.call(Int16List.fromList(frame));
    } else {
      captureRms.value = 0.0;
    }

    return frame;
  }

  /// Sets the per-peer stereo gains (called by the gain loop).
  void setGains(int peerId, double gainL, double gainR) {
    _peers[peerId]?.setGains(gainL, gainR);
  }

  /// Enqueues a received peer audio frame (after Doppler has been applied).
  void enqueuePeerAudio(int peerId, Int16List frame) {
    _peers[peerId]?.put(frame);
  }

  /// Current buffer fill for a peer in milliseconds.
  int bufferMs(int peerId) => _peers[peerId]?.bufferMs ?? 0;

  // ── Peer lifecycle ──────────────────────────────────────────────────────

  void addPeer(int id)    { _peers[id] = PeerAudio(); }
  void removePeer(int id) { _peers.remove(id)?.clear(); }

  // ── Internal mix loop (runs every 20 ms on a Timer) ────────────────────

  void _startMixLoop() {
    _mixTimer = Timer.periodic(const Duration(milliseconds: 20), (_) => _mix());
  }

  void _mix() {
    if (_native == null || !_playing) return;

    final left  = Float64List(kFrameSamples);
    final right = Float64List(kFrameSamples);

    // Mix all peer buffers
    for (final peer in _peers.values) {
      final frame = peer.get();
      if (frame == null) continue;
      for (var i = 0; i < kFrameSamples; i++) {
        final s = frame[i] / 32768.0;
        left[i]  += s * peer.gainL;
        right[i] += s * peer.gainR;
      }
    }

    // Monitor: add your own capture at unity gain (sidetone / input test)
    if (monitorEnabled) {
      final mon = _lastCaptured;
      if (mon != null) {
        for (var i = 0; i < kFrameSamples; i++) {
          final s = mon[i] / 32768.0;
          left[i]  += s;
          right[i] += s;
        }
      }
    }

    // Calculate RMS for the playback VU meter (using the left channel for mono-mix representation)
    double sumSq = 0.0;
    for (var i = 0; i < kFrameSamples; i++) {
      final s = left[i];
      sumSq += s * s;
    }
    playbackRms.value = sqrt(sumSq / kFrameSamples);

    // Clip and convert to int16
    final outL = Int16List(kFrameSamples);
    final outR = Int16List(kFrameSamples);
    for (var i = 0; i < kFrameSamples; i++) {
      outL[i] = (left[i].clamp(-1.0, 1.0) * 32767).round();
      outR[i] = (right[i].clamp(-1.0, 1.0) * 32767).round();
    }

    _native!.writeFrame(outL, outR);
  }

  // ── Teardown and Restart ────────────────────────────────────────────────

  void stopCapture() {
    if (_capturing) {
      _native?.stopCapture();
      _capturing = false;
      captureRms.value = 0.0;
    }
  }

  void stopPlayback() {
    if (_playing) {
      _mixTimer?.cancel();
      _mixTimer = null;
      _native?.stopPlayback();
      _playing = false;
      playbackRms.value = 0.0;
    }
  }

  void stop() {
    stopPlayback();
    stopCapture();
    monitorEnabled = false;
    onCaptureFrame = null;
    _lastCaptured  = null;
    for (final p in _peers.values) { p.clear(); }
    _peers.clear();
  }
}
