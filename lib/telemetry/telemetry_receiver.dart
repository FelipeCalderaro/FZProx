import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

// ── Forza Horizon 6 packet layout (324 bytes, little-endian) ─────────────────
//  Offset  Field
//  0       IsRaceOn   (int32)
//  4       TimestampMS (uint32)
//  56      Yaw        (float32)
//  60      Pitch      (float32)
//  64      Roll       (float32)
//  244     PositionX  (float32)
//  248     PositionY  (float32)
//  252     PositionZ  (float32)
//  256     Speed      (float32, m/s)

const int _kPacketSize  = 324;
const int _kOffIsRaceOn = 0;
const int _kOffTs       = 4;
const int _kOffYaw      = 56;
const int _kOffPitch    = 60;
const int _kOffRoll     = 64;
const int _kOffX        = 244;
const int _kOffY        = 248;
const int _kOffZ        = 252;
const int _kOffSpeed    = 256;

const double _kAlpha = 0.3; // EMA coefficient for position smoothing

class CarState {
  final double x, y, z, yaw, pitch, roll, speed;
  final bool   isRaceOn;
  final int    timestampMs;

  const CarState({
    required this.x,
    required this.y,
    required this.z,
    required this.yaw,
    required this.pitch,
    required this.roll,
    required this.speed,
    required this.isRaceOn,
    required this.timestampMs,
  });
}

/// Parses a 324-byte FH6 telemetry datagram. Returns null on invalid input.
CarState? parseTelemetryPacket(Uint8List buf) {
  if (buf.length != _kPacketSize) return null;
  final bd = ByteData.sublistView(buf);
  return CarState(
    x:           bd.getFloat32(_kOffX,     Endian.little),
    y:           bd.getFloat32(_kOffY,     Endian.little),
    z:           bd.getFloat32(_kOffZ,     Endian.little),
    yaw:         bd.getFloat32(_kOffYaw,   Endian.little),
    pitch:       bd.getFloat32(_kOffPitch, Endian.little),
    roll:        bd.getFloat32(_kOffRoll,  Endian.little),
    speed:       bd.getFloat32(_kOffSpeed, Endian.little),
    isRaceOn:    bd.getInt32(_kOffIsRaceOn, Endian.little) != 0,
    timestampMs: bd.getUint32(_kOffTs,     Endian.little),
  );
}

/// Listens on UDP port [listenPort] for Forza telemetry datagrams.
/// Applies EMA smoothing (α=0.3) and notifies callers via [onUpdate] / [onStale].
class TelemetryReceiver {
  final int      listenPort;
  final void Function(CarState) onUpdate;
  final void Function()         onStale;

  RawDatagramSocket? _socket;
  Timer?             _staleTimer;
  bool               _started = false;

  // EMA state
  double _x = 0, _y = 0, _z = 0;
  double _yaw = 0, _pitch = 0, _roll = 0, _speed = 0;
  bool   _initialised = false;

  TelemetryReceiver({
    this.listenPort = 9988,
    required this.onUpdate,
    required this.onStale,
  });

  Future<void> start() async {
    if (_started) return;
    _started = true;
    _socket  = await RawDatagramSocket.bind(
        InternetAddress.loopbackIPv4, listenPort);
    _socket!.listen(_onData);
    _resetStaleTimer();
  }

  void _onData(RawSocketEvent event) {
    if (event != RawSocketEvent.read) return;
    final dg = _socket?.receive();
    if (dg == null) return;
    final state = parseTelemetryPacket(dg.data);
    if (state == null) return;

    _resetStaleTimer();

    if (!_initialised) {
      _x = state.x; _y = state.y; _z = state.z;
      _yaw = state.yaw; _pitch = state.pitch;
      _roll = state.roll; _speed = state.speed;
      _initialised = true;
    } else {
      _x     = _kAlpha * state.x     + (1 - _kAlpha) * _x;
      _y     = _kAlpha * state.y     + (1 - _kAlpha) * _y;
      _z     = _kAlpha * state.z     + (1 - _kAlpha) * _z;
      _yaw   = _kAlpha * state.yaw   + (1 - _kAlpha) * _yaw;
      _pitch = _kAlpha * state.pitch + (1 - _kAlpha) * _pitch;
      _roll  = _kAlpha * state.roll  + (1 - _kAlpha) * _roll;
      _speed = _kAlpha * state.speed + (1 - _kAlpha) * _speed;
    }

    onUpdate(CarState(
      x: _x, y: _y, z: _z,
      yaw: _yaw, pitch: _pitch, roll: _roll,
      speed: _speed,
      isRaceOn:    state.isRaceOn,
      timestampMs: state.timestampMs,
    ));
  }

  void _resetStaleTimer() {
    _staleTimer?.cancel();
    _staleTimer = Timer(
      const Duration(milliseconds: 500),
      onStale,
    );
  }

  void stop() {
    _staleTimer?.cancel();
    _socket?.close();
    _socket  = null;
    _started = false;
  }
}
