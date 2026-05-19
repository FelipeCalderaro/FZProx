// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SetupConfig {
  String get username => throw _privateConstructorUsedError;
  String get hubHost => throw _privateConstructorUsedError;
  int get hubPort => throw _privateConstructorUsedError;
  AudioInputMode get inputMode =>
      throw _privateConstructorUsedError; // For mic / loopback mode
  AudioDeviceInfo? get inputDevice =>
      throw _privateConstructorUsedError; // For per-process mode
  AudioSessionInfo? get audioSession =>
      throw _privateConstructorUsedError; // Output device (null = system default)
  AudioDeviceInfo? get outputDevice => throw _privateConstructorUsedError;
  ProximityParams get proximity => throw _privateConstructorUsedError;

  /// Create a copy of SetupConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SetupConfigCopyWith<SetupConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetupConfigCopyWith<$Res> {
  factory $SetupConfigCopyWith(
          SetupConfig value, $Res Function(SetupConfig) then) =
      _$SetupConfigCopyWithImpl<$Res, SetupConfig>;
  @useResult
  $Res call(
      {String username,
      String hubHost,
      int hubPort,
      AudioInputMode inputMode,
      AudioDeviceInfo? inputDevice,
      AudioSessionInfo? audioSession,
      AudioDeviceInfo? outputDevice,
      ProximityParams proximity});

  $AudioDeviceInfoCopyWith<$Res>? get inputDevice;
  $AudioSessionInfoCopyWith<$Res>? get audioSession;
  $AudioDeviceInfoCopyWith<$Res>? get outputDevice;
  $ProximityParamsCopyWith<$Res> get proximity;
}

/// @nodoc
class _$SetupConfigCopyWithImpl<$Res, $Val extends SetupConfig>
    implements $SetupConfigCopyWith<$Res> {
  _$SetupConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SetupConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? hubHost = null,
    Object? hubPort = null,
    Object? inputMode = null,
    Object? inputDevice = freezed,
    Object? audioSession = freezed,
    Object? outputDevice = freezed,
    Object? proximity = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      hubHost: null == hubHost
          ? _value.hubHost
          : hubHost // ignore: cast_nullable_to_non_nullable
              as String,
      hubPort: null == hubPort
          ? _value.hubPort
          : hubPort // ignore: cast_nullable_to_non_nullable
              as int,
      inputMode: null == inputMode
          ? _value.inputMode
          : inputMode // ignore: cast_nullable_to_non_nullable
              as AudioInputMode,
      inputDevice: freezed == inputDevice
          ? _value.inputDevice
          : inputDevice // ignore: cast_nullable_to_non_nullable
              as AudioDeviceInfo?,
      audioSession: freezed == audioSession
          ? _value.audioSession
          : audioSession // ignore: cast_nullable_to_non_nullable
              as AudioSessionInfo?,
      outputDevice: freezed == outputDevice
          ? _value.outputDevice
          : outputDevice // ignore: cast_nullable_to_non_nullable
              as AudioDeviceInfo?,
      proximity: null == proximity
          ? _value.proximity
          : proximity // ignore: cast_nullable_to_non_nullable
              as ProximityParams,
    ) as $Val);
  }

  /// Create a copy of SetupConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioDeviceInfoCopyWith<$Res>? get inputDevice {
    if (_value.inputDevice == null) {
      return null;
    }

    return $AudioDeviceInfoCopyWith<$Res>(_value.inputDevice!, (value) {
      return _then(_value.copyWith(inputDevice: value) as $Val);
    });
  }

  /// Create a copy of SetupConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioSessionInfoCopyWith<$Res>? get audioSession {
    if (_value.audioSession == null) {
      return null;
    }

    return $AudioSessionInfoCopyWith<$Res>(_value.audioSession!, (value) {
      return _then(_value.copyWith(audioSession: value) as $Val);
    });
  }

  /// Create a copy of SetupConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioDeviceInfoCopyWith<$Res>? get outputDevice {
    if (_value.outputDevice == null) {
      return null;
    }

    return $AudioDeviceInfoCopyWith<$Res>(_value.outputDevice!, (value) {
      return _then(_value.copyWith(outputDevice: value) as $Val);
    });
  }

  /// Create a copy of SetupConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProximityParamsCopyWith<$Res> get proximity {
    return $ProximityParamsCopyWith<$Res>(_value.proximity, (value) {
      return _then(_value.copyWith(proximity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SetupConfigImplCopyWith<$Res>
    implements $SetupConfigCopyWith<$Res> {
  factory _$$SetupConfigImplCopyWith(
          _$SetupConfigImpl value, $Res Function(_$SetupConfigImpl) then) =
      __$$SetupConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String hubHost,
      int hubPort,
      AudioInputMode inputMode,
      AudioDeviceInfo? inputDevice,
      AudioSessionInfo? audioSession,
      AudioDeviceInfo? outputDevice,
      ProximityParams proximity});

  @override
  $AudioDeviceInfoCopyWith<$Res>? get inputDevice;
  @override
  $AudioSessionInfoCopyWith<$Res>? get audioSession;
  @override
  $AudioDeviceInfoCopyWith<$Res>? get outputDevice;
  @override
  $ProximityParamsCopyWith<$Res> get proximity;
}

/// @nodoc
class __$$SetupConfigImplCopyWithImpl<$Res>
    extends _$SetupConfigCopyWithImpl<$Res, _$SetupConfigImpl>
    implements _$$SetupConfigImplCopyWith<$Res> {
  __$$SetupConfigImplCopyWithImpl(
      _$SetupConfigImpl _value, $Res Function(_$SetupConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? hubHost = null,
    Object? hubPort = null,
    Object? inputMode = null,
    Object? inputDevice = freezed,
    Object? audioSession = freezed,
    Object? outputDevice = freezed,
    Object? proximity = null,
  }) {
    return _then(_$SetupConfigImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      hubHost: null == hubHost
          ? _value.hubHost
          : hubHost // ignore: cast_nullable_to_non_nullable
              as String,
      hubPort: null == hubPort
          ? _value.hubPort
          : hubPort // ignore: cast_nullable_to_non_nullable
              as int,
      inputMode: null == inputMode
          ? _value.inputMode
          : inputMode // ignore: cast_nullable_to_non_nullable
              as AudioInputMode,
      inputDevice: freezed == inputDevice
          ? _value.inputDevice
          : inputDevice // ignore: cast_nullable_to_non_nullable
              as AudioDeviceInfo?,
      audioSession: freezed == audioSession
          ? _value.audioSession
          : audioSession // ignore: cast_nullable_to_non_nullable
              as AudioSessionInfo?,
      outputDevice: freezed == outputDevice
          ? _value.outputDevice
          : outputDevice // ignore: cast_nullable_to_non_nullable
              as AudioDeviceInfo?,
      proximity: null == proximity
          ? _value.proximity
          : proximity // ignore: cast_nullable_to_non_nullable
              as ProximityParams,
    ));
  }
}

/// @nodoc

class _$SetupConfigImpl implements _SetupConfig {
  const _$SetupConfigImpl(
      {required this.username,
      required this.hubHost,
      required this.hubPort,
      required this.inputMode,
      this.inputDevice,
      this.audioSession,
      this.outputDevice,
      required this.proximity});

  @override
  final String username;
  @override
  final String hubHost;
  @override
  final int hubPort;
  @override
  final AudioInputMode inputMode;
// For mic / loopback mode
  @override
  final AudioDeviceInfo? inputDevice;
// For per-process mode
  @override
  final AudioSessionInfo? audioSession;
// Output device (null = system default)
  @override
  final AudioDeviceInfo? outputDevice;
  @override
  final ProximityParams proximity;

  @override
  String toString() {
    return 'SetupConfig(username: $username, hubHost: $hubHost, hubPort: $hubPort, inputMode: $inputMode, inputDevice: $inputDevice, audioSession: $audioSession, outputDevice: $outputDevice, proximity: $proximity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupConfigImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.hubHost, hubHost) || other.hubHost == hubHost) &&
            (identical(other.hubPort, hubPort) || other.hubPort == hubPort) &&
            (identical(other.inputMode, inputMode) ||
                other.inputMode == inputMode) &&
            (identical(other.inputDevice, inputDevice) ||
                other.inputDevice == inputDevice) &&
            (identical(other.audioSession, audioSession) ||
                other.audioSession == audioSession) &&
            (identical(other.outputDevice, outputDevice) ||
                other.outputDevice == outputDevice) &&
            (identical(other.proximity, proximity) ||
                other.proximity == proximity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, hubHost, hubPort,
      inputMode, inputDevice, audioSession, outputDevice, proximity);

  /// Create a copy of SetupConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupConfigImplCopyWith<_$SetupConfigImpl> get copyWith =>
      __$$SetupConfigImplCopyWithImpl<_$SetupConfigImpl>(this, _$identity);
}

abstract class _SetupConfig implements SetupConfig {
  const factory _SetupConfig(
      {required final String username,
      required final String hubHost,
      required final int hubPort,
      required final AudioInputMode inputMode,
      final AudioDeviceInfo? inputDevice,
      final AudioSessionInfo? audioSession,
      final AudioDeviceInfo? outputDevice,
      required final ProximityParams proximity}) = _$SetupConfigImpl;

  @override
  String get username;
  @override
  String get hubHost;
  @override
  int get hubPort;
  @override
  AudioInputMode get inputMode; // For mic / loopback mode
  @override
  AudioDeviceInfo? get inputDevice; // For per-process mode
  @override
  AudioSessionInfo? get audioSession; // Output device (null = system default)
  @override
  AudioDeviceInfo? get outputDevice;
  @override
  ProximityParams get proximity;

  /// Create a copy of SetupConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupConfigImplCopyWith<_$SetupConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
