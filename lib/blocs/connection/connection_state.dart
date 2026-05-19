part of 'connection_bloc.dart';

@freezed
class ConnectionState with _$ConnectionState {
  const factory ConnectionState.idle() = ConnectionIdle;

  const factory ConnectionState.connecting({
    required String hubHost,
    required int    hubPort,
  }) = ConnectionConnecting;

  /// Connected; waiting for room choice.
  const factory ConnectionState.selectingRoom({
    required String         hubHost,
    required int            hubPort,
    required String         username,
    required List<RoomInfo> rooms,
  }) = ConnectionSelectingRoom;

  /// HELLO sent; waiting for WELCOME.
  const factory ConnectionState.joining({
    required String hubHost,
    required int    hubPort,
    required String username,
    required String roomCode,
  }) = ConnectionJoining;

  /// Fully joined — session is live.
  const factory ConnectionState.inSession({
    required int    selfId,
    required String roomCode,
    required String username,
    required String hubHost,
    required int    hubPort,
    /// Peers that were already in the room at join time (from the WELCOME packet).
    @Default([]) List<({int id, String name})> existingPeers,
  }) = ConnectionInSession;

  const factory ConnectionState.failed({
    required String message,
  }) = ConnectionFailed;
}
