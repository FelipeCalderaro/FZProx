import 'dart:io';
import 'dart:typed_data';

/// Represents one connected player on the hub side.
class HubPlayer {
  final int    id;
  final String name;
  final String roomCode;
  final Socket socket;

  HubPlayer({
    required this.id,
    required this.name,
    required this.roomCode,
    required this.socket,
  });

  Future<void> send(Uint8List data) async {
    try {
      socket.add(data);
      await socket.flush();
    } catch (_) {
      // Swallow write errors — the player's own read handler will clean up
    }
  }
}
