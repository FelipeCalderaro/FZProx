import 'dart:typed_data';

import 'package:opus_dart/opus_dart.dart';
import 'package:opus_flutter/opus_flutter.dart' as opus_flutter;

/// Wraps opus_dart encoder + decoder for 20 ms mono 48 kHz frames (960 samples).
///
/// Call [init] once at app startup (or lazily before first use).
/// Both [encode] and [decode] are synchronous and safe to call from any isolate
/// once the library has been loaded (loading itself is async).
class OpusCodecService {
  OpusCodecService._();
  static final OpusCodecService instance = OpusCodecService._();

  bool _ready = false;
  SimpleOpusEncoder? _encoder;
  SimpleOpusDecoder? _decoder;

  static const int _sampleRate = 48000;
  static const int _channels   = 1;

  /// Loads the native Opus library and creates encoder + decoder.
  /// Safe to call multiple times — subsequent calls are no-ops.
  Future<void> init() async {
    if (_ready) return;
    final lib = await opus_flutter.load();
    initOpus(lib);
    _encoder = SimpleOpusEncoder(
      sampleRate:  _sampleRate,
      channels:    _channels,
      application: Application.voip,
    );
    _decoder = SimpleOpusDecoder(
      sampleRate: _sampleRate,
      channels:   _channels,
    );
    _ready = true;
  }

  bool get isReady => _ready;

  /// Encodes a 960-sample Int16List to an Opus packet (typically 20–80 bytes).
  /// Returns null if the codec is not yet initialised.
  Uint8List? encode(Int16List pcm) {
    if (!_ready) return null;
    return _encoder!.encode(input: pcm);
  }

  /// Decodes an Opus packet back to 960 Int16 samples.
  /// Returns silence (all zeros) if the codec is not ready or decoding fails.
  Int16List decode(Uint8List packet) {
    if (!_ready) return Int16List(960);
    try {
      return _decoder!.decode(input: packet);
    } catch (_) {
      return Int16List(960);
    }
  }

  void dispose() {
    _encoder?.destroy();
    _decoder?.destroy();
    _encoder = null;
    _decoder = null;
    _ready   = false;
  }
}
