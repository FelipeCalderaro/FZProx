part of 'setup_bloc.dart';

enum SetupStep { identity, audioInput, audioOutput, proximity }

@freezed
class SetupState with _$SetupState {
  /// Initial state before device enumeration completes.
  const factory SetupState.initial() = SetupInitial;

  /// Device lists are being loaded from the audio engine.
  const factory SetupState.loadingDevices() = SetupLoadingDevices;

  /// Step 1: username + hub address.
  const factory SetupState.identity({
    @Default('') String username,
    @Default(kDefaultHubHost) String hubHost,
    @Default(kDefaultHubPort) int    hubPort,
    @Default([]) List<AudioDeviceInfo>  inputDevices,
    @Default([]) List<AudioDeviceInfo>  outputDevices,
    @Default([]) List<AudioSessionInfo> audioSessions,
  }) = SetupIdentityState;

  /// Step 2: audio input selection.
  const factory SetupState.audioInput({
    required String username,
    required String hubHost,
    required int    hubPort,
    required List<AudioDeviceInfo>  inputDevices,
    required List<AudioDeviceInfo>  outputDevices,
    required List<AudioSessionInfo> audioSessions,
    @Default(AudioInputMode.mic) AudioInputMode selectedMode,
    AudioDeviceInfo?  selectedInputDevice,
    AudioSessionInfo? selectedSession,
  }) = SetupAudioInputState;

  /// Step 3: audio output selection.
  const factory SetupState.audioOutput({
    required String username,
    required String hubHost,
    required int    hubPort,
    required AudioInputMode  inputMode,
    AudioDeviceInfo?         inputDevice,
    AudioSessionInfo?        audioSession,
    required List<AudioDeviceInfo> outputDevices,
    AudioDeviceInfo? selectedOutputDevice,
  }) = SetupAudioOutputState;

  /// Step 4: proximity parameters.
  const factory SetupState.proximity({
    required String          username,
    required String          hubHost,
    required int             hubPort,
    required AudioInputMode  inputMode,
    AudioDeviceInfo?         inputDevice,
    AudioSessionInfo?        audioSession,
    AudioDeviceInfo?         outputDevice,
    @Default(ProximityParams()) ProximityParams params,
  }) = SetupProximityState;

  /// Wizard complete — config is ready to use.
  const factory SetupState.complete({
    required SetupConfig config,
  }) = SetupCompleteState;

  /// An error occurred (device enumeration failure, etc.).
  const factory SetupState.error({
    required String message,
  }) = SetupErrorState;
}
