import 'dart:convert';
import 'dart:typed_data';

// ── C→H message types ──────────────────────────────────────────────────────
const int kC2hList  = 0x01;
const int kC2hHello = 0x02;
const int kC2hState = 0x03;
const int kC2hAudio = 0x04;

// ── H→C message types ──────────────────────────────────────────────────────
const int kH2cRoomList   = 0x10;
const int kH2cWelcome    = 0x11;
const int kH2cPeerJoined = 0x12;
const int kH2cPeerLeft   = 0x13;
const int kH2cPeerState  = 0x14;
const int kH2cPeerAudio  = 0x15;
const int kH2cError      = 0x16;

// ── Audio constants ─────────────────────────────────────────────────────────
const int kSampleRate      = 48000;
const int kFrameSamples    = 960;   // 20 ms @ 48 kHz
const int kPcmBytes        = 1920;  // kFrameSamples × 2 (int16)
const int kMaxBufferFrames = 12;    // ~240 ms

// ── Session limits ──────────────────────────────────────────────────────────
const int kMaxPlayersPerRoom = 8;

// ── Defaults ─────────────────────────────────────────────────────────────────
const String kDefaultHubHost    = 'localhost';
const int    kDefaultHubPort    = 9200;
const int    kDefaultTelemetryPort = 9988;

// ── Header framing ───────────────────────────────────────────────────────────
// Layout: [1B msg_type][2B payload_len big-endian][payload…]
const int kHeaderBytes = 3;

/// Wraps [payload] in the 3-byte protocol header.
Uint8List encodeMessage(int msgType, Uint8List payload) {
  final buf = Uint8List(kHeaderBytes + payload.length);
  buf[0] = msgType;
  buf[1] = (payload.length >> 8) & 0xFF;
  buf[2] = payload.length & 0xFF;
  buf.setRange(kHeaderBytes, buf.length, payload);
  return buf;
}

/// Empty-payload message (e.g. LIST).
Uint8List encodeEmpty(int msgType) => encodeMessage(msgType, Uint8List(0));

/// HELLO: [4B ASCII room-code][UTF-8 username ≤32B]
Uint8List encodeHello(String roomCode, String username) {
  assert(roomCode.length == 4, 'Room code must be exactly 4 characters');
  final nameBytes = utf8.encode(username);
  assert(nameBytes.length <= 32, 'Username must be ≤32 bytes UTF-8');
  final payload = Uint8List(4 + nameBytes.length);
  for (var i = 0; i < 4; i++) {
    payload[i] = roomCode.codeUnitAt(i);
  }
  payload.setRange(4, payload.length, nameBytes);
  return encodeMessage(kC2hHello, payload);
}

/// STATE: struct "<ffff" → x, z, yaw, speed (16 bytes, little-endian)
Uint8List encodeState(double x, double z, double yaw, double speed) {
  final bd = ByteData(16);
  bd.setFloat32(0,  x,     Endian.little);
  bd.setFloat32(4,  z,     Endian.little);
  bd.setFloat32(8,  yaw,   Endian.little);
  bd.setFloat32(12, speed, Endian.little);
  return encodeMessage(kC2hState, bd.buffer.asUint8List());
}

/// AUDIO: raw 1920-byte PCM frame.
Uint8List encodeAudio(Uint8List pcmBytes) {
  assert(pcmBytes.length == kPcmBytes);
  return encodeMessage(kC2hAudio, pcmBytes);
}

// ── Parsing helpers ───────────────────────────────────────────────────────────

/// Decode the 2-byte big-endian payload length from bytes [1] and [2].
int payloadLength(List<int> header) => (header[1] << 8) | header[2];

/// Parse PEER_STATE payload (id[1] + "<ffff"[16] = 17 bytes).
({int id, double x, double z, double yaw, double speed}) parsePeerState(Uint8List p) {
  final id = p[0];
  final bd = ByteData.sublistView(p, 1);
  return (
    id:    id,
    x:     bd.getFloat32(0,  Endian.little),
    z:     bd.getFloat32(4,  Endian.little),
    yaw:   bd.getFloat32(8,  Endian.little),
    speed: bd.getFloat32(12, Endian.little),
  );
}

/// Parse PEER_JOINED payload: id[1] + name_len[1] + name_bytes.
({int id, String name}) parsePeerJoined(Uint8List p) {
  final id      = p[0];
  final nameLen = p[1];
  final name    = utf8.decode(p.sublist(2, 2 + nameLen));
  return (id: id, name: name);
}

/// Parse WELCOME payload:
/// self_id[1] + code[4] + n_peers[1] + [id[1]+name_len[1]+name]*
({int selfId, String code, List<({int id, String name})> peers}) parseWelcome(Uint8List p) {
  final selfId = p[0];
  final code   = String.fromCharCodes(p.sublist(1, 5));
  final nPeers = p[5];
  var offset   = 6;
  final peers  = <({int id, String name})>[];
  for (var i = 0; i < nPeers; i++) {
    final id      = p[offset];
    final nameLen = p[offset + 1];
    final name    = utf8.decode(p.sublist(offset + 2, offset + 2 + nameLen));
    peers.add((id: id, name: name));
    offset += 2 + nameLen;
  }
  return (selfId: selfId, code: code, peers: peers);
}

/// Parse ROOM_LIST payload: n[1] + [code[4]+n_players[1]]*n
List<({String code, int playerCount})> parseRoomList(Uint8List p) {
  final n      = p[0];
  var offset   = 1;
  final rooms  = <({String code, int playerCount})>[];
  for (var i = 0; i < n; i++) {
    final code        = String.fromCharCodes(p.sublist(offset, offset + 4));
    final playerCount = p[offset + 4];
    rooms.add((code: code, playerCount: playerCount));
    offset += 5;
  }
  return rooms;
}

/// Generates a random 4-character uppercase alphanumeric room code.
String generateRoomCode() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final buf   = StringBuffer();
  final rng   = DateTime.now().millisecondsSinceEpoch;
  for (var i = 0; i < 4; i++) {
    buf.writeCharCode(chars.codeUnitAt((rng >> (i * 6)) % chars.length));
  }
  return buf.toString();
}
