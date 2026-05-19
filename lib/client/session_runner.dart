import 'dart:async';
import 'dart:typed_data';

import '../audio/audio_engine.dart';
import '../blocs/connection/connection_bloc.dart';
import '../blocs/session/session_bloc.dart';
import '../doppler/doppler.dart';
import '../models/audio_device_info.dart';
import '../models/setup_config.dart';
import '../protocol/protocol.dart';
import '../telemetry/telemetry_receiver.dart';
import 'client.dart';

/// Coordinates all real-time activity once a room has been joined:
///   • TCP sender loop (audio frames + position every 4 frames)
///   • TCP receiver loop (routes hub messages to BLoCs / AudioEngine)
///   • Telemetry (routes Forza UDP to SessionBloc)
class SessionRunner {
  final HorizonClient     _client;
  final AudioEngine       _audio;
  final SessionBloc       _sessionBloc;
  final ConnectionBloc    _connectionBloc;
  SetupConfig             _config;

  SetupConfig get config => _config;

  TelemetryReceiver?      _telemetry;
  StreamSubscription<HubMessage>? _hubSub;
  Timer?                  _senderTimer;
  int                     _posCounter = 0;

  bool _running = false;

  SessionRunner({
    required HorizonClient  client,
    required AudioEngine    audio,
    required SessionBloc    sessionBloc,
    required ConnectionBloc connectionBloc,
    required SetupConfig    config,
  })  : _client         = client,
        _audio          = audio,
        _sessionBloc    = sessionBloc,
        _connectionBloc = connectionBloc,
        _config         = config;

  Future<void> start() async {
    if (_running) return;
    _running = true;

    _startCapture();
    _startPlayback();
    _startTelemetry();
    _startHubReceiver();
    _startSenderLoop();
  }

  // ── Capture ─────────────────────────────────────────────────────────────

  void _startCapture() {
    final cfg = _config;
    switch (cfg.inputMode) {
      case AudioInputMode.mic:
        _audio.startMicCapture(cfg.inputDevice?.index ?? 0);
      case AudioInputMode.loopback:
        _audio.startLoopbackCapture(cfg.inputDevice?.index ?? 0);
      case AudioInputMode.processCapture:
        final pid = cfg.audioSession?.pid;
        if (pid != null) _audio.startProcessCapture(pid);
    }
  }

  void _startPlayback() {
    _audio.startPlayback(_config.outputDevice?.index ?? -1);
  }

  // ── Hot Swapping ────────────────────────────────────────────────────────

  void changeInput(AudioInputMode mode, {AudioDeviceInfo? device, AudioSessionInfo? session}) {
    _audio.stopCapture();
    _config = _config.copyWith(
      inputMode: mode,
      inputDevice: device,
      audioSession: session,
    );
    _startCapture();
  }

  void changeOutput(AudioDeviceInfo? device) {
    _audio.stopPlayback();
    _config = _config.copyWith(outputDevice: device);
    _startPlayback();
  }

  // ── Telemetry ────────────────────────────────────────────────────────────

  void _startTelemetry() {
    _telemetry = TelemetryReceiver(
      listenPort: kDefaultTelemetryPort,
      onUpdate: (state) {
        _sessionBloc.add(SessionEvent.selfPositionUpdated(
          x:        state.x,
          z:        state.z,
          yaw:      state.yaw,
          speed:    state.speed,
          isRaceOn: state.isRaceOn,
        ));
      },
      onStale: () {
        _sessionBloc.add(const SessionEvent.selfPositionUpdated(
          x: 0, z: 0, yaw: 0, speed: 0, isRaceOn: false,
        ));
      },
    );
    _telemetry!.start();
  }

  // ── Hub receiver ─────────────────────────────────────────────────────────

  void _startHubReceiver() {
    _hubSub = _client.messages.listen((msg) {
      switch (msg.type) {
        case kH2cPeerJoined:
          final parsed = parsePeerJoined(msg.payload);
          _sessionBloc.add(SessionEvent.peerAdded(
              id: parsed.id, name: parsed.name));
          _audio.addPeer(parsed.id);

        case kH2cPeerLeft:
          final id = msg.payload[0];
          _sessionBloc.add(SessionEvent.peerRemoved(id: id));
          _audio.removePeer(id);

        case kH2cPeerState:
          final p = parsePeerState(msg.payload);
          _sessionBloc.add(SessionEvent.peerPositionUpdated(
            id: p.id, x: p.x, z: p.z, yaw: p.yaw, speed: p.speed));

        case kH2cPeerAudio:
          _handlePeerAudio(msg.payload);

        case kH2cError:
          _connectionBloc.add(ConnectionEvent.errorReceived(
              message: String.fromCharCodes(msg.payload)));

        case kH2cRoomList:
          // Shouldn't arrive mid-session, ignore
          break;
      }
    }, onError: (_) => stop());
  }

  void _handlePeerAudio(Uint8List payload) {
    if (payload.length < 1921) return;
    final peerId = payload[0];

    // Reconstruct Int16List from the raw bytes
    final bytes   = payload.sublist(1, 1921);
    final samples = Int16List(kFrameSamples);
    for (var i = 0; i < kFrameSamples; i++) {
      samples[i] = (bytes[i * 2] | (bytes[i * 2 + 1] << 8)).toSigned(16);
    }

    // Apply Doppler: get peer position from SessionBloc state
    final sessionState = _sessionBloc.state;
    if (sessionState is SessionActive) {
      final peer = sessionState.peers[peerId];
      if (peer != null) {
        final factor = computeDopplerFactor(
          selfX:     sessionState.selfX,
          selfZ:     sessionState.selfZ,
          peerX:     peer.x,
          peerZ:     peer.z,
          peerYaw:   peer.yaw,
          peerSpeed: peer.speed,
        );
        final pitched = applyDoppler(samples, factor);
        _audio.enqueuePeerAudio(peerId, pitched);
        return;
      }
    }
    _audio.enqueuePeerAudio(peerId, samples);
  }

  // ── Sender loop ───────────────────────────────────────────────────────────
  // Fires every ~5 ms; sends audio when available, state every 4th audio frame.

  void _startSenderLoop() {
    _senderTimer = Timer.periodic(const Duration(milliseconds: 5), (_) async {
      final frame = _audio.popCapture();
      if (frame == null) return;

      final bytes = Uint8List(kPcmBytes);
      for (var i = 0; i < kFrameSamples; i++) {
        bytes[i * 2]     = frame[i] & 0xFF;
        bytes[i * 2 + 1] = (frame[i] >> 8) & 0xFF;
      }
      await _client.sendAudio(bytes);

      _posCounter++;
      if (_posCounter >= 4) {
        _posCounter = 0;
        final s = _sessionBloc.state;
        if (s is SessionActive) {
          await _client.sendState(s.selfX, s.selfZ, s.selfYaw, s.selfSpeed);
        }
      }
    });
  }

  // ── Teardown ──────────────────────────────────────────────────────────────

  Future<void> stop() async {
    if (!_running) return;
    _running = false;

    _senderTimer?.cancel();
    await _hubSub?.cancel();
    _telemetry?.stop();
    _audio.stop();
    _sessionBloc.add(const SessionEvent.ended());
  }
}
