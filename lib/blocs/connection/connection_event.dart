part of 'connection_bloc.dart';

@freezed
class ConnectionEvent with _$ConnectionEvent {
  const factory ConnectionEvent.connect({
    required String hubHost,
    required int    hubPort,
  }) = ConnectionConnect;

  const factory ConnectionEvent.listRooms() = ConnectionListRooms;

  const factory ConnectionEvent.joinRoom({
    required String code,
    required String username,
  }) = ConnectionJoinRoom;

  const factory ConnectionEvent.createRoom({
    required String username,
  }) = ConnectionCreateRoom;

  const factory ConnectionEvent.disconnect() = ConnectionDisconnect;

  // Internal — fired by network receiver
  const factory ConnectionEvent.roomListReceived({
    required List<RoomInfo> rooms,
  }) = ConnectionRoomListReceived;

  const factory ConnectionEvent.welcomeReceived({
    required int    selfId,
    required String roomCode,
    required List<({int id, String name})> peers,
  }) = ConnectionWelcomeReceived;

  const factory ConnectionEvent.errorReceived({
    required String message,
  }) = ConnectionErrorReceived;

  const factory ConnectionEvent.peerJoined({
    required int    id,
    required String name,
  }) = ConnectionPeerJoined;

  const factory ConnectionEvent.peerLeft({
    required int id,
  }) = ConnectionPeerLeft;
}
