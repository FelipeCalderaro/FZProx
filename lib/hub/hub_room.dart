import 'dart:typed_data';

import '../protocol/protocol.dart';
import 'hub_player.dart';

/// Manages all players in a single room. The hub is a dumb relay — it never
/// interprets audio or position data, only fans it out.
class HubRoom {
  final String               code;
  final Map<int, HubPlayer>  players = {};

  HubRoom(this.code);

  bool get isEmpty => players.isEmpty;
  int  get count   => players.length;

  void add(HubPlayer p)    => players[p.id] = p;
  void remove(int playerId) => players.remove(playerId);

  /// Sends [msg] to every player except [excludeId].
  Future<void> broadcast(Uint8List msg, {required int excludeId}) async {
    for (final p in players.values) {
      if (p.id != excludeId) await p.send(msg);
    }
  }

  /// Encodes and broadcasts PEER_LEFT for [leftId].
  Future<void> broadcastPeerLeft(int leftId) async {
    final payload = encodeMessage(kH2cPeerLeft, Uint8List.fromList([leftId]));
    await broadcast(payload, excludeId: leftId);
  }

  /// Encodes and broadcasts PEER_JOINED for [joined] to everyone else.
  Future<void> broadcastPeerJoined(HubPlayer joined) async {
    final nameBytes = joined.name.codeUnits;
    final payload   = Uint8List(2 + nameBytes.length)
      ..[0] = joined.id
      ..[1] = nameBytes.length;
    payload.setRange(2, payload.length, nameBytes);
    await broadcast(
        encodeMessage(kH2cPeerJoined, payload), excludeId: joined.id);
  }
}
