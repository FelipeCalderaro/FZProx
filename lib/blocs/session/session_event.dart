part of 'session_bloc.dart';

@freezed
class SessionEvent with _$SessionEvent {
  const factory SessionEvent.started({
    required int    selfId,
    required String roomCode,
    required String username,
  }) = SessionStarted;

  const factory SessionEvent.peerAdded({
    required int    id,
    required String name,
  }) = SessionPeerAdded;

  const factory SessionEvent.peerRemoved({required int id}) = SessionPeerRemoved;

  const factory SessionEvent.peerPositionUpdated({
    required int    id,
    required double x,
    required double z,
    required double yaw,
    required double speed,
  }) = SessionPeerPositionUpdated;

  const factory SessionEvent.selfPositionUpdated({
    required double x,
    required double z,
    required double yaw,
    required double speed,
    required bool   isRaceOn,
  }) = SessionSelfPositionUpdated;

  /// Fired by the 60 Hz gain loop — recalculates all peer gains.
  const factory SessionEvent.gainTick() = SessionGainTick;

  /// Fired per-peer after gain computation to update UI metrics.
  const factory SessionEvent.peerMetricsUpdated({
    required int    id,
    required double distanceM,
    required double rawGain,
    required double gainL,
    required double gainR,
    required double pan,
    required double dopplerFactor,
    required int    bufferMs,
  }) = SessionPeerMetricsUpdated;

  const factory SessionEvent.proximityParamsChanged({
    required ProximityParams params,
  }) = SessionProximityParamsChanged;

  const factory SessionEvent.ended() = SessionEnded;
}
