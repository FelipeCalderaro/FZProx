part of 'session_bloc.dart';

@freezed
class SessionState with _$SessionState {
  const factory SessionState.idle() = SessionIdle;

  const factory SessionState.active({
    required int    selfId,
    required String roomCode,
    required String username,
    // Self position from telemetry
    @Default(0.0) double selfX,
    @Default(0.0) double selfZ,
    @Default(0.0) double selfYaw,
    @Default(0.0) double selfSpeed,
    @Default(false) bool telemetryActive,
    // Peers — ordered by distance in the UI
    @Default({}) Map<int, PeerModel> peers,
    // Live proximity config (editable mid-session)
    @Default(ProximityParams()) ProximityParams proximity,
  }) = SessionActive;
}
