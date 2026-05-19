import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/peer_model.dart';
import '../../models/proximity_params.dart';
import '../../audio/audio_engine.dart';
import '../../proximity/proximity_math.dart';
import '../../doppler/doppler.dart';

part 'session_bloc.freezed.dart';
part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AudioEngine    _audioEngine;
  final ProximityMath  _proximity;
  Timer?               _gainTimer;

  /// Exposes the shared audio engine so the session screen and runner
  /// can use the same instance for capture / playback / mix.
  AudioEngine get audioEngine => _audioEngine;

  SessionBloc({required AudioEngine audioEngine})
      : _audioEngine = audioEngine,
        _proximity   = ProximityMath(),
        super(const SessionState.idle()) {
    on<SessionStarted>(_onStarted);
    on<SessionPeerAdded>(_onPeerAdded);
    on<SessionPeerRemoved>(_onPeerRemoved);
    on<SessionPeerPositionUpdated>(_onPeerPositionUpdated);
    on<SessionSelfPositionUpdated>(_onSelfPositionUpdated);
    on<SessionGainTick>(_onGainTick);
    on<SessionPeerMetricsUpdated>(_onPeerMetricsUpdated);
    on<SessionProximityParamsChanged>(_onProximityParamsChanged);
    on<SessionEnded>(_onEnded);
  }

  void _onStarted(SessionStarted event, Emitter<SessionState> emit) {
    emit(SessionState.active(
      selfId:   event.selfId,
      roomCode: event.roomCode,
      username: event.username,
    ));
    // 60 Hz gain update loop
    _gainTimer = Timer.periodic(
      const Duration(milliseconds: 16),
      (_) => add(const SessionEvent.gainTick()),
    );
  }

  void _onPeerAdded(SessionPeerAdded event, Emitter<SessionState> emit) {
    final current = state;
    if (current is! SessionActive) return;
    _audioEngine.addPeer(event.id);
    final updated = Map<int, PeerModel>.from(current.peers)
      ..[event.id] = PeerModel(id: event.id, name: event.name);
    emit(current.copyWith(peers: updated));
  }

  void _onPeerRemoved(SessionPeerRemoved event, Emitter<SessionState> emit) {
    final current = state;
    if (current is! SessionActive) return;
    _audioEngine.removePeer(event.id);
    final updated = Map<int, PeerModel>.from(current.peers)
      ..remove(event.id);
    emit(current.copyWith(peers: updated));
  }

  void _onPeerPositionUpdated(
      SessionPeerPositionUpdated event, Emitter<SessionState> emit) {
    final current = state;
    if (current is! SessionActive) return;
    final peer = current.peers[event.id];
    if (peer == null) return;
    final updated = Map<int, PeerModel>.from(current.peers)
      ..[event.id] = peer.copyWith(
        x:     event.x,
        z:     event.z,
        yaw:   event.yaw,
        speed: event.speed,
      );
    emit(current.copyWith(peers: updated));
  }

  void _onSelfPositionUpdated(
      SessionSelfPositionUpdated event, Emitter<SessionState> emit) {
    final current = state;
    if (current is! SessionActive) return;
    emit(current.copyWith(
      selfX:           event.x,
      selfZ:           event.z,
      selfYaw:         event.yaw,
      selfSpeed:       event.speed,
      telemetryActive: event.isRaceOn,
    ));
  }

  void _onGainTick(SessionGainTick event, Emitter<SessionState> emit) {
    final current = state;
    if (current is! SessionActive) return;

    for (final entry in current.peers.entries) {
      final peer   = entry.value;
      final params = current.proximity;

      final dist     = xzDistance(current.selfX, current.selfZ, peer.x, peer.z);
      final rawGain  = gainForDistance(dist, params.near, params.far, params.curve);
      final rawPan   = params.panning
          ? panForBearing(
              peer.x - current.selfX,
              peer.z - current.selfZ,
              current.selfYaw,
            )
          : 0.0;

      final smoothed = _proximity.smooth(entry.key, rawGain, rawPan);
      final (gL, gR) = stereoGains(smoothed.gain, smoothed.pan);

      final doppler = computeDopplerFactor(
        selfX:      current.selfX,
        selfZ:      current.selfZ,
        peerX:      peer.x,
        peerZ:      peer.z,
        peerYaw:    peer.yaw,
        peerSpeed:  peer.speed,
      );

      _audioEngine.setGains(entry.key, gL, gR);

      add(SessionEvent.peerMetricsUpdated(
        id:           entry.key,
        distanceM:    dist,
        rawGain:      smoothed.gain,
        gainL:        gL,
        gainR:        gR,
        pan:          smoothed.pan,
        dopplerFactor: doppler,
        bufferMs:     _audioEngine.bufferMs(entry.key),
      ));
    }
  }

  void _onPeerMetricsUpdated(
      SessionPeerMetricsUpdated event, Emitter<SessionState> emit) {
    final current = state;
    if (current is! SessionActive) return;
    final peer = current.peers[event.id];
    if (peer == null) return;
    final updated = Map<int, PeerModel>.from(current.peers)
      ..[event.id] = peer.copyWith(
        distanceM:     event.distanceM,
        rawGain:       event.rawGain,
        gainL:         event.gainL,
        gainR:         event.gainR,
        pan:           event.pan,
        dopplerFactor: event.dopplerFactor,
        bufferMs:      event.bufferMs,
      );
    emit(current.copyWith(peers: updated));
  }

  void _onProximityParamsChanged(
      SessionProximityParamsChanged event, Emitter<SessionState> emit) {
    final current = state;
    if (current is! SessionActive) return;
    emit(current.copyWith(proximity: event.params));
  }

  void _onEnded(SessionEnded event, Emitter<SessionState> emit) {
    _gainTimer?.cancel();
    _gainTimer = null;
    _proximity.reset();
    emit(const SessionState.idle());
  }

  @override
  Future<void> close() async {
    _gainTimer?.cancel();
    return super.close();
  }
}
