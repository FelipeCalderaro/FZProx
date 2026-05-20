import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:opus_dart/opus_dart.dart';

/// Wraps opus_dart encoder + decoder for 20 ms mono 48 kHz frames (960 samples).
///
/// The native `libopus_x64.dll` is installed next to the application executable
/// by CMake (see windows/CMakeLists.txt).  We open it with [DynamicLibrary.open]
/// the same way the WASAPI DLL is loaded.
///
/// Call [init] once at app startup (or lazily before first use).
/// Both [encode] and [decode] are synchronous after initialisation.
class OpusCodecService {
  OpusCodecService._();
  static final OpusCodecService instance = OpusCodecService._();

  /// Set to false to force raw-PCM mode regardless of whether the codec loaded.
  /// Flip to true to re-enable Opus compression.
  static const bool kEnabled = false;

  bool _ready = false;
  SimpleOpusEncoder? _encoder;
  SimpleOpusDecoder? _decoder;

  static const int _sampleRate = 48000;
  static const int _channels   = 1;

  /// Loads the native Opus library and creates encoder + decoder.
  /// Safe to call multiple times — subsequent calls are no-ops.
  Future<void> init() async {
    if (_ready) return;
    try {
      // Resolve path relative to the running executable so it works in both
      // debug (build/windows/x64/runner/Debug/) and release layouts.
      final exeDir = File(Platform.resolvedExecutable).parent.path;
      final lib    = DynamicLibrary.open('$exeDir\\libopus_x64.dll');
      // opus_dart's initOpus signature uses web_ffi's DynamicLibrary proxy
      // type; cast to dynamic so dart:ffi's native DynamicLibrary is accepted.
      initOpus(lib as dynamic);
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
    } catch (e) {
      // Not fatal — sender/receiver will fall back to raw PCM.
      // ignore: avoid_print
      print('[OpusCodecService] Failed to load libopus_x64.dll: $e');
    }
  }

  bool get isReady => kEnabled && _ready;

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
