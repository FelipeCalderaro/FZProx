import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/audio_device_info.dart';
import '../../models/proximity_params.dart';
import '../../models/setup_config.dart';
import '../../audio/audio_engine.dart';
import '../../protocol/protocol.dart';
import '../../services/settings_service.dart';

part 'setup_bloc.freezed.dart';
part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final AudioEngine _audioEngine;

  SetupBloc({AudioEngine? audioEngine})
      : _audioEngine = audioEngine ?? AudioEngine(),
        super(const SetupState.initial()) {
    on<SetupStarted>(_onStarted);
    on<SetupDevicesRefreshed>(_onDevicesRefreshed);
    on<SetupIdentitySubmitted>(_onIdentitySubmitted);
    on<SetupAudioInputSelected>(_onAudioInputSelected);
    on<SetupAudioOutputSelected>(_onAudioOutputSelected);
    on<SetupProximitySubmitted>(_onProximitySubmitted);
    on<SetupBackPressed>(_onBackPressed);
  }

  Future<void> _onStarted(
      SetupStarted event, Emitter<SetupState> emit) async {
    emit(const SetupState.loadingDevices());
    try {
      final saved         = await SettingsService.instance.load();
      final inputDevices  = await _audioEngine.listInputDevices();
      final outputDevices = await _audioEngine.listOutputDevices();
      final sessions      = await _audioEngine.listAudioSessions();
      emit(SetupState.identity(
        username:      saved.username     ?? '',
        hubHost:       event.prefilledHost ?? saved.hubHost ?? kDefaultHubHost,
        hubPort:       event.prefilledPort ?? saved.hubPort ?? kDefaultHubPort,
        inputDevices:  inputDevices,
        outputDevices: outputDevices,
        audioSessions: sessions,
      ));
    } catch (e) {
      emit(SetupState.error(message: 'Failed to enumerate audio devices: $e'));
    }
  }

  Future<void> _onDevicesRefreshed(
      SetupDevicesRefreshed event, Emitter<SetupState> emit) async {
    final current = state;
    if (current is! SetupAudioInputState) return;
    try {
      final inputDevices  = await _audioEngine.listInputDevices();
      final outputDevices = await _audioEngine.listOutputDevices();
      final sessions      = await _audioEngine.listAudioSessions();
      emit(current.copyWith(
        inputDevices:  inputDevices,
        outputDevices: outputDevices,
        audioSessions: sessions,
      ));
    } catch (_) {}
  }

  Future<void> _onIdentitySubmitted(
      SetupIdentitySubmitted event, Emitter<SetupState> emit) async {
    final current = state;
    if (current is! SetupIdentityState) return;
    await SettingsService.instance.saveIdentity(
      username: event.username,
      hubHost:  event.hubHost,
      hubPort:  event.hubPort,
    );
    emit(SetupState.audioInput(
      username:      event.username,
      hubHost:       event.hubHost,
      hubPort:       event.hubPort,
      inputDevices:  current.inputDevices,
      outputDevices: current.outputDevices,
      audioSessions: current.audioSessions,
    ));
  }

  Future<void> _onAudioInputSelected(
      SetupAudioInputSelected event, Emitter<SetupState> emit) async {
    final current = state;
    if (current is! SetupAudioInputState) return;
    await SettingsService.instance.saveAudioInput(
      inputMode:    event.inputMode,
      inputDevice:  event.inputDevice,
      audioSession: event.audioSession,
    );
    emit(SetupState.audioOutput(
      username:      current.username,
      hubHost:       current.hubHost,
      hubPort:       current.hubPort,
      inputMode:     event.inputMode,
      inputDevice:   event.inputDevice,
      audioSession:  event.audioSession,
      outputDevices: current.outputDevices,
    ));
  }

  Future<void> _onAudioOutputSelected(
      SetupAudioOutputSelected event, Emitter<SetupState> emit) async {
    final current = state;
    if (current is! SetupAudioOutputState) return;
    await SettingsService.instance.saveAudioOutput(event.outputDevice);
    emit(SetupState.proximity(
      username:     current.username,
      hubHost:      current.hubHost,
      hubPort:      current.hubPort,
      inputMode:    current.inputMode,
      inputDevice:  current.inputDevice,
      audioSession: current.audioSession,
      outputDevice: event.outputDevice,
    ));
  }

  Future<void> _onProximitySubmitted(
      SetupProximitySubmitted event, Emitter<SetupState> emit) async {
    final current = state;
    if (current is! SetupProximityState) return;
    await SettingsService.instance.saveProximity(event.params);
    emit(SetupState.complete(
      config: SetupConfig(
        username:     current.username,
        hubHost:      current.hubHost,
        hubPort:      current.hubPort,
        inputMode:    current.inputMode,
        inputDevice:  current.inputDevice,
        audioSession: current.audioSession,
        outputDevice: current.outputDevice,
        proximity:    event.params,
      ),
    ));
  }

  void _onBackPressed(SetupBackPressed event, Emitter<SetupState> emit) {
    final current = state;
    if (current is SetupAudioInputState) {
      emit(SetupState.identity(
        username:      current.username,
        hubHost:       current.hubHost,
        hubPort:       current.hubPort,
        inputDevices:  current.inputDevices,
        outputDevices: current.outputDevices,
        audioSessions: current.audioSessions,
      ));
    } else if (current is SetupAudioOutputState) {
      emit(SetupState.audioInput(
        username:      current.username,
        hubHost:       current.hubHost,
        hubPort:       current.hubPort,
        inputDevices:  const [],
        outputDevices: current.outputDevices,
        audioSessions: const [],
        selectedMode:  current.inputMode,
        selectedInputDevice: current.inputDevice,
        selectedSession:     current.audioSession,
      ));
    } else if (current is SetupProximityState) {
      emit(SetupState.audioOutput(
        username:            current.username,
        hubHost:             current.hubHost,
        hubPort:             current.hubPort,
        inputMode:           current.inputMode,
        inputDevice:         current.inputDevice,
        audioSession:        current.audioSession,
        outputDevices:       const [],
        selectedOutputDevice: current.outputDevice,
      ));
    }
  }
}
