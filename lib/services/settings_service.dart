import 'package:shared_preferences/shared_preferences.dart';

import '../models/audio_device_info.dart';
import '../models/proximity_params.dart';

/// Keys for all persisted settings.
abstract final class _K {
  static const username          = 'setup.username';
  static const hubHost           = 'setup.hubHost';
  static const hubPort           = 'setup.hubPort';
  static const inputMode         = 'setup.inputMode';
  static const inputDeviceIndex  = 'setup.inputDeviceIndex';
  static const inputDeviceName   = 'setup.inputDeviceName';
  static const audioSessionPid   = 'setup.audioSessionPid';
  static const outputDeviceIndex = 'setup.outputDeviceIndex';
  static const outputDeviceName  = 'setup.outputDeviceName';
  static const proximityNear     = 'setup.proximity.near';
  static const proximityFar      = 'setup.proximity.far';
  static const proximityCurve    = 'setup.proximity.curve';
  static const proximityPanning  = 'setup.proximity.panning';
}

/// Persisted snapshot of the setup wizard answers.
class SavedSettings {
  final String?  username;
  final String?  hubHost;
  final int?     hubPort;
  final AudioInputMode? inputMode;
  final int?     inputDeviceIndex;
  final String?  inputDeviceName;
  final int?     audioSessionPid;
  final int?     outputDeviceIndex;
  final String?  outputDeviceName;
  final ProximityParams? proximity;

  const SavedSettings({
    this.username,
    this.hubHost,
    this.hubPort,
    this.inputMode,
    this.inputDeviceIndex,
    this.inputDeviceName,
    this.audioSessionPid,
    this.outputDeviceIndex,
    this.outputDeviceName,
    this.proximity,
  });

  bool get hasIdentity => username != null && username!.isNotEmpty;
}

/// Thin wrapper around SharedPreferences for the setup wizard fields.
class SettingsService {
  SettingsService._();
  static final SettingsService instance = SettingsService._();

  SharedPreferences? _prefs;

  Future<SharedPreferences> _get() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// Loads all persisted values.  Returns defaults for anything not yet saved.
  Future<SavedSettings> load() async {
    final p = await _get();

    final modeStr = p.getString(_K.inputMode);
    AudioInputMode? mode;
    if (modeStr != null) {
      mode = AudioInputMode.values.firstWhere(
        (m) => m.name == modeStr,
        orElse: () => AudioInputMode.mic,
      );
    }

    ProximityParams? proximity;
    final near   = p.getDouble(_K.proximityNear);
    final far    = p.getDouble(_K.proximityFar);
    final curve  = p.getDouble(_K.proximityCurve);
    final pan    = p.getBool(_K.proximityPanning);
    if (near != null && far != null && curve != null && pan != null) {
      proximity = ProximityParams(near: near, far: far, curve: curve, panning: pan);
    }

    return SavedSettings(
      username:          p.getString(_K.username),
      hubHost:           p.getString(_K.hubHost),
      hubPort:           p.getInt(_K.hubPort),
      inputMode:         mode,
      inputDeviceIndex:  p.getInt(_K.inputDeviceIndex),
      inputDeviceName:   p.getString(_K.inputDeviceName),
      audioSessionPid:   p.getInt(_K.audioSessionPid),
      outputDeviceIndex: p.getInt(_K.outputDeviceIndex),
      outputDeviceName:  p.getString(_K.outputDeviceName),
      proximity:         proximity,
    );
  }

  /// Saves identity fields (called after the identity step is submitted).
  Future<void> saveIdentity({
    required String username,
    required String hubHost,
    required int    hubPort,
  }) async {
    final p = await _get();
    await p.setString(_K.username, username);
    await p.setString(_K.hubHost, hubHost);
    await p.setInt   (_K.hubPort, hubPort);
  }

  /// Saves audio input selection.
  Future<void> saveAudioInput({
    required AudioInputMode inputMode,
    AudioDeviceInfo?        inputDevice,
    AudioSessionInfo?       audioSession,
  }) async {
    final p = await _get();
    await p.setString(_K.inputMode, inputMode.name);
    if (inputDevice != null) {
      await p.setInt   (_K.inputDeviceIndex, inputDevice.index);
      await p.setString(_K.inputDeviceName,  inputDevice.name);
    }
    if (audioSession != null) {
      await p.setInt(_K.audioSessionPid, audioSession.pid);
    }
  }

  /// Saves audio output selection.
  Future<void> saveAudioOutput(AudioDeviceInfo? outputDevice) async {
    final p = await _get();
    if (outputDevice != null) {
      await p.setInt   (_K.outputDeviceIndex, outputDevice.index);
      await p.setString(_K.outputDeviceName,  outputDevice.name);
    }
  }

  /// Saves proximity parameters.
  Future<void> saveProximity(ProximityParams params) async {
    final p = await _get();
    await p.setDouble(_K.proximityNear,    params.near);
    await p.setDouble(_K.proximityFar,     params.far);
    await p.setDouble(_K.proximityCurve,   params.curve);
    await p.setBool  (_K.proximityPanning, params.panning);
  }

  /// Clears everything (for testing or "reset" button).
  Future<void> clear() async {
    final p = await _get();
    await p.clear();
  }
}
