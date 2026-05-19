part of 'setup_bloc.dart';

@freezed
class SetupEvent with _$SetupEvent {
  const factory SetupEvent.started({
    String? prefilledHost,
    int?    prefilledPort,
  }) = SetupStarted;

  /// Re-enumerate audio sessions while already on the Audio Input step.
  const factory SetupEvent.devicesRefreshed() = SetupDevicesRefreshed;

  const factory SetupEvent.identitySubmitted({
    required String username,
    required String hubHost,
    required int    hubPort,
  }) = SetupIdentitySubmitted;

  const factory SetupEvent.audioInputSelected({
    required AudioInputMode inputMode,
    AudioDeviceInfo?        inputDevice,
    AudioSessionInfo?       audioSession,
  }) = SetupAudioInputSelected;

  const factory SetupEvent.audioOutputSelected({
    AudioDeviceInfo? outputDevice, // null = system default
  }) = SetupAudioOutputSelected;

  const factory SetupEvent.proximitySubmitted({
    required ProximityParams params,
  }) = SetupProximitySubmitted;

  const factory SetupEvent.backPressed() = SetupBackPressed;
}
