import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../protocol/protocol.dart';
import 'hub_player.dart';
import 'hub_room.dart';

/// Dumb relay hub. Forwards audio + state frames to every other room member.
/// Never reads or modifies audio data.
class HubServer {
  final int port;

  ServerSocket?               _server;
  final Map<String, HubRoom>  _rooms = {};
  int                         _nextId = 1;
  bool                        _running = false;

  HubServer({this.port = kDefaultHubPort});

  bool get isRunning  => _running;
  int  get roomCount  => _rooms.length;

  List<({String code, int count})> get roomSummaries =>
      _rooms.values.map((r) => (code: r.code, count: r.count)).toList();

  // ── Lifecycle ──────────────────────────────────────────────────────────

  Future<void> start() async {
    _server  = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    _running = true;
    _server!.listen(_handleClient);
  }

  Future<void> stop() async {
    _running = false;
    await _server?.close();
    _server = null;
    _rooms.clear();
  }

  // ── Client handler ────────────────────────────────────────────────────

  Future<void> _handleClient(Socket socket) async {
    socket.setOption(SocketOption.tcpNoDelay, true);
    final reader = _FrameReader();
    HubPlayer? player;

    final joinTimeout = Timer(const Duration(seconds: 30), () {
      if (player == null) socket.close();
    });

    try {
      await for (final data in socket) {
        reader.add(data);
        HubMessage? msg;
        while ((msg = reader.tryRead()) != null) {
          if (player == null) {
            final done = await _handlePreJoin(socket, msg!, (p) {
              joinTimeout.cancel();
              player = p;
            });
            if (done) break;
          } else {
            await _handleRelay(player!, msg!);
          }
        }
      }
    } catch (_) {
      // socket closed
    } finally {
      joinTimeout.cancel();
      if (player != null) await _deregister(player!);
      try { socket.close(); } catch (_) {}
    }
  }

  Future<bool> _handlePreJoin(
      Socket socket, HubMessage msg, void Function(HubPlayer) onJoined) async {
    switch (msg.type) {
      case kC2hList:
        socket.add(_buildRoomList()); // add() returns void — no await
        await socket.flush();
        return false;

      case kC2hHello:
        final roomCode = String.fromCharCodes(msg.payload.sublist(0, 4));
        final username = utf8.decode(msg.payload.sublist(4));

        final room = _rooms.putIfAbsent(roomCode, () => HubRoom(roomCode));
        if (room.count >= kMaxPlayersPerRoom) {
          await _sendError(socket, 'Room $roomCode is full');
          return false;
        }

        final id     = _allocId();
        final player = HubPlayer(
            id: id, name: username, roomCode: roomCode, socket: socket);
        room.add(player);

        await _sendWelcome(socket, player, room);
        await room.broadcastPeerJoined(player);
        onJoined(player);
        return true;
    }
    return false;
  }

  Future<void> _handleRelay(HubPlayer player, HubMessage msg) async {
    final room = _rooms[player.roomCode];
    if (room == null) return;

    switch (msg.type) {
      case kC2hAudio:
        final payload = Uint8List(1 + msg.payload.length);
        payload[0] = player.id;
        payload.setRange(1, payload.length, msg.payload);
        await room.broadcast(
            encodeMessage(kH2cPeerAudio, payload), excludeId: player.id);

      case kC2hState:
        final payload = Uint8List(1 + msg.payload.length);
        payload[0] = player.id;
        payload.setRange(1, payload.length, msg.payload);
        await room.broadcast(
            encodeMessage(kH2cPeerState, payload), excludeId: player.id);

      case kC2hList:
        await _playerSend(player, _buildRoomList());
    }
  }

  Future<void> _playerSend(HubPlayer player, Uint8List data) async {
    player.socket.add(data);
    await player.socket.flush();
  }

  // ── Registration ───────────────────────────────────────────────────────

  Future<void> _deregister(HubPlayer player) async {
    final room = _rooms[player.roomCode];
    if (room == null) return;
    room.remove(player.id);
    await room.broadcastPeerLeft(player.id);
    if (room.isEmpty) _rooms.remove(player.roomCode);
  }

  // ── Wire helpers ───────────────────────────────────────────────────────

  Uint8List _buildRoomList() {
    final rooms   = _rooms.values.toList();
    final payload = Uint8List(1 + rooms.length * 5);
    payload[0]    = rooms.length;
    for (var i = 0; i < rooms.length; i++) {
      final offset = 1 + i * 5;
      final code   = rooms[i].code.padRight(4).substring(0, 4);
      for (var j = 0; j < 4; j++) {
        payload[offset + j] = code.codeUnitAt(j);
      }
      payload[offset + 4] = rooms[i].count;
    }
    return encodeMessage(kH2cRoomList, payload);
  }

  Future<void> _sendWelcome(Socket socket, HubPlayer self, HubRoom room) async {
    final peers = room.players.values.where((p) => p.id != self.id).toList();
    var payloadLen = 1 + 4 + 1; // selfId + code(4B) + nPeers
    for (final p in peers) { payloadLen += 2 + p.name.length; }

    final payload = Uint8List(payloadLen);
    var off = 0;
    payload[off++] = self.id;
    for (var j = 0; j < 4; j++) {
      payload[off++] = room.code.codeUnitAt(j);
    }
    payload[off++] = peers.length;
    for (final p in peers) {
      payload[off++] = p.id;
      payload[off++] = p.name.length;
      for (final ch in p.name.codeUnits) {
        payload[off++] = ch;
      }
    }
    socket.add(encodeMessage(kH2cWelcome, payload));
    await socket.flush();
  }

  Future<void> _sendError(Socket socket, String msg) async {
    socket.add(encodeMessage(kH2cError, Uint8List.fromList(utf8.encode(msg))));
    await socket.flush();
  }

  int _allocId() {
    final id = _nextId;
    _nextId  = (_nextId % 254) + 1;
    return id;
  }
}

// ── Internal frame reader ──────────────────────────────────────────────────

class HubMessage {
  final int      type;
  final Uint8List payload;
  const HubMessage(this.type, this.payload);
}

class _FrameReader {
  final _buf = Queue<int>();

  void add(List<int> data) {
    for (final b in data) {
      _buf.add(b);
    }
  }

  HubMessage? tryRead() {
    if (_buf.length < kHeaderBytes) return null;
    final b0  = _buf.elementAt(0);
    final b1  = _buf.elementAt(1);
    final b2  = _buf.elementAt(2);
    final len = (b1 << 8) | b2;
    if (_buf.length < kHeaderBytes + len) return null;
    _buf.removeFirst(); _buf.removeFirst(); _buf.removeFirst();
    final payload = Uint8List(len);
    for (var i = 0; i < len; i++) {
      payload[i] = _buf.removeFirst();
    }
    return HubMessage(b0, payload);
  }
}
