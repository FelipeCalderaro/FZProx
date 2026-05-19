import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';

// ── C API exposed by fzprox_audio.dll ─────────────────────────────────────
// bool fzp_start_mic_capture(int device_index)
// bool fzp_start_loopback_capture(int device_index)
// bool fzp_start_process_capture(unsigned pid)
// bool fzp_read_capture_frame(int16_t* buf)   // buf = 960 samples
// void fzp_stop_capture()
// bool fzp_start_playback(int device_index)   // -1 = default
// void fzp_write_playback_frame(int16_t* left, int16_t* right)
// void fzp_stop_playback()
// char* fzp_list_input_devices()   // caller must fzp_free_string
// char* fzp_list_output_devices()
// char* fzp_list_audio_sessions()
// void  fzp_free_string(char* s)
// char* fzp_last_error()

// ── Native function types (use dart:ffi primitives only) ──────────────────

typedef FzpStartDeviceNative = Bool Function(Int32 deviceIndex);
typedef FzpStartDevice       = bool Function(int   deviceIndex);

typedef FzpStartProcessNative = Bool Function(Uint32 pid);
typedef FzpStartProcess       = bool Function(int    pid);

typedef FzpReadFrameNative = Bool Function(Pointer<Int16> buf);
typedef FzpReadFrame       = bool Function(Pointer<Int16> buf);

typedef FzpVoidNative = Void Function();
typedef FzpVoid       = void Function();

typedef FzpStartPlaybackNative = Bool Function(Int32 deviceIndex);
typedef FzpStartPlayback       = bool Function(int   deviceIndex);

typedef FzpWritePlaybackNative = Void Function(Pointer<Int16> left, Pointer<Int16> right);
typedef FzpWritePlayback       = void Function(Pointer<Int16> left, Pointer<Int16> right);

// For string return: native char* is Pointer<Char>
typedef FzpListStrNative  = Pointer<Char> Function();
typedef FzpListStr        = Pointer<Char> Function();

typedef FzpFreeStringNative = Void Function(Pointer<Char> s);
typedef FzpFreeString       = void Function(Pointer<Char> s);

// ── Binding class ─────────────────────────────────────────────────────────

class NativeAudio {
  static NativeAudio? _instance;
  static NativeAudio get instance => _instance ??= NativeAudio._();

  late final DynamicLibrary _lib;

  late final FzpStartDevice    startMicCapture;
  late final FzpStartDevice    startLoopbackCapture;
  late final FzpStartProcess   startProcessCapture;
  late final FzpReadFrame      _readCaptureFrame;
  late final FzpVoid           stopCapture;
  late final FzpStartPlayback  startPlayback;
  late final FzpWritePlayback  _writePlaybackFrame;
  late final FzpVoid           stopPlayback;
  late final FzpListStr        _listInputDevices;
  late final FzpListStr        _listOutputDevices;
  late final FzpListStr        _listAudioSessions;
  late final FzpFreeString     _freeString;
  late final FzpListStr        _lastErrorFn;

  NativeAudio._() {
    final dll = Platform.isWindows ? 'fzprox_audio.dll' : 'libfzprox_audio.so';
    _lib = DynamicLibrary.open(dll);

    startMicCapture     = _lib.lookupFunction<FzpStartDeviceNative,  FzpStartDevice>  ('fzp_start_mic_capture');
    startLoopbackCapture= _lib.lookupFunction<FzpStartDeviceNative,  FzpStartDevice>  ('fzp_start_loopback_capture');
    startProcessCapture = _lib.lookupFunction<FzpStartProcessNative, FzpStartProcess> ('fzp_start_process_capture');
    _readCaptureFrame   = _lib.lookupFunction<FzpReadFrameNative,    FzpReadFrame>    ('fzp_read_capture_frame');
    stopCapture         = _lib.lookupFunction<FzpVoidNative,         FzpVoid>         ('fzp_stop_capture');
    startPlayback       = _lib.lookupFunction<FzpStartPlaybackNative,FzpStartPlayback>('fzp_start_playback');
    _writePlaybackFrame = _lib.lookupFunction<FzpWritePlaybackNative,FzpWritePlayback>('fzp_write_playback_frame');
    stopPlayback        = _lib.lookupFunction<FzpVoidNative,         FzpVoid>         ('fzp_stop_playback');
    _listInputDevices   = _lib.lookupFunction<FzpListStrNative,      FzpListStr>      ('fzp_list_input_devices');
    _listOutputDevices  = _lib.lookupFunction<FzpListStrNative,      FzpListStr>      ('fzp_list_output_devices');
    _listAudioSessions  = _lib.lookupFunction<FzpListStrNative,      FzpListStr>      ('fzp_list_audio_sessions');
    _freeString         = _lib.lookupFunction<FzpFreeStringNative,   FzpFreeString>   ('fzp_free_string');
    _lastErrorFn        = _lib.lookupFunction<FzpListStrNative,      FzpListStr>      ('fzp_last_error');
  }

  String _consumeStr(Pointer<Char> ptr) {
    if (ptr == nullptr) return '';
    final s = ptr.cast<Utf8>().toDartString();
    _freeString(ptr);
    return s;
  }

  String listInputDevicesJson()  => _consumeStr(_listInputDevices());
  String listOutputDevicesJson() => _consumeStr(_listOutputDevices());
  String listAudioSessionsJson() => _consumeStr(_listAudioSessions());
  String lastError()             => _lastErrorFn().cast<Utf8>().toDartString();

  /// Reads one 960-sample int16 mono frame. Returns null if buffer is empty.
  Int16List? readFrame() {
    final ptr = calloc<Int16>(960);
    try {
      if (!_readCaptureFrame(ptr)) return null;
      return Int16List.fromList(ptr.asTypedList(960));
    } finally {
      calloc.free(ptr);
    }
  }

  /// Writes one stereo frame (960 samples per channel) to the playback buffer.
  void writeFrame(Int16List left, Int16List right) {
    final pL = calloc<Int16>(960);
    final pR = calloc<Int16>(960);
    try {
      pL.asTypedList(960).setAll(0, left);
      pR.asTypedList(960).setAll(0, right);
      _writePlaybackFrame(pL, pR);
    } finally {
      calloc.free(pL);
      calloc.free(pR);
    }
  }
}
