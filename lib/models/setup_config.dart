import 'package:freezed_annotation/freezed_annotation.dart';
import 'audio_device_info.dart';
import 'proximity_params.dart';

part 'setup_config.freezed.dart';

@freezed
class SetupConfig with _$SetupConfig {
  const factory SetupConfig({
    required String         username,
    required String         hubHost,
    required int            hubPort,
    required AudioInputMode inputMode,
    // For mic / loopback mode
    AudioDeviceInfo?        inputDevice,
    // For per-process mode
    AudioSessionInfo?       audioSession,
    // Output device (null = system default)
    AudioDeviceInfo?        outputDevice,
    required ProximityParams proximity,
  }) = _SetupConfig;
}
