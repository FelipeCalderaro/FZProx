import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import '../protocol/protocol.dart';

/// A single decoded frame received from the hub.
class HubMessage {
  final int      type;
  final Uint8List payload;
  const HubMessage(this.type, this.payload);
}

/// Buffers raw socket bytes and emits complete [HubMessage]s.
class _FrameReader {
  final _buf = Queue<int>();

  void add(List<int> data) {
    for (final b in data) { _buf.add(b); }
  }

  HubMessage? tryRead() {
    if (_buf.length < kHeaderBytes) return null;
    final b0 = _buf.elementAt(0);
    final b1 = _buf.elementAt(1);
    final b2 = _buf.elementAt(2);
    final payloadLen = (b1 << 8) | b2;
    if (_buf.length < kHeaderBytes + payloadLen) return null;

    // Consume header
    _buf.removeFirst(); _buf.removeFirst(); _buf.removeFirst();

    final payload = Uint8List(payloadLen);
    for (var i = 0; i < payloadLen; i++) {
      payload[i] = _buf.removeFirst();
    }
    return HubMessage(b0, payload);
  }
}

/// Manages the TCP connection to the HorizonProx hub.
/// Exposes a broadcast stream of decoded [HubMessage]s.
class HorizonClient {
  final String host;
  final int    port;

  Socket?                              _socket;
  final _FrameReader                   _reader = _FrameReader();
  final StreamController<HubMessage>  _ctrl   =
      StreamController<HubMessage>.broadcast();
  StreamSubscription<dynamic>?        _sub;

  HorizonClient({required this.host, required this.port});

  Stream<HubMessage> get messages => _ctrl.stream;
  bool get isConnected            => _socket != null;

  Future<void> connect() async {
    _socket = await Socket.connect(host, port,
        timeout: const Duration(seconds: 5));
    _socket!.setOption(SocketOption.tcpNoDelay, true);
    _sub = _socket!.listen(
      (data) {
        _reader.add(data);
        HubMessage? msg;
        while ((msg = _reader.tryRead()) != null) {
          _ctrl.add(msg!);
        }
      },
      onError: (e) {
        _ctrl.addError(e);
        _closeSocket();
      },
      onDone: () {
        _ctrl.addError(const SocketException('Hub closed connection'));
        _closeSocket();
      },
    );
  }

  // ── Send helpers ──────────────────────────────────────────────────────

  Future<void> sendListRooms() => _send(encodeEmpty(kC2hList));

  Future<void> sendHello(String code, String username) =>
      _send(encodeHello(code, username));

  Future<void> sendState(double x, double z, double yaw, double speed) =>
      _send(encodeState(x, z, yaw, speed));

  Future<void> sendAudio(Uint8List pcm) => _send(encodeAudio(pcm));

  Future<void> _send(Uint8List data) async {
    if (_socket == null) return;
    try {
      _socket!.add(data);
      await _socket!.flush();
    } catch (_) {
      // write error: the listener's onError will handle cleanup
    }
  }

  // ── Teardown ──────────────────────────────────────────────────────────

  Future<void> disconnect() async {
    await _sub?.cancel();
    await _closeSocket();
  }

  Future<void> _closeSocket() async {
    try { await _socket?.close(); } catch (_) {}
    _socket = null;
  }

  Future<void> dispose() async {
    await disconnect();
    await _ctrl.close();
  }
}
