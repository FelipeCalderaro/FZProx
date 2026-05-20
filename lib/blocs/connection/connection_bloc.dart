import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/room_info.dart';
import '../../protocol/protocol.dart';
import '../../client/client.dart';

part 'connection_bloc.freezed.dart';
part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  HorizonClient?              _client;
  StreamSubscription<HubMessage>? _msgSub;

  ConnectionBloc() : super(const ConnectionState.idle()) {
    on<ConnectionConnect>(_onConnect);
    on<ConnectionListRooms>(_onListRooms);
    on<ConnectionJoinRoom>(_onJoinRoom);
    on<ConnectionCreateRoom>(_onCreateRoom);
    on<ConnectionDisconnect>(_onDisconnect);
    on<ConnectionRoomListReceived>(_onRoomListReceived);
    on<ConnectionWelcomeReceived>(_onWelcomeReceived);
    on<ConnectionErrorReceived>(_onErrorReceived);
    on<ConnectionPeerJoined>(_onPeerJoined);
    on<ConnectionPeerLeft>(_onPeerLeft);
  }

  Future<void> _onConnect(
      ConnectionConnect event, Emitter<ConnectionState> emit) async {
    emit(ConnectionState.connecting(
        hubHost: event.hubHost, hubPort: event.hubPort, username: event.username));
    try {
      _client = HorizonClient(host: event.hubHost, port: event.hubPort);
      await _client!.connect();

      // Route hub messages into this bloc as ConnectionEvents.
      _msgSub = _client!.messages.listen((msg) {
        switch (msg.type) {
          case kH2cRoomList:
            final parsed = parseRoomList(msg.payload);
            add(ConnectionEvent.roomListReceived(
              rooms: parsed
                  .map((r) => RoomInfo(code: r.code, playerCount: r.playerCount))
                  .toList(),
            ));
          case kH2cWelcome:
            final w = parseWelcome(msg.payload);
            add(ConnectionEvent.welcomeReceived(
              selfId:   w.selfId,
              roomCode: w.code,
              peers:    w.peers,
            ));
          case kH2cError:
            add(ConnectionEvent.errorReceived(
              message: utf8.decode(msg.payload, allowMalformed: true),
            ));
          case kH2cPeerJoined:
            final p = parsePeerJoined(msg.payload);
            add(ConnectionEvent.peerJoined(id: p.id, name: p.name));
          case kH2cPeerLeft:
            if (msg.payload.isNotEmpty) {
              add(ConnectionEvent.peerLeft(id: msg.payload[0]));
            }
        }
      }, onError: (e) {
        add(ConnectionEvent.errorReceived(message: 'Hub connection lost: $e'));
      });

      // After connect, immediately list rooms
      add(const ConnectionEvent.listRooms());
    } on SocketException catch (e) {
      emit(ConnectionState.failed(
          message: 'Cannot reach hub at ${event.hubHost}:${event.hubPort} — $e'));
    } catch (e) {
      emit(ConnectionState.failed(message: 'Connection error: $e'));
    }
  }

  Future<void> _onListRooms(
      ConnectionListRooms event, Emitter<ConnectionState> emit) async {
    await _client?.sendListRooms();
  }

  Future<void> _onJoinRoom(
      ConnectionJoinRoom event, Emitter<ConnectionState> emit) async {
    final current = state;
    if (current is! ConnectionSelectingRoom) return;
    emit(ConnectionState.joining(
      hubHost:  current.hubHost,
      hubPort:  current.hubPort,
      username: event.username,
      roomCode: event.code,
    ));
    await _client?.sendHello(event.code, event.username);
  }

  Future<void> _onCreateRoom(
      ConnectionCreateRoom event, Emitter<ConnectionState> emit) async {
    final current = state;
    if (current is! ConnectionSelectingRoom) return;
    final code = generateRoomCode();
    emit(ConnectionState.joining(
      hubHost:  current.hubHost,
      hubPort:  current.hubPort,
      username: event.username,
      roomCode: code,
    ));
    await _client?.sendHello(code, event.username);
  }

  Future<void> _onDisconnect(
      ConnectionDisconnect event, Emitter<ConnectionState> emit) async {
    await _msgSub?.cancel();
    _msgSub = null;
    await _client?.disconnect();
    _client = null;
    emit(const ConnectionState.idle());
  }

  void _onRoomListReceived(
      ConnectionRoomListReceived event, Emitter<ConnectionState> emit) {
    final current = state;
    // Accept from both Connecting and SelectingRoom states (for refreshes)
    String hubHost;
    int    hubPort;
    String username;
    if (current is ConnectionConnecting) {
      hubHost  = current.hubHost;
      hubPort  = current.hubPort;
      username = current.username;
    } else if (current is ConnectionSelectingRoom) {
      hubHost  = current.hubHost;
      hubPort  = current.hubPort;
      username = current.username;
    } else {
      return;
    }
    emit(ConnectionState.selectingRoom(
      hubHost:  hubHost,
      hubPort:  hubPort,
      username: username,
      rooms:    event.rooms,
    ));
  }

  void _onWelcomeReceived(
      ConnectionWelcomeReceived event, Emitter<ConnectionState> emit) {
    final current = state;
    if (current is! ConnectionJoining) return;
    emit(ConnectionState.inSession(
      selfId:        event.selfId,
      roomCode:      event.roomCode,
      username:      current.username,
      hubHost:       current.hubHost,
      hubPort:       current.hubPort,
      existingPeers: event.peers,
    ));
  }

  void _onErrorReceived(
      ConnectionErrorReceived event, Emitter<ConnectionState> emit) {
    emit(ConnectionState.failed(message: event.message));
  }

  void _onPeerJoined(
      ConnectionPeerJoined event, Emitter<ConnectionState> emit) {
    // Peer joined events are forwarded to SessionBloc via the client
  }

  void _onPeerLeft(
      ConnectionPeerLeft event, Emitter<ConnectionState> emit) {
    // Peer left events are forwarded to SessionBloc via the client
  }

  HorizonClient? get client => _client;

  @override
  Future<void> close() async {
    await _msgSub?.cancel();
    await _client?.disconnect();
    return super.close();
  }
}
