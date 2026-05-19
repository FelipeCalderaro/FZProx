import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_device_info.freezed.dart';

enum AudioInputMode { mic, loopback, processCapture }

@freezed
class AudioDeviceInfo with _$AudioDeviceInfo {
  const factory AudioDeviceInfo({
    required int    index,
    required String name,
    @Default(false) bool isOutput,
    @Default(false) bool isLoopback,
  }) = _AudioDeviceInfo;
}

@freezed
class AudioSessionInfo with _$AudioSessionInfo {
  const factory AudioSessionInfo({
    required int    pid,
    required String exeName,
    required String displayName,
    required int    loopbackIndex,
    required String deviceName,
    @Default(1) int sharedWith,
  }) = _AudioSessionInfo;
}
