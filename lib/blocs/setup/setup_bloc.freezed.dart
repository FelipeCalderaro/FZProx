// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SetupEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? prefilledHost, int? prefilledPort)
        started,
    required TResult Function() devicesRefreshed,
    required TResult Function(String username, String hubHost, int hubPort)
        identitySubmitted,
    required TResult Function(AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice, AudioSessionInfo? audioSession)
        audioInputSelected,
    required TResult Function(AudioDeviceInfo? outputDevice)
        audioOutputSelected,
    required TResult Function(ProximityParams params) proximitySubmitted,
    required TResult Function() backPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? prefilledHost, int? prefilledPort)? started,
    TResult? Function()? devicesRefreshed,
    TResult? Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult? Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult? Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult? Function(ProximityParams params)? proximitySubmitted,
    TResult? Function()? backPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? prefilledHost, int? prefilledPort)? started,
    TResult Function()? devicesRefreshed,
    TResult Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult Function(ProximityParams params)? proximitySubmitted,
    TResult Function()? backPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupStarted value) started,
    required TResult Function(SetupDevicesRefreshed value) devicesRefreshed,
    required TResult Function(SetupIdentitySubmitted value) identitySubmitted,
    required TResult Function(SetupAudioInputSelected value) audioInputSelected,
    required TResult Function(SetupAudioOutputSelected value)
        audioOutputSelected,
    required TResult Function(SetupProximitySubmitted value) proximitySubmitted,
    required TResult Function(SetupBackPressed value) backPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupStarted value)? started,
    TResult? Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult? Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult? Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult? Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult? Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult? Function(SetupBackPressed value)? backPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupStarted value)? started,
    TResult Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult Function(SetupBackPressed value)? backPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetupEventCopyWith<$Res> {
  factory $SetupEventCopyWith(
          SetupEvent value, $Res Function(SetupEvent) then) =
      _$SetupEventCopyWithImpl<$Res, SetupEvent>;
}

/// @nodoc
class _$SetupEventCopyWithImpl<$Res, $Val extends SetupEvent>
    implements $SetupEventCopyWith<$Res> {
  _$SetupEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SetupStartedImplCopyWith<$Res> {
  factory _$$SetupStartedImplCopyWith(
          _$SetupStartedImpl value, $Res Function(_$SetupStartedImpl) then) =
      __$$SetupStartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? prefilledHost, int? prefilledPort});
}

/// @nodoc
class __$$SetupStartedImplCopyWithImpl<$Res>
    extends _$SetupEventCopyWithImpl<$Res, _$SetupStartedImpl>
    implements _$$SetupStartedImplCopyWith<$Res> {
  __$$SetupStartedImplCopyWithImpl(
      _$SetupStartedImpl _value, $Res Function(_$SetupStartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prefilledHost = freezed,
    Object? prefilledPort = freezed,
  }) {
    return _then(_$SetupStartedImpl(
      prefilledHost: freezed == prefilledHost
          ? _value.prefilledHost
          : prefilledHost // ignore: cast_nullable_to_non_nullable
              as String?,
      prefilledPort: freezed == prefilledPort
          ? _value.prefilledPort
          : prefilledPort // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SetupStartedImpl implements SetupStarted {
  const _$SetupStartedImpl({this.prefilledHost, this.prefilledPort});

  @override
  final String? prefilledHost;
  @override
  final int? prefilledPort;

  @override
  String toString() {
    return 'SetupEvent.started(prefilledHost: $prefilledHost, prefilledPort: $prefilledPort)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupStartedImpl &&
            (identical(other.prefilledHost, prefilledHost) ||
                other.prefilledHost == prefilledHost) &&
            (identical(other.prefilledPort, prefilledPort) ||
                other.prefilledPort == prefilledPort));
  }

  @override
  int get hashCode => Object.hash(runtimeType, prefilledHost, prefilledPort);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupStartedImplCopyWith<_$SetupStartedImpl> get copyWith =>
      __$$SetupStartedImplCopyWithImpl<_$SetupStartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? prefilledHost, int? prefilledPort)
        started,
    required TResult Function() devicesRefreshed,
    required TResult Function(String username, String hubHost, int hubPort)
        identitySubmitted,
    required TResult Function(AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice, AudioSessionInfo? audioSession)
        audioInputSelected,
    required TResult Function(AudioDeviceInfo? outputDevice)
        audioOutputSelected,
    required TResult Function(ProximityParams params) proximitySubmitted,
    required TResult Function() backPressed,
  }) {
    return started(prefilledHost, prefilledPort);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? prefilledHost, int? prefilledPort)? started,
    TResult? Function()? devicesRefreshed,
    TResult? Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult? Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult? Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult? Function(ProximityParams params)? proximitySubmitted,
    TResult? Function()? backPressed,
  }) {
    return started?.call(prefilledHost, prefilledPort);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? prefilledHost, int? prefilledPort)? started,
    TResult Function()? devicesRefreshed,
    TResult Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult Function(ProximityParams params)? proximitySubmitted,
    TResult Function()? backPressed,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(prefilledHost, prefilledPort);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupStarted value) started,
    required TResult Function(SetupDevicesRefreshed value) devicesRefreshed,
    required TResult Function(SetupIdentitySubmitted value) identitySubmitted,
    required TResult Function(SetupAudioInputSelected value) audioInputSelected,
    required TResult Function(SetupAudioOutputSelected value)
        audioOutputSelected,
    required TResult Function(SetupProximitySubmitted value) proximitySubmitted,
    required TResult Function(SetupBackPressed value) backPressed,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupStarted value)? started,
    TResult? Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult? Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult? Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult? Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult? Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult? Function(SetupBackPressed value)? backPressed,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupStarted value)? started,
    TResult Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult Function(SetupBackPressed value)? backPressed,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class SetupStarted implements SetupEvent {
  const factory SetupStarted(
      {final String? prefilledHost,
      final int? prefilledPort}) = _$SetupStartedImpl;

  String? get prefilledHost;
  int? get prefilledPort;

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupStartedImplCopyWith<_$SetupStartedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetupDevicesRefreshedImplCopyWith<$Res> {
  factory _$$SetupDevicesRefreshedImplCopyWith(
          _$SetupDevicesRefreshedImpl value,
          $Res Function(_$SetupDevicesRefreshedImpl) then) =
      __$$SetupDevicesRefreshedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SetupDevicesRefreshedImplCopyWithImpl<$Res>
    extends _$SetupEventCopyWithImpl<$Res, _$SetupDevicesRefreshedImpl>
    implements _$$SetupDevicesRefreshedImplCopyWith<$Res> {
  __$$SetupDevicesRefreshedImplCopyWithImpl(_$SetupDevicesRefreshedImpl _value,
      $Res Function(_$SetupDevicesRefreshedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SetupDevicesRefreshedImpl implements SetupDevicesRefreshed {
  const _$SetupDevicesRefreshedImpl();

  @override
  String toString() {
    return 'SetupEvent.devicesRefreshed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupDevicesRefreshedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? prefilledHost, int? prefilledPort)
        started,
    required TResult Function() devicesRefreshed,
    required TResult Function(String username, String hubHost, int hubPort)
        identitySubmitted,
    required TResult Function(AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice, AudioSessionInfo? audioSession)
        audioInputSelected,
    required TResult Function(AudioDeviceInfo? outputDevice)
        audioOutputSelected,
    required TResult Function(ProximityParams params) proximitySubmitted,
    required TResult Function() backPressed,
  }) {
    return devicesRefreshed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? prefilledHost, int? prefilledPort)? started,
    TResult? Function()? devicesRefreshed,
    TResult? Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult? Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult? Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult? Function(ProximityParams params)? proximitySubmitted,
    TResult? Function()? backPressed,
  }) {
    return devicesRefreshed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? prefilledHost, int? prefilledPort)? started,
    TResult Function()? devicesRefreshed,
    TResult Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult Function(ProximityParams params)? proximitySubmitted,
    TResult Function()? backPressed,
    required TResult orElse(),
  }) {
    if (devicesRefreshed != null) {
      return devicesRefreshed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupStarted value) started,
    required TResult Function(SetupDevicesRefreshed value) devicesRefreshed,
    required TResult Function(SetupIdentitySubmitted value) identitySubmitted,
    required TResult Function(SetupAudioInputSelected value) audioInputSelected,
    required TResult Function(SetupAudioOutputSelected value)
        audioOutputSelected,
    required TResult Function(SetupProximitySubmitted value) proximitySubmitted,
    required TResult Function(SetupBackPressed value) backPressed,
  }) {
    return devicesRefreshed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupStarted value)? started,
    TResult? Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult? Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult? Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult? Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult? Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult? Function(SetupBackPressed value)? backPressed,
  }) {
    return devicesRefreshed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupStarted value)? started,
    TResult Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult Function(SetupBackPressed value)? backPressed,
    required TResult orElse(),
  }) {
    if (devicesRefreshed != null) {
      return devicesRefreshed(this);
    }
    return orElse();
  }
}

abstract class SetupDevicesRefreshed implements SetupEvent {
  const factory SetupDevicesRefreshed() = _$SetupDevicesRefreshedImpl;
}

/// @nodoc
abstract class _$$SetupIdentitySubmittedImplCopyWith<$Res> {
  factory _$$SetupIdentitySubmittedImplCopyWith(
          _$SetupIdentitySubmittedImpl value,
          $Res Function(_$SetupIdentitySubmittedImpl) then) =
      __$$SetupIdentitySubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String username, String hubHost, int hubPort});
}

/// @nodoc
class __$$SetupIdentitySubmittedImplCopyWithImpl<$Res>
    extends _$SetupEventCopyWithImpl<$Res, _$SetupIdentitySubmittedImpl>
    implements _$$SetupIdentitySubmittedImplCopyWith<$Res> {
  __$$SetupIdentitySubmittedImplCopyWithImpl(
      _$SetupIdentitySubmittedImpl _value,
      $Res Function(_$SetupIdentitySubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? hubHost = null,
    Object? hubPort = null,
  }) {
    return _then(_$SetupIdentitySubmittedImpl(
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
    ));
  }
}

/// @nodoc

class _$SetupIdentitySubmittedImpl implements SetupIdentitySubmitted {
  const _$SetupIdentitySubmittedImpl(
      {required this.username, required this.hubHost, required this.hubPort});

  @override
  final String username;
  @override
  final String hubHost;
  @override
  final int hubPort;

  @override
  String toString() {
    return 'SetupEvent.identitySubmitted(username: $username, hubHost: $hubHost, hubPort: $hubPort)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupIdentitySubmittedImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.hubHost, hubHost) || other.hubHost == hubHost) &&
            (identical(other.hubPort, hubPort) || other.hubPort == hubPort));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, hubHost, hubPort);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupIdentitySubmittedImplCopyWith<_$SetupIdentitySubmittedImpl>
      get copyWith => __$$SetupIdentitySubmittedImplCopyWithImpl<
          _$SetupIdentitySubmittedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? prefilledHost, int? prefilledPort)
        started,
    required TResult Function() devicesRefreshed,
    required TResult Function(String username, String hubHost, int hubPort)
        identitySubmitted,
    required TResult Function(AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice, AudioSessionInfo? audioSession)
        audioInputSelected,
    required TResult Function(AudioDeviceInfo? outputDevice)
        audioOutputSelected,
    required TResult Function(ProximityParams params) proximitySubmitted,
    required TResult Function() backPressed,
  }) {
    return identitySubmitted(username, hubHost, hubPort);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? prefilledHost, int? prefilledPort)? started,
    TResult? Function()? devicesRefreshed,
    TResult? Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult? Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult? Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult? Function(ProximityParams params)? proximitySubmitted,
    TResult? Function()? backPressed,
  }) {
    return identitySubmitted?.call(username, hubHost, hubPort);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? prefilledHost, int? prefilledPort)? started,
    TResult Function()? devicesRefreshed,
    TResult Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult Function(ProximityParams params)? proximitySubmitted,
    TResult Function()? backPressed,
    required TResult orElse(),
  }) {
    if (identitySubmitted != null) {
      return identitySubmitted(username, hubHost, hubPort);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupStarted value) started,
    required TResult Function(SetupDevicesRefreshed value) devicesRefreshed,
    required TResult Function(SetupIdentitySubmitted value) identitySubmitted,
    required TResult Function(SetupAudioInputSelected value) audioInputSelected,
    required TResult Function(SetupAudioOutputSelected value)
        audioOutputSelected,
    required TResult Function(SetupProximitySubmitted value) proximitySubmitted,
    required TResult Function(SetupBackPressed value) backPressed,
  }) {
    return identitySubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupStarted value)? started,
    TResult? Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult? Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult? Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult? Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult? Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult? Function(SetupBackPressed value)? backPressed,
  }) {
    return identitySubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupStarted value)? started,
    TResult Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult Function(SetupBackPressed value)? backPressed,
    required TResult orElse(),
  }) {
    if (identitySubmitted != null) {
      return identitySubmitted(this);
    }
    return orElse();
  }
}

abstract class SetupIdentitySubmitted implements SetupEvent {
  const factory SetupIdentitySubmitted(
      {required final String username,
      required final String hubHost,
      required final int hubPort}) = _$SetupIdentitySubmittedImpl;

  String get username;
  String get hubHost;
  int get hubPort;

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupIdentitySubmittedImplCopyWith<_$SetupIdentitySubmittedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetupAudioInputSelectedImplCopyWith<$Res> {
  factory _$$SetupAudioInputSelectedImplCopyWith(
          _$SetupAudioInputSelectedImpl value,
          $Res Function(_$SetupAudioInputSelectedImpl) then) =
      __$$SetupAudioInputSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {AudioInputMode inputMode,
      AudioDeviceInfo? inputDevice,
      AudioSessionInfo? audioSession});

  $AudioDeviceInfoCopyWith<$Res>? get inputDevice;
  $AudioSessionInfoCopyWith<$Res>? get audioSession;
}

/// @nodoc
class __$$SetupAudioInputSelectedImplCopyWithImpl<$Res>
    extends _$SetupEventCopyWithImpl<$Res, _$SetupAudioInputSelectedImpl>
    implements _$$SetupAudioInputSelectedImplCopyWith<$Res> {
  __$$SetupAudioInputSelectedImplCopyWithImpl(
      _$SetupAudioInputSelectedImpl _value,
      $Res Function(_$SetupAudioInputSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMode = null,
    Object? inputDevice = freezed,
    Object? audioSession = freezed,
  }) {
    return _then(_$SetupAudioInputSelectedImpl(
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
    ));
  }

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioDeviceInfoCopyWith<$Res>? get inputDevice {
    if (_value.inputDevice == null) {
      return null;
    }

    return $AudioDeviceInfoCopyWith<$Res>(_value.inputDevice!, (value) {
      return _then(_value.copyWith(inputDevice: value));
    });
  }

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioSessionInfoCopyWith<$Res>? get audioSession {
    if (_value.audioSession == null) {
      return null;
    }

    return $AudioSessionInfoCopyWith<$Res>(_value.audioSession!, (value) {
      return _then(_value.copyWith(audioSession: value));
    });
  }
}

/// @nodoc

class _$SetupAudioInputSelectedImpl implements SetupAudioInputSelected {
  const _$SetupAudioInputSelectedImpl(
      {required this.inputMode, this.inputDevice, this.audioSession});

  @override
  final AudioInputMode inputMode;
  @override
  final AudioDeviceInfo? inputDevice;
  @override
  final AudioSessionInfo? audioSession;

  @override
  String toString() {
    return 'SetupEvent.audioInputSelected(inputMode: $inputMode, inputDevice: $inputDevice, audioSession: $audioSession)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupAudioInputSelectedImpl &&
            (identical(other.inputMode, inputMode) ||
                other.inputMode == inputMode) &&
            (identical(other.inputDevice, inputDevice) ||
                other.inputDevice == inputDevice) &&
            (identical(other.audioSession, audioSession) ||
                other.audioSession == audioSession));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, inputMode, inputDevice, audioSession);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupAudioInputSelectedImplCopyWith<_$SetupAudioInputSelectedImpl>
      get copyWith => __$$SetupAudioInputSelectedImplCopyWithImpl<
          _$SetupAudioInputSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? prefilledHost, int? prefilledPort)
        started,
    required TResult Function() devicesRefreshed,
    required TResult Function(String username, String hubHost, int hubPort)
        identitySubmitted,
    required TResult Function(AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice, AudioSessionInfo? audioSession)
        audioInputSelected,
    required TResult Function(AudioDeviceInfo? outputDevice)
        audioOutputSelected,
    required TResult Function(ProximityParams params) proximitySubmitted,
    required TResult Function() backPressed,
  }) {
    return audioInputSelected(inputMode, inputDevice, audioSession);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? prefilledHost, int? prefilledPort)? started,
    TResult? Function()? devicesRefreshed,
    TResult? Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult? Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult? Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult? Function(ProximityParams params)? proximitySubmitted,
    TResult? Function()? backPressed,
  }) {
    return audioInputSelected?.call(inputMode, inputDevice, audioSession);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? prefilledHost, int? prefilledPort)? started,
    TResult Function()? devicesRefreshed,
    TResult Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult Function(ProximityParams params)? proximitySubmitted,
    TResult Function()? backPressed,
    required TResult orElse(),
  }) {
    if (audioInputSelected != null) {
      return audioInputSelected(inputMode, inputDevice, audioSession);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupStarted value) started,
    required TResult Function(SetupDevicesRefreshed value) devicesRefreshed,
    required TResult Function(SetupIdentitySubmitted value) identitySubmitted,
    required TResult Function(SetupAudioInputSelected value) audioInputSelected,
    required TResult Function(SetupAudioOutputSelected value)
        audioOutputSelected,
    required TResult Function(SetupProximitySubmitted value) proximitySubmitted,
    required TResult Function(SetupBackPressed value) backPressed,
  }) {
    return audioInputSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupStarted value)? started,
    TResult? Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult? Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult? Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult? Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult? Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult? Function(SetupBackPressed value)? backPressed,
  }) {
    return audioInputSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupStarted value)? started,
    TResult Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult Function(SetupBackPressed value)? backPressed,
    required TResult orElse(),
  }) {
    if (audioInputSelected != null) {
      return audioInputSelected(this);
    }
    return orElse();
  }
}

abstract class SetupAudioInputSelected implements SetupEvent {
  const factory SetupAudioInputSelected(
      {required final AudioInputMode inputMode,
      final AudioDeviceInfo? inputDevice,
      final AudioSessionInfo? audioSession}) = _$SetupAudioInputSelectedImpl;

  AudioInputMode get inputMode;
  AudioDeviceInfo? get inputDevice;
  AudioSessionInfo? get audioSession;

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupAudioInputSelectedImplCopyWith<_$SetupAudioInputSelectedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetupAudioOutputSelectedImplCopyWith<$Res> {
  factory _$$SetupAudioOutputSelectedImplCopyWith(
          _$SetupAudioOutputSelectedImpl value,
          $Res Function(_$SetupAudioOutputSelectedImpl) then) =
      __$$SetupAudioOutputSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AudioDeviceInfo? outputDevice});

  $AudioDeviceInfoCopyWith<$Res>? get outputDevice;
}

/// @nodoc
class __$$SetupAudioOutputSelectedImplCopyWithImpl<$Res>
    extends _$SetupEventCopyWithImpl<$Res, _$SetupAudioOutputSelectedImpl>
    implements _$$SetupAudioOutputSelectedImplCopyWith<$Res> {
  __$$SetupAudioOutputSelectedImplCopyWithImpl(
      _$SetupAudioOutputSelectedImpl _value,
      $Res Function(_$SetupAudioOutputSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outputDevice = freezed,
  }) {
    return _then(_$SetupAudioOutputSelectedImpl(
      outputDevice: freezed == outputDevice
          ? _value.outputDevice
          : outputDevice // ignore: cast_nullable_to_non_nullable
              as AudioDeviceInfo?,
    ));
  }

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioDeviceInfoCopyWith<$Res>? get outputDevice {
    if (_value.outputDevice == null) {
      return null;
    }

    return $AudioDeviceInfoCopyWith<$Res>(_value.outputDevice!, (value) {
      return _then(_value.copyWith(outputDevice: value));
    });
  }
}

/// @nodoc

class _$SetupAudioOutputSelectedImpl implements SetupAudioOutputSelected {
  const _$SetupAudioOutputSelectedImpl({this.outputDevice});

  @override
  final AudioDeviceInfo? outputDevice;

  @override
  String toString() {
    return 'SetupEvent.audioOutputSelected(outputDevice: $outputDevice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupAudioOutputSelectedImpl &&
            (identical(other.outputDevice, outputDevice) ||
                other.outputDevice == outputDevice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, outputDevice);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupAudioOutputSelectedImplCopyWith<_$SetupAudioOutputSelectedImpl>
      get copyWith => __$$SetupAudioOutputSelectedImplCopyWithImpl<
          _$SetupAudioOutputSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? prefilledHost, int? prefilledPort)
        started,
    required TResult Function() devicesRefreshed,
    required TResult Function(String username, String hubHost, int hubPort)
        identitySubmitted,
    required TResult Function(AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice, AudioSessionInfo? audioSession)
        audioInputSelected,
    required TResult Function(AudioDeviceInfo? outputDevice)
        audioOutputSelected,
    required TResult Function(ProximityParams params) proximitySubmitted,
    required TResult Function() backPressed,
  }) {
    return audioOutputSelected(outputDevice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? prefilledHost, int? prefilledPort)? started,
    TResult? Function()? devicesRefreshed,
    TResult? Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult? Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult? Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult? Function(ProximityParams params)? proximitySubmitted,
    TResult? Function()? backPressed,
  }) {
    return audioOutputSelected?.call(outputDevice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? prefilledHost, int? prefilledPort)? started,
    TResult Function()? devicesRefreshed,
    TResult Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult Function(ProximityParams params)? proximitySubmitted,
    TResult Function()? backPressed,
    required TResult orElse(),
  }) {
    if (audioOutputSelected != null) {
      return audioOutputSelected(outputDevice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupStarted value) started,
    required TResult Function(SetupDevicesRefreshed value) devicesRefreshed,
    required TResult Function(SetupIdentitySubmitted value) identitySubmitted,
    required TResult Function(SetupAudioInputSelected value) audioInputSelected,
    required TResult Function(SetupAudioOutputSelected value)
        audioOutputSelected,
    required TResult Function(SetupProximitySubmitted value) proximitySubmitted,
    required TResult Function(SetupBackPressed value) backPressed,
  }) {
    return audioOutputSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupStarted value)? started,
    TResult? Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult? Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult? Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult? Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult? Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult? Function(SetupBackPressed value)? backPressed,
  }) {
    return audioOutputSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupStarted value)? started,
    TResult Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult Function(SetupBackPressed value)? backPressed,
    required TResult orElse(),
  }) {
    if (audioOutputSelected != null) {
      return audioOutputSelected(this);
    }
    return orElse();
  }
}

abstract class SetupAudioOutputSelected implements SetupEvent {
  const factory SetupAudioOutputSelected(
      {final AudioDeviceInfo? outputDevice}) = _$SetupAudioOutputSelectedImpl;

  AudioDeviceInfo? get outputDevice;

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupAudioOutputSelectedImplCopyWith<_$SetupAudioOutputSelectedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetupProximitySubmittedImplCopyWith<$Res> {
  factory _$$SetupProximitySubmittedImplCopyWith(
          _$SetupProximitySubmittedImpl value,
          $Res Function(_$SetupProximitySubmittedImpl) then) =
      __$$SetupProximitySubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProximityParams params});

  $ProximityParamsCopyWith<$Res> get params;
}

/// @nodoc
class __$$SetupProximitySubmittedImplCopyWithImpl<$Res>
    extends _$SetupEventCopyWithImpl<$Res, _$SetupProximitySubmittedImpl>
    implements _$$SetupProximitySubmittedImplCopyWith<$Res> {
  __$$SetupProximitySubmittedImplCopyWithImpl(
      _$SetupProximitySubmittedImpl _value,
      $Res Function(_$SetupProximitySubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$SetupProximitySubmittedImpl(
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as ProximityParams,
    ));
  }

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProximityParamsCopyWith<$Res> get params {
    return $ProximityParamsCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value));
    });
  }
}

/// @nodoc

class _$SetupProximitySubmittedImpl implements SetupProximitySubmitted {
  const _$SetupProximitySubmittedImpl({required this.params});

  @override
  final ProximityParams params;

  @override
  String toString() {
    return 'SetupEvent.proximitySubmitted(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupProximitySubmittedImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupProximitySubmittedImplCopyWith<_$SetupProximitySubmittedImpl>
      get copyWith => __$$SetupProximitySubmittedImplCopyWithImpl<
          _$SetupProximitySubmittedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? prefilledHost, int? prefilledPort)
        started,
    required TResult Function() devicesRefreshed,
    required TResult Function(String username, String hubHost, int hubPort)
        identitySubmitted,
    required TResult Function(AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice, AudioSessionInfo? audioSession)
        audioInputSelected,
    required TResult Function(AudioDeviceInfo? outputDevice)
        audioOutputSelected,
    required TResult Function(ProximityParams params) proximitySubmitted,
    required TResult Function() backPressed,
  }) {
    return proximitySubmitted(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? prefilledHost, int? prefilledPort)? started,
    TResult? Function()? devicesRefreshed,
    TResult? Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult? Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult? Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult? Function(ProximityParams params)? proximitySubmitted,
    TResult? Function()? backPressed,
  }) {
    return proximitySubmitted?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? prefilledHost, int? prefilledPort)? started,
    TResult Function()? devicesRefreshed,
    TResult Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult Function(ProximityParams params)? proximitySubmitted,
    TResult Function()? backPressed,
    required TResult orElse(),
  }) {
    if (proximitySubmitted != null) {
      return proximitySubmitted(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupStarted value) started,
    required TResult Function(SetupDevicesRefreshed value) devicesRefreshed,
    required TResult Function(SetupIdentitySubmitted value) identitySubmitted,
    required TResult Function(SetupAudioInputSelected value) audioInputSelected,
    required TResult Function(SetupAudioOutputSelected value)
        audioOutputSelected,
    required TResult Function(SetupProximitySubmitted value) proximitySubmitted,
    required TResult Function(SetupBackPressed value) backPressed,
  }) {
    return proximitySubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupStarted value)? started,
    TResult? Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult? Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult? Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult? Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult? Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult? Function(SetupBackPressed value)? backPressed,
  }) {
    return proximitySubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupStarted value)? started,
    TResult Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult Function(SetupBackPressed value)? backPressed,
    required TResult orElse(),
  }) {
    if (proximitySubmitted != null) {
      return proximitySubmitted(this);
    }
    return orElse();
  }
}

abstract class SetupProximitySubmitted implements SetupEvent {
  const factory SetupProximitySubmitted(
      {required final ProximityParams params}) = _$SetupProximitySubmittedImpl;

  ProximityParams get params;

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupProximitySubmittedImplCopyWith<_$SetupProximitySubmittedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetupBackPressedImplCopyWith<$Res> {
  factory _$$SetupBackPressedImplCopyWith(_$SetupBackPressedImpl value,
          $Res Function(_$SetupBackPressedImpl) then) =
      __$$SetupBackPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SetupBackPressedImplCopyWithImpl<$Res>
    extends _$SetupEventCopyWithImpl<$Res, _$SetupBackPressedImpl>
    implements _$$SetupBackPressedImplCopyWith<$Res> {
  __$$SetupBackPressedImplCopyWithImpl(_$SetupBackPressedImpl _value,
      $Res Function(_$SetupBackPressedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SetupBackPressedImpl implements SetupBackPressed {
  const _$SetupBackPressedImpl();

  @override
  String toString() {
    return 'SetupEvent.backPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SetupBackPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? prefilledHost, int? prefilledPort)
        started,
    required TResult Function() devicesRefreshed,
    required TResult Function(String username, String hubHost, int hubPort)
        identitySubmitted,
    required TResult Function(AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice, AudioSessionInfo? audioSession)
        audioInputSelected,
    required TResult Function(AudioDeviceInfo? outputDevice)
        audioOutputSelected,
    required TResult Function(ProximityParams params) proximitySubmitted,
    required TResult Function() backPressed,
  }) {
    return backPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? prefilledHost, int? prefilledPort)? started,
    TResult? Function()? devicesRefreshed,
    TResult? Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult? Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult? Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult? Function(ProximityParams params)? proximitySubmitted,
    TResult? Function()? backPressed,
  }) {
    return backPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? prefilledHost, int? prefilledPort)? started,
    TResult Function()? devicesRefreshed,
    TResult Function(String username, String hubHost, int hubPort)?
        identitySubmitted,
    TResult Function(AudioInputMode inputMode, AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession)?
        audioInputSelected,
    TResult Function(AudioDeviceInfo? outputDevice)? audioOutputSelected,
    TResult Function(ProximityParams params)? proximitySubmitted,
    TResult Function()? backPressed,
    required TResult orElse(),
  }) {
    if (backPressed != null) {
      return backPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupStarted value) started,
    required TResult Function(SetupDevicesRefreshed value) devicesRefreshed,
    required TResult Function(SetupIdentitySubmitted value) identitySubmitted,
    required TResult Function(SetupAudioInputSelected value) audioInputSelected,
    required TResult Function(SetupAudioOutputSelected value)
        audioOutputSelected,
    required TResult Function(SetupProximitySubmitted value) proximitySubmitted,
    required TResult Function(SetupBackPressed value) backPressed,
  }) {
    return backPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupStarted value)? started,
    TResult? Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult? Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult? Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult? Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult? Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult? Function(SetupBackPressed value)? backPressed,
  }) {
    return backPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupStarted value)? started,
    TResult Function(SetupDevicesRefreshed value)? devicesRefreshed,
    TResult Function(SetupIdentitySubmitted value)? identitySubmitted,
    TResult Function(SetupAudioInputSelected value)? audioInputSelected,
    TResult Function(SetupAudioOutputSelected value)? audioOutputSelected,
    TResult Function(SetupProximitySubmitted value)? proximitySubmitted,
    TResult Function(SetupBackPressed value)? backPressed,
    required TResult orElse(),
  }) {
    if (backPressed != null) {
      return backPressed(this);
    }
    return orElse();
  }
}

abstract class SetupBackPressed implements SetupEvent {
  const factory SetupBackPressed() = _$SetupBackPressedImpl;
}

/// @nodoc
mixin _$SetupState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingDevices,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)
        identity,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)
        audioInput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)
        audioOutput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)
        proximity,
    required TResult Function(SetupConfig config) complete,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingDevices,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult? Function(SetupConfig config)? complete,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingDevices,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult Function(SetupConfig config)? complete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupInitial value) initial,
    required TResult Function(SetupLoadingDevices value) loadingDevices,
    required TResult Function(SetupIdentityState value) identity,
    required TResult Function(SetupAudioInputState value) audioInput,
    required TResult Function(SetupAudioOutputState value) audioOutput,
    required TResult Function(SetupProximityState value) proximity,
    required TResult Function(SetupCompleteState value) complete,
    required TResult Function(SetupErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupInitial value)? initial,
    TResult? Function(SetupLoadingDevices value)? loadingDevices,
    TResult? Function(SetupIdentityState value)? identity,
    TResult? Function(SetupAudioInputState value)? audioInput,
    TResult? Function(SetupAudioOutputState value)? audioOutput,
    TResult? Function(SetupProximityState value)? proximity,
    TResult? Function(SetupCompleteState value)? complete,
    TResult? Function(SetupErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupInitial value)? initial,
    TResult Function(SetupLoadingDevices value)? loadingDevices,
    TResult Function(SetupIdentityState value)? identity,
    TResult Function(SetupAudioInputState value)? audioInput,
    TResult Function(SetupAudioOutputState value)? audioOutput,
    TResult Function(SetupProximityState value)? proximity,
    TResult Function(SetupCompleteState value)? complete,
    TResult Function(SetupErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetupStateCopyWith<$Res> {
  factory $SetupStateCopyWith(
          SetupState value, $Res Function(SetupState) then) =
      _$SetupStateCopyWithImpl<$Res, SetupState>;
}

/// @nodoc
class _$SetupStateCopyWithImpl<$Res, $Val extends SetupState>
    implements $SetupStateCopyWith<$Res> {
  _$SetupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SetupInitialImplCopyWith<$Res> {
  factory _$$SetupInitialImplCopyWith(
          _$SetupInitialImpl value, $Res Function(_$SetupInitialImpl) then) =
      __$$SetupInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SetupInitialImplCopyWithImpl<$Res>
    extends _$SetupStateCopyWithImpl<$Res, _$SetupInitialImpl>
    implements _$$SetupInitialImplCopyWith<$Res> {
  __$$SetupInitialImplCopyWithImpl(
      _$SetupInitialImpl _value, $Res Function(_$SetupInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SetupInitialImpl implements SetupInitial {
  const _$SetupInitialImpl();

  @override
  String toString() {
    return 'SetupState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SetupInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingDevices,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)
        identity,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)
        audioInput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)
        audioOutput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)
        proximity,
    required TResult Function(SetupConfig config) complete,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingDevices,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult? Function(SetupConfig config)? complete,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingDevices,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult Function(SetupConfig config)? complete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupInitial value) initial,
    required TResult Function(SetupLoadingDevices value) loadingDevices,
    required TResult Function(SetupIdentityState value) identity,
    required TResult Function(SetupAudioInputState value) audioInput,
    required TResult Function(SetupAudioOutputState value) audioOutput,
    required TResult Function(SetupProximityState value) proximity,
    required TResult Function(SetupCompleteState value) complete,
    required TResult Function(SetupErrorState value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupInitial value)? initial,
    TResult? Function(SetupLoadingDevices value)? loadingDevices,
    TResult? Function(SetupIdentityState value)? identity,
    TResult? Function(SetupAudioInputState value)? audioInput,
    TResult? Function(SetupAudioOutputState value)? audioOutput,
    TResult? Function(SetupProximityState value)? proximity,
    TResult? Function(SetupCompleteState value)? complete,
    TResult? Function(SetupErrorState value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupInitial value)? initial,
    TResult Function(SetupLoadingDevices value)? loadingDevices,
    TResult Function(SetupIdentityState value)? identity,
    TResult Function(SetupAudioInputState value)? audioInput,
    TResult Function(SetupAudioOutputState value)? audioOutput,
    TResult Function(SetupProximityState value)? proximity,
    TResult Function(SetupCompleteState value)? complete,
    TResult Function(SetupErrorState value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SetupInitial implements SetupState {
  const factory SetupInitial() = _$SetupInitialImpl;
}

/// @nodoc
abstract class _$$SetupLoadingDevicesImplCopyWith<$Res> {
  factory _$$SetupLoadingDevicesImplCopyWith(_$SetupLoadingDevicesImpl value,
          $Res Function(_$SetupLoadingDevicesImpl) then) =
      __$$SetupLoadingDevicesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SetupLoadingDevicesImplCopyWithImpl<$Res>
    extends _$SetupStateCopyWithImpl<$Res, _$SetupLoadingDevicesImpl>
    implements _$$SetupLoadingDevicesImplCopyWith<$Res> {
  __$$SetupLoadingDevicesImplCopyWithImpl(_$SetupLoadingDevicesImpl _value,
      $Res Function(_$SetupLoadingDevicesImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SetupLoadingDevicesImpl implements SetupLoadingDevices {
  const _$SetupLoadingDevicesImpl();

  @override
  String toString() {
    return 'SetupState.loadingDevices()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupLoadingDevicesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingDevices,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)
        identity,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)
        audioInput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)
        audioOutput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)
        proximity,
    required TResult Function(SetupConfig config) complete,
    required TResult Function(String message) error,
  }) {
    return loadingDevices();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingDevices,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult? Function(SetupConfig config)? complete,
    TResult? Function(String message)? error,
  }) {
    return loadingDevices?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingDevices,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult Function(SetupConfig config)? complete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loadingDevices != null) {
      return loadingDevices();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupInitial value) initial,
    required TResult Function(SetupLoadingDevices value) loadingDevices,
    required TResult Function(SetupIdentityState value) identity,
    required TResult Function(SetupAudioInputState value) audioInput,
    required TResult Function(SetupAudioOutputState value) audioOutput,
    required TResult Function(SetupProximityState value) proximity,
    required TResult Function(SetupCompleteState value) complete,
    required TResult Function(SetupErrorState value) error,
  }) {
    return loadingDevices(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupInitial value)? initial,
    TResult? Function(SetupLoadingDevices value)? loadingDevices,
    TResult? Function(SetupIdentityState value)? identity,
    TResult? Function(SetupAudioInputState value)? audioInput,
    TResult? Function(SetupAudioOutputState value)? audioOutput,
    TResult? Function(SetupProximityState value)? proximity,
    TResult? Function(SetupCompleteState value)? complete,
    TResult? Function(SetupErrorState value)? error,
  }) {
    return loadingDevices?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupInitial value)? initial,
    TResult Function(SetupLoadingDevices value)? loadingDevices,
    TResult Function(SetupIdentityState value)? identity,
    TResult Function(SetupAudioInputState value)? audioInput,
    TResult Function(SetupAudioOutputState value)? audioOutput,
    TResult Function(SetupProximityState value)? proximity,
    TResult Function(SetupCompleteState value)? complete,
    TResult Function(SetupErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loadingDevices != null) {
      return loadingDevices(this);
    }
    return orElse();
  }
}

abstract class SetupLoadingDevices implements SetupState {
  const factory SetupLoadingDevices() = _$SetupLoadingDevicesImpl;
}

/// @nodoc
abstract class _$$SetupIdentityStateImplCopyWith<$Res> {
  factory _$$SetupIdentityStateImplCopyWith(_$SetupIdentityStateImpl value,
          $Res Function(_$SetupIdentityStateImpl) then) =
      __$$SetupIdentityStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String username,
      String hubHost,
      int hubPort,
      List<AudioDeviceInfo> inputDevices,
      List<AudioDeviceInfo> outputDevices,
      List<AudioSessionInfo> audioSessions});
}

/// @nodoc
class __$$SetupIdentityStateImplCopyWithImpl<$Res>
    extends _$SetupStateCopyWithImpl<$Res, _$SetupIdentityStateImpl>
    implements _$$SetupIdentityStateImplCopyWith<$Res> {
  __$$SetupIdentityStateImplCopyWithImpl(_$SetupIdentityStateImpl _value,
      $Res Function(_$SetupIdentityStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? hubHost = null,
    Object? hubPort = null,
    Object? inputDevices = null,
    Object? outputDevices = null,
    Object? audioSessions = null,
  }) {
    return _then(_$SetupIdentityStateImpl(
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
      inputDevices: null == inputDevices
          ? _value._inputDevices
          : inputDevices // ignore: cast_nullable_to_non_nullable
              as List<AudioDeviceInfo>,
      outputDevices: null == outputDevices
          ? _value._outputDevices
          : outputDevices // ignore: cast_nullable_to_non_nullable
              as List<AudioDeviceInfo>,
      audioSessions: null == audioSessions
          ? _value._audioSessions
          : audioSessions // ignore: cast_nullable_to_non_nullable
              as List<AudioSessionInfo>,
    ));
  }
}

/// @nodoc

class _$SetupIdentityStateImpl implements SetupIdentityState {
  const _$SetupIdentityStateImpl(
      {this.username = '',
      this.hubHost = kDefaultHubHost,
      this.hubPort = kDefaultHubPort,
      final List<AudioDeviceInfo> inputDevices = const [],
      final List<AudioDeviceInfo> outputDevices = const [],
      final List<AudioSessionInfo> audioSessions = const []})
      : _inputDevices = inputDevices,
        _outputDevices = outputDevices,
        _audioSessions = audioSessions;

  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final String hubHost;
  @override
  @JsonKey()
  final int hubPort;
  final List<AudioDeviceInfo> _inputDevices;
  @override
  @JsonKey()
  List<AudioDeviceInfo> get inputDevices {
    if (_inputDevices is EqualUnmodifiableListView) return _inputDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inputDevices);
  }

  final List<AudioDeviceInfo> _outputDevices;
  @override
  @JsonKey()
  List<AudioDeviceInfo> get outputDevices {
    if (_outputDevices is EqualUnmodifiableListView) return _outputDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outputDevices);
  }

  final List<AudioSessionInfo> _audioSessions;
  @override
  @JsonKey()
  List<AudioSessionInfo> get audioSessions {
    if (_audioSessions is EqualUnmodifiableListView) return _audioSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audioSessions);
  }

  @override
  String toString() {
    return 'SetupState.identity(username: $username, hubHost: $hubHost, hubPort: $hubPort, inputDevices: $inputDevices, outputDevices: $outputDevices, audioSessions: $audioSessions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupIdentityStateImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.hubHost, hubHost) || other.hubHost == hubHost) &&
            (identical(other.hubPort, hubPort) || other.hubPort == hubPort) &&
            const DeepCollectionEquality()
                .equals(other._inputDevices, _inputDevices) &&
            const DeepCollectionEquality()
                .equals(other._outputDevices, _outputDevices) &&
            const DeepCollectionEquality()
                .equals(other._audioSessions, _audioSessions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      hubHost,
      hubPort,
      const DeepCollectionEquality().hash(_inputDevices),
      const DeepCollectionEquality().hash(_outputDevices),
      const DeepCollectionEquality().hash(_audioSessions));

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupIdentityStateImplCopyWith<_$SetupIdentityStateImpl> get copyWith =>
      __$$SetupIdentityStateImplCopyWithImpl<_$SetupIdentityStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingDevices,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)
        identity,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)
        audioInput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)
        audioOutput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)
        proximity,
    required TResult Function(SetupConfig config) complete,
    required TResult Function(String message) error,
  }) {
    return identity(
        username, hubHost, hubPort, inputDevices, outputDevices, audioSessions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingDevices,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult? Function(SetupConfig config)? complete,
    TResult? Function(String message)? error,
  }) {
    return identity?.call(
        username, hubHost, hubPort, inputDevices, outputDevices, audioSessions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingDevices,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult Function(SetupConfig config)? complete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (identity != null) {
      return identity(username, hubHost, hubPort, inputDevices, outputDevices,
          audioSessions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupInitial value) initial,
    required TResult Function(SetupLoadingDevices value) loadingDevices,
    required TResult Function(SetupIdentityState value) identity,
    required TResult Function(SetupAudioInputState value) audioInput,
    required TResult Function(SetupAudioOutputState value) audioOutput,
    required TResult Function(SetupProximityState value) proximity,
    required TResult Function(SetupCompleteState value) complete,
    required TResult Function(SetupErrorState value) error,
  }) {
    return identity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupInitial value)? initial,
    TResult? Function(SetupLoadingDevices value)? loadingDevices,
    TResult? Function(SetupIdentityState value)? identity,
    TResult? Function(SetupAudioInputState value)? audioInput,
    TResult? Function(SetupAudioOutputState value)? audioOutput,
    TResult? Function(SetupProximityState value)? proximity,
    TResult? Function(SetupCompleteState value)? complete,
    TResult? Function(SetupErrorState value)? error,
  }) {
    return identity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupInitial value)? initial,
    TResult Function(SetupLoadingDevices value)? loadingDevices,
    TResult Function(SetupIdentityState value)? identity,
    TResult Function(SetupAudioInputState value)? audioInput,
    TResult Function(SetupAudioOutputState value)? audioOutput,
    TResult Function(SetupProximityState value)? proximity,
    TResult Function(SetupCompleteState value)? complete,
    TResult Function(SetupErrorState value)? error,
    required TResult orElse(),
  }) {
    if (identity != null) {
      return identity(this);
    }
    return orElse();
  }
}

abstract class SetupIdentityState implements SetupState {
  const factory SetupIdentityState(
      {final String username,
      final String hubHost,
      final int hubPort,
      final List<AudioDeviceInfo> inputDevices,
      final List<AudioDeviceInfo> outputDevices,
      final List<AudioSessionInfo> audioSessions}) = _$SetupIdentityStateImpl;

  String get username;
  String get hubHost;
  int get hubPort;
  List<AudioDeviceInfo> get inputDevices;
  List<AudioDeviceInfo> get outputDevices;
  List<AudioSessionInfo> get audioSessions;

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupIdentityStateImplCopyWith<_$SetupIdentityStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetupAudioInputStateImplCopyWith<$Res> {
  factory _$$SetupAudioInputStateImplCopyWith(_$SetupAudioInputStateImpl value,
          $Res Function(_$SetupAudioInputStateImpl) then) =
      __$$SetupAudioInputStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String username,
      String hubHost,
      int hubPort,
      List<AudioDeviceInfo> inputDevices,
      List<AudioDeviceInfo> outputDevices,
      List<AudioSessionInfo> audioSessions,
      AudioInputMode selectedMode,
      AudioDeviceInfo? selectedInputDevice,
      AudioSessionInfo? selectedSession});

  $AudioDeviceInfoCopyWith<$Res>? get selectedInputDevice;
  $AudioSessionInfoCopyWith<$Res>? get selectedSession;
}

/// @nodoc
class __$$SetupAudioInputStateImplCopyWithImpl<$Res>
    extends _$SetupStateCopyWithImpl<$Res, _$SetupAudioInputStateImpl>
    implements _$$SetupAudioInputStateImplCopyWith<$Res> {
  __$$SetupAudioInputStateImplCopyWithImpl(_$SetupAudioInputStateImpl _value,
      $Res Function(_$SetupAudioInputStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? hubHost = null,
    Object? hubPort = null,
    Object? inputDevices = null,
    Object? outputDevices = null,
    Object? audioSessions = null,
    Object? selectedMode = null,
    Object? selectedInputDevice = freezed,
    Object? selectedSession = freezed,
  }) {
    return _then(_$SetupAudioInputStateImpl(
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
      inputDevices: null == inputDevices
          ? _value._inputDevices
          : inputDevices // ignore: cast_nullable_to_non_nullable
              as List<AudioDeviceInfo>,
      outputDevices: null == outputDevices
          ? _value._outputDevices
          : outputDevices // ignore: cast_nullable_to_non_nullable
              as List<AudioDeviceInfo>,
      audioSessions: null == audioSessions
          ? _value._audioSessions
          : audioSessions // ignore: cast_nullable_to_non_nullable
              as List<AudioSessionInfo>,
      selectedMode: null == selectedMode
          ? _value.selectedMode
          : selectedMode // ignore: cast_nullable_to_non_nullable
              as AudioInputMode,
      selectedInputDevice: freezed == selectedInputDevice
          ? _value.selectedInputDevice
          : selectedInputDevice // ignore: cast_nullable_to_non_nullable
              as AudioDeviceInfo?,
      selectedSession: freezed == selectedSession
          ? _value.selectedSession
          : selectedSession // ignore: cast_nullable_to_non_nullable
              as AudioSessionInfo?,
    ));
  }

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioDeviceInfoCopyWith<$Res>? get selectedInputDevice {
    if (_value.selectedInputDevice == null) {
      return null;
    }

    return $AudioDeviceInfoCopyWith<$Res>(_value.selectedInputDevice!, (value) {
      return _then(_value.copyWith(selectedInputDevice: value));
    });
  }

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioSessionInfoCopyWith<$Res>? get selectedSession {
    if (_value.selectedSession == null) {
      return null;
    }

    return $AudioSessionInfoCopyWith<$Res>(_value.selectedSession!, (value) {
      return _then(_value.copyWith(selectedSession: value));
    });
  }
}

/// @nodoc

class _$SetupAudioInputStateImpl implements SetupAudioInputState {
  const _$SetupAudioInputStateImpl(
      {required this.username,
      required this.hubHost,
      required this.hubPort,
      required final List<AudioDeviceInfo> inputDevices,
      required final List<AudioDeviceInfo> outputDevices,
      required final List<AudioSessionInfo> audioSessions,
      this.selectedMode = AudioInputMode.mic,
      this.selectedInputDevice,
      this.selectedSession})
      : _inputDevices = inputDevices,
        _outputDevices = outputDevices,
        _audioSessions = audioSessions;

  @override
  final String username;
  @override
  final String hubHost;
  @override
  final int hubPort;
  final List<AudioDeviceInfo> _inputDevices;
  @override
  List<AudioDeviceInfo> get inputDevices {
    if (_inputDevices is EqualUnmodifiableListView) return _inputDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inputDevices);
  }

  final List<AudioDeviceInfo> _outputDevices;
  @override
  List<AudioDeviceInfo> get outputDevices {
    if (_outputDevices is EqualUnmodifiableListView) return _outputDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outputDevices);
  }

  final List<AudioSessionInfo> _audioSessions;
  @override
  List<AudioSessionInfo> get audioSessions {
    if (_audioSessions is EqualUnmodifiableListView) return _audioSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audioSessions);
  }

  @override
  @JsonKey()
  final AudioInputMode selectedMode;
  @override
  final AudioDeviceInfo? selectedInputDevice;
  @override
  final AudioSessionInfo? selectedSession;

  @override
  String toString() {
    return 'SetupState.audioInput(username: $username, hubHost: $hubHost, hubPort: $hubPort, inputDevices: $inputDevices, outputDevices: $outputDevices, audioSessions: $audioSessions, selectedMode: $selectedMode, selectedInputDevice: $selectedInputDevice, selectedSession: $selectedSession)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupAudioInputStateImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.hubHost, hubHost) || other.hubHost == hubHost) &&
            (identical(other.hubPort, hubPort) || other.hubPort == hubPort) &&
            const DeepCollectionEquality()
                .equals(other._inputDevices, _inputDevices) &&
            const DeepCollectionEquality()
                .equals(other._outputDevices, _outputDevices) &&
            const DeepCollectionEquality()
                .equals(other._audioSessions, _audioSessions) &&
            (identical(other.selectedMode, selectedMode) ||
                other.selectedMode == selectedMode) &&
            (identical(other.selectedInputDevice, selectedInputDevice) ||
                other.selectedInputDevice == selectedInputDevice) &&
            (identical(other.selectedSession, selectedSession) ||
                other.selectedSession == selectedSession));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      hubHost,
      hubPort,
      const DeepCollectionEquality().hash(_inputDevices),
      const DeepCollectionEquality().hash(_outputDevices),
      const DeepCollectionEquality().hash(_audioSessions),
      selectedMode,
      selectedInputDevice,
      selectedSession);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupAudioInputStateImplCopyWith<_$SetupAudioInputStateImpl>
      get copyWith =>
          __$$SetupAudioInputStateImplCopyWithImpl<_$SetupAudioInputStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingDevices,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)
        identity,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)
        audioInput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)
        audioOutput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)
        proximity,
    required TResult Function(SetupConfig config) complete,
    required TResult Function(String message) error,
  }) {
    return audioInput(username, hubHost, hubPort, inputDevices, outputDevices,
        audioSessions, selectedMode, selectedInputDevice, selectedSession);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingDevices,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult? Function(SetupConfig config)? complete,
    TResult? Function(String message)? error,
  }) {
    return audioInput?.call(
        username,
        hubHost,
        hubPort,
        inputDevices,
        outputDevices,
        audioSessions,
        selectedMode,
        selectedInputDevice,
        selectedSession);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingDevices,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult Function(SetupConfig config)? complete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (audioInput != null) {
      return audioInput(username, hubHost, hubPort, inputDevices, outputDevices,
          audioSessions, selectedMode, selectedInputDevice, selectedSession);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupInitial value) initial,
    required TResult Function(SetupLoadingDevices value) loadingDevices,
    required TResult Function(SetupIdentityState value) identity,
    required TResult Function(SetupAudioInputState value) audioInput,
    required TResult Function(SetupAudioOutputState value) audioOutput,
    required TResult Function(SetupProximityState value) proximity,
    required TResult Function(SetupCompleteState value) complete,
    required TResult Function(SetupErrorState value) error,
  }) {
    return audioInput(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupInitial value)? initial,
    TResult? Function(SetupLoadingDevices value)? loadingDevices,
    TResult? Function(SetupIdentityState value)? identity,
    TResult? Function(SetupAudioInputState value)? audioInput,
    TResult? Function(SetupAudioOutputState value)? audioOutput,
    TResult? Function(SetupProximityState value)? proximity,
    TResult? Function(SetupCompleteState value)? complete,
    TResult? Function(SetupErrorState value)? error,
  }) {
    return audioInput?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupInitial value)? initial,
    TResult Function(SetupLoadingDevices value)? loadingDevices,
    TResult Function(SetupIdentityState value)? identity,
    TResult Function(SetupAudioInputState value)? audioInput,
    TResult Function(SetupAudioOutputState value)? audioOutput,
    TResult Function(SetupProximityState value)? proximity,
    TResult Function(SetupCompleteState value)? complete,
    TResult Function(SetupErrorState value)? error,
    required TResult orElse(),
  }) {
    if (audioInput != null) {
      return audioInput(this);
    }
    return orElse();
  }
}

abstract class SetupAudioInputState implements SetupState {
  const factory SetupAudioInputState(
      {required final String username,
      required final String hubHost,
      required final int hubPort,
      required final List<AudioDeviceInfo> inputDevices,
      required final List<AudioDeviceInfo> outputDevices,
      required final List<AudioSessionInfo> audioSessions,
      final AudioInputMode selectedMode,
      final AudioDeviceInfo? selectedInputDevice,
      final AudioSessionInfo? selectedSession}) = _$SetupAudioInputStateImpl;

  String get username;
  String get hubHost;
  int get hubPort;
  List<AudioDeviceInfo> get inputDevices;
  List<AudioDeviceInfo> get outputDevices;
  List<AudioSessionInfo> get audioSessions;
  AudioInputMode get selectedMode;
  AudioDeviceInfo? get selectedInputDevice;
  AudioSessionInfo? get selectedSession;

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupAudioInputStateImplCopyWith<_$SetupAudioInputStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetupAudioOutputStateImplCopyWith<$Res> {
  factory _$$SetupAudioOutputStateImplCopyWith(
          _$SetupAudioOutputStateImpl value,
          $Res Function(_$SetupAudioOutputStateImpl) then) =
      __$$SetupAudioOutputStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String username,
      String hubHost,
      int hubPort,
      AudioInputMode inputMode,
      AudioDeviceInfo? inputDevice,
      AudioSessionInfo? audioSession,
      List<AudioDeviceInfo> outputDevices,
      AudioDeviceInfo? selectedOutputDevice});

  $AudioDeviceInfoCopyWith<$Res>? get inputDevice;
  $AudioSessionInfoCopyWith<$Res>? get audioSession;
  $AudioDeviceInfoCopyWith<$Res>? get selectedOutputDevice;
}

/// @nodoc
class __$$SetupAudioOutputStateImplCopyWithImpl<$Res>
    extends _$SetupStateCopyWithImpl<$Res, _$SetupAudioOutputStateImpl>
    implements _$$SetupAudioOutputStateImplCopyWith<$Res> {
  __$$SetupAudioOutputStateImplCopyWithImpl(_$SetupAudioOutputStateImpl _value,
      $Res Function(_$SetupAudioOutputStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupState
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
    Object? outputDevices = null,
    Object? selectedOutputDevice = freezed,
  }) {
    return _then(_$SetupAudioOutputStateImpl(
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
      outputDevices: null == outputDevices
          ? _value._outputDevices
          : outputDevices // ignore: cast_nullable_to_non_nullable
              as List<AudioDeviceInfo>,
      selectedOutputDevice: freezed == selectedOutputDevice
          ? _value.selectedOutputDevice
          : selectedOutputDevice // ignore: cast_nullable_to_non_nullable
              as AudioDeviceInfo?,
    ));
  }

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioDeviceInfoCopyWith<$Res>? get inputDevice {
    if (_value.inputDevice == null) {
      return null;
    }

    return $AudioDeviceInfoCopyWith<$Res>(_value.inputDevice!, (value) {
      return _then(_value.copyWith(inputDevice: value));
    });
  }

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioSessionInfoCopyWith<$Res>? get audioSession {
    if (_value.audioSession == null) {
      return null;
    }

    return $AudioSessionInfoCopyWith<$Res>(_value.audioSession!, (value) {
      return _then(_value.copyWith(audioSession: value));
    });
  }

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioDeviceInfoCopyWith<$Res>? get selectedOutputDevice {
    if (_value.selectedOutputDevice == null) {
      return null;
    }

    return $AudioDeviceInfoCopyWith<$Res>(_value.selectedOutputDevice!,
        (value) {
      return _then(_value.copyWith(selectedOutputDevice: value));
    });
  }
}

/// @nodoc

class _$SetupAudioOutputStateImpl implements SetupAudioOutputState {
  const _$SetupAudioOutputStateImpl(
      {required this.username,
      required this.hubHost,
      required this.hubPort,
      required this.inputMode,
      this.inputDevice,
      this.audioSession,
      required final List<AudioDeviceInfo> outputDevices,
      this.selectedOutputDevice})
      : _outputDevices = outputDevices;

  @override
  final String username;
  @override
  final String hubHost;
  @override
  final int hubPort;
  @override
  final AudioInputMode inputMode;
  @override
  final AudioDeviceInfo? inputDevice;
  @override
  final AudioSessionInfo? audioSession;
  final List<AudioDeviceInfo> _outputDevices;
  @override
  List<AudioDeviceInfo> get outputDevices {
    if (_outputDevices is EqualUnmodifiableListView) return _outputDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outputDevices);
  }

  @override
  final AudioDeviceInfo? selectedOutputDevice;

  @override
  String toString() {
    return 'SetupState.audioOutput(username: $username, hubHost: $hubHost, hubPort: $hubPort, inputMode: $inputMode, inputDevice: $inputDevice, audioSession: $audioSession, outputDevices: $outputDevices, selectedOutputDevice: $selectedOutputDevice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupAudioOutputStateImpl &&
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
            const DeepCollectionEquality()
                .equals(other._outputDevices, _outputDevices) &&
            (identical(other.selectedOutputDevice, selectedOutputDevice) ||
                other.selectedOutputDevice == selectedOutputDevice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      hubHost,
      hubPort,
      inputMode,
      inputDevice,
      audioSession,
      const DeepCollectionEquality().hash(_outputDevices),
      selectedOutputDevice);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupAudioOutputStateImplCopyWith<_$SetupAudioOutputStateImpl>
      get copyWith => __$$SetupAudioOutputStateImplCopyWithImpl<
          _$SetupAudioOutputStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingDevices,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)
        identity,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)
        audioInput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)
        audioOutput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)
        proximity,
    required TResult Function(SetupConfig config) complete,
    required TResult Function(String message) error,
  }) {
    return audioOutput(username, hubHost, hubPort, inputMode, inputDevice,
        audioSession, outputDevices, selectedOutputDevice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingDevices,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult? Function(SetupConfig config)? complete,
    TResult? Function(String message)? error,
  }) {
    return audioOutput?.call(username, hubHost, hubPort, inputMode, inputDevice,
        audioSession, outputDevices, selectedOutputDevice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingDevices,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult Function(SetupConfig config)? complete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (audioOutput != null) {
      return audioOutput(username, hubHost, hubPort, inputMode, inputDevice,
          audioSession, outputDevices, selectedOutputDevice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupInitial value) initial,
    required TResult Function(SetupLoadingDevices value) loadingDevices,
    required TResult Function(SetupIdentityState value) identity,
    required TResult Function(SetupAudioInputState value) audioInput,
    required TResult Function(SetupAudioOutputState value) audioOutput,
    required TResult Function(SetupProximityState value) proximity,
    required TResult Function(SetupCompleteState value) complete,
    required TResult Function(SetupErrorState value) error,
  }) {
    return audioOutput(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupInitial value)? initial,
    TResult? Function(SetupLoadingDevices value)? loadingDevices,
    TResult? Function(SetupIdentityState value)? identity,
    TResult? Function(SetupAudioInputState value)? audioInput,
    TResult? Function(SetupAudioOutputState value)? audioOutput,
    TResult? Function(SetupProximityState value)? proximity,
    TResult? Function(SetupCompleteState value)? complete,
    TResult? Function(SetupErrorState value)? error,
  }) {
    return audioOutput?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupInitial value)? initial,
    TResult Function(SetupLoadingDevices value)? loadingDevices,
    TResult Function(SetupIdentityState value)? identity,
    TResult Function(SetupAudioInputState value)? audioInput,
    TResult Function(SetupAudioOutputState value)? audioOutput,
    TResult Function(SetupProximityState value)? proximity,
    TResult Function(SetupCompleteState value)? complete,
    TResult Function(SetupErrorState value)? error,
    required TResult orElse(),
  }) {
    if (audioOutput != null) {
      return audioOutput(this);
    }
    return orElse();
  }
}

abstract class SetupAudioOutputState implements SetupState {
  const factory SetupAudioOutputState(
          {required final String username,
          required final String hubHost,
          required final int hubPort,
          required final AudioInputMode inputMode,
          final AudioDeviceInfo? inputDevice,
          final AudioSessionInfo? audioSession,
          required final List<AudioDeviceInfo> outputDevices,
          final AudioDeviceInfo? selectedOutputDevice}) =
      _$SetupAudioOutputStateImpl;

  String get username;
  String get hubHost;
  int get hubPort;
  AudioInputMode get inputMode;
  AudioDeviceInfo? get inputDevice;
  AudioSessionInfo? get audioSession;
  List<AudioDeviceInfo> get outputDevices;
  AudioDeviceInfo? get selectedOutputDevice;

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupAudioOutputStateImplCopyWith<_$SetupAudioOutputStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetupProximityStateImplCopyWith<$Res> {
  factory _$$SetupProximityStateImplCopyWith(_$SetupProximityStateImpl value,
          $Res Function(_$SetupProximityStateImpl) then) =
      __$$SetupProximityStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String username,
      String hubHost,
      int hubPort,
      AudioInputMode inputMode,
      AudioDeviceInfo? inputDevice,
      AudioSessionInfo? audioSession,
      AudioDeviceInfo? outputDevice,
      ProximityParams params});

  $AudioDeviceInfoCopyWith<$Res>? get inputDevice;
  $AudioSessionInfoCopyWith<$Res>? get audioSession;
  $AudioDeviceInfoCopyWith<$Res>? get outputDevice;
  $ProximityParamsCopyWith<$Res> get params;
}

/// @nodoc
class __$$SetupProximityStateImplCopyWithImpl<$Res>
    extends _$SetupStateCopyWithImpl<$Res, _$SetupProximityStateImpl>
    implements _$$SetupProximityStateImplCopyWith<$Res> {
  __$$SetupProximityStateImplCopyWithImpl(_$SetupProximityStateImpl _value,
      $Res Function(_$SetupProximityStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupState
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
    Object? params = null,
  }) {
    return _then(_$SetupProximityStateImpl(
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
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as ProximityParams,
    ));
  }

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioDeviceInfoCopyWith<$Res>? get inputDevice {
    if (_value.inputDevice == null) {
      return null;
    }

    return $AudioDeviceInfoCopyWith<$Res>(_value.inputDevice!, (value) {
      return _then(_value.copyWith(inputDevice: value));
    });
  }

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioSessionInfoCopyWith<$Res>? get audioSession {
    if (_value.audioSession == null) {
      return null;
    }

    return $AudioSessionInfoCopyWith<$Res>(_value.audioSession!, (value) {
      return _then(_value.copyWith(audioSession: value));
    });
  }

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioDeviceInfoCopyWith<$Res>? get outputDevice {
    if (_value.outputDevice == null) {
      return null;
    }

    return $AudioDeviceInfoCopyWith<$Res>(_value.outputDevice!, (value) {
      return _then(_value.copyWith(outputDevice: value));
    });
  }

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProximityParamsCopyWith<$Res> get params {
    return $ProximityParamsCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value));
    });
  }
}

/// @nodoc

class _$SetupProximityStateImpl implements SetupProximityState {
  const _$SetupProximityStateImpl(
      {required this.username,
      required this.hubHost,
      required this.hubPort,
      required this.inputMode,
      this.inputDevice,
      this.audioSession,
      this.outputDevice,
      this.params = const ProximityParams()});

  @override
  final String username;
  @override
  final String hubHost;
  @override
  final int hubPort;
  @override
  final AudioInputMode inputMode;
  @override
  final AudioDeviceInfo? inputDevice;
  @override
  final AudioSessionInfo? audioSession;
  @override
  final AudioDeviceInfo? outputDevice;
  @override
  @JsonKey()
  final ProximityParams params;

  @override
  String toString() {
    return 'SetupState.proximity(username: $username, hubHost: $hubHost, hubPort: $hubPort, inputMode: $inputMode, inputDevice: $inputDevice, audioSession: $audioSession, outputDevice: $outputDevice, params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupProximityStateImpl &&
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
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, hubHost, hubPort,
      inputMode, inputDevice, audioSession, outputDevice, params);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupProximityStateImplCopyWith<_$SetupProximityStateImpl> get copyWith =>
      __$$SetupProximityStateImplCopyWithImpl<_$SetupProximityStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingDevices,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)
        identity,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)
        audioInput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)
        audioOutput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)
        proximity,
    required TResult Function(SetupConfig config) complete,
    required TResult Function(String message) error,
  }) {
    return proximity(username, hubHost, hubPort, inputMode, inputDevice,
        audioSession, outputDevice, params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingDevices,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult? Function(SetupConfig config)? complete,
    TResult? Function(String message)? error,
  }) {
    return proximity?.call(username, hubHost, hubPort, inputMode, inputDevice,
        audioSession, outputDevice, params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingDevices,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult Function(SetupConfig config)? complete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (proximity != null) {
      return proximity(username, hubHost, hubPort, inputMode, inputDevice,
          audioSession, outputDevice, params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupInitial value) initial,
    required TResult Function(SetupLoadingDevices value) loadingDevices,
    required TResult Function(SetupIdentityState value) identity,
    required TResult Function(SetupAudioInputState value) audioInput,
    required TResult Function(SetupAudioOutputState value) audioOutput,
    required TResult Function(SetupProximityState value) proximity,
    required TResult Function(SetupCompleteState value) complete,
    required TResult Function(SetupErrorState value) error,
  }) {
    return proximity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupInitial value)? initial,
    TResult? Function(SetupLoadingDevices value)? loadingDevices,
    TResult? Function(SetupIdentityState value)? identity,
    TResult? Function(SetupAudioInputState value)? audioInput,
    TResult? Function(SetupAudioOutputState value)? audioOutput,
    TResult? Function(SetupProximityState value)? proximity,
    TResult? Function(SetupCompleteState value)? complete,
    TResult? Function(SetupErrorState value)? error,
  }) {
    return proximity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupInitial value)? initial,
    TResult Function(SetupLoadingDevices value)? loadingDevices,
    TResult Function(SetupIdentityState value)? identity,
    TResult Function(SetupAudioInputState value)? audioInput,
    TResult Function(SetupAudioOutputState value)? audioOutput,
    TResult Function(SetupProximityState value)? proximity,
    TResult Function(SetupCompleteState value)? complete,
    TResult Function(SetupErrorState value)? error,
    required TResult orElse(),
  }) {
    if (proximity != null) {
      return proximity(this);
    }
    return orElse();
  }
}

abstract class SetupProximityState implements SetupState {
  const factory SetupProximityState(
      {required final String username,
      required final String hubHost,
      required final int hubPort,
      required final AudioInputMode inputMode,
      final AudioDeviceInfo? inputDevice,
      final AudioSessionInfo? audioSession,
      final AudioDeviceInfo? outputDevice,
      final ProximityParams params}) = _$SetupProximityStateImpl;

  String get username;
  String get hubHost;
  int get hubPort;
  AudioInputMode get inputMode;
  AudioDeviceInfo? get inputDevice;
  AudioSessionInfo? get audioSession;
  AudioDeviceInfo? get outputDevice;
  ProximityParams get params;

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupProximityStateImplCopyWith<_$SetupProximityStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetupCompleteStateImplCopyWith<$Res> {
  factory _$$SetupCompleteStateImplCopyWith(_$SetupCompleteStateImpl value,
          $Res Function(_$SetupCompleteStateImpl) then) =
      __$$SetupCompleteStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SetupConfig config});

  $SetupConfigCopyWith<$Res> get config;
}

/// @nodoc
class __$$SetupCompleteStateImplCopyWithImpl<$Res>
    extends _$SetupStateCopyWithImpl<$Res, _$SetupCompleteStateImpl>
    implements _$$SetupCompleteStateImplCopyWith<$Res> {
  __$$SetupCompleteStateImplCopyWithImpl(_$SetupCompleteStateImpl _value,
      $Res Function(_$SetupCompleteStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$SetupCompleteStateImpl(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as SetupConfig,
    ));
  }

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SetupConfigCopyWith<$Res> get config {
    return $SetupConfigCopyWith<$Res>(_value.config, (value) {
      return _then(_value.copyWith(config: value));
    });
  }
}

/// @nodoc

class _$SetupCompleteStateImpl implements SetupCompleteState {
  const _$SetupCompleteStateImpl({required this.config});

  @override
  final SetupConfig config;

  @override
  String toString() {
    return 'SetupState.complete(config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupCompleteStateImpl &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupCompleteStateImplCopyWith<_$SetupCompleteStateImpl> get copyWith =>
      __$$SetupCompleteStateImplCopyWithImpl<_$SetupCompleteStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingDevices,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)
        identity,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)
        audioInput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)
        audioOutput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)
        proximity,
    required TResult Function(SetupConfig config) complete,
    required TResult Function(String message) error,
  }) {
    return complete(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingDevices,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult? Function(SetupConfig config)? complete,
    TResult? Function(String message)? error,
  }) {
    return complete?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingDevices,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult Function(SetupConfig config)? complete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(config);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupInitial value) initial,
    required TResult Function(SetupLoadingDevices value) loadingDevices,
    required TResult Function(SetupIdentityState value) identity,
    required TResult Function(SetupAudioInputState value) audioInput,
    required TResult Function(SetupAudioOutputState value) audioOutput,
    required TResult Function(SetupProximityState value) proximity,
    required TResult Function(SetupCompleteState value) complete,
    required TResult Function(SetupErrorState value) error,
  }) {
    return complete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupInitial value)? initial,
    TResult? Function(SetupLoadingDevices value)? loadingDevices,
    TResult? Function(SetupIdentityState value)? identity,
    TResult? Function(SetupAudioInputState value)? audioInput,
    TResult? Function(SetupAudioOutputState value)? audioOutput,
    TResult? Function(SetupProximityState value)? proximity,
    TResult? Function(SetupCompleteState value)? complete,
    TResult? Function(SetupErrorState value)? error,
  }) {
    return complete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupInitial value)? initial,
    TResult Function(SetupLoadingDevices value)? loadingDevices,
    TResult Function(SetupIdentityState value)? identity,
    TResult Function(SetupAudioInputState value)? audioInput,
    TResult Function(SetupAudioOutputState value)? audioOutput,
    TResult Function(SetupProximityState value)? proximity,
    TResult Function(SetupCompleteState value)? complete,
    TResult Function(SetupErrorState value)? error,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(this);
    }
    return orElse();
  }
}

abstract class SetupCompleteState implements SetupState {
  const factory SetupCompleteState({required final SetupConfig config}) =
      _$SetupCompleteStateImpl;

  SetupConfig get config;

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupCompleteStateImplCopyWith<_$SetupCompleteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetupErrorStateImplCopyWith<$Res> {
  factory _$$SetupErrorStateImplCopyWith(_$SetupErrorStateImpl value,
          $Res Function(_$SetupErrorStateImpl) then) =
      __$$SetupErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SetupErrorStateImplCopyWithImpl<$Res>
    extends _$SetupStateCopyWithImpl<$Res, _$SetupErrorStateImpl>
    implements _$$SetupErrorStateImplCopyWith<$Res> {
  __$$SetupErrorStateImplCopyWithImpl(
      _$SetupErrorStateImpl _value, $Res Function(_$SetupErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SetupErrorStateImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetupErrorStateImpl implements SetupErrorState {
  const _$SetupErrorStateImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'SetupState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetupErrorStateImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetupErrorStateImplCopyWith<_$SetupErrorStateImpl> get copyWith =>
      __$$SetupErrorStateImplCopyWithImpl<_$SetupErrorStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingDevices,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)
        identity,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)
        audioInput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)
        audioOutput,
    required TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)
        proximity,
    required TResult Function(SetupConfig config) complete,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingDevices,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult? Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult? Function(SetupConfig config)? complete,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingDevices,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions)?
        identity,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            List<AudioDeviceInfo> inputDevices,
            List<AudioDeviceInfo> outputDevices,
            List<AudioSessionInfo> audioSessions,
            AudioInputMode selectedMode,
            AudioDeviceInfo? selectedInputDevice,
            AudioSessionInfo? selectedSession)?
        audioInput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            List<AudioDeviceInfo> outputDevices,
            AudioDeviceInfo? selectedOutputDevice)?
        audioOutput,
    TResult Function(
            String username,
            String hubHost,
            int hubPort,
            AudioInputMode inputMode,
            AudioDeviceInfo? inputDevice,
            AudioSessionInfo? audioSession,
            AudioDeviceInfo? outputDevice,
            ProximityParams params)?
        proximity,
    TResult Function(SetupConfig config)? complete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetupInitial value) initial,
    required TResult Function(SetupLoadingDevices value) loadingDevices,
    required TResult Function(SetupIdentityState value) identity,
    required TResult Function(SetupAudioInputState value) audioInput,
    required TResult Function(SetupAudioOutputState value) audioOutput,
    required TResult Function(SetupProximityState value) proximity,
    required TResult Function(SetupCompleteState value) complete,
    required TResult Function(SetupErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetupInitial value)? initial,
    TResult? Function(SetupLoadingDevices value)? loadingDevices,
    TResult? Function(SetupIdentityState value)? identity,
    TResult? Function(SetupAudioInputState value)? audioInput,
    TResult? Function(SetupAudioOutputState value)? audioOutput,
    TResult? Function(SetupProximityState value)? proximity,
    TResult? Function(SetupCompleteState value)? complete,
    TResult? Function(SetupErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetupInitial value)? initial,
    TResult Function(SetupLoadingDevices value)? loadingDevices,
    TResult Function(SetupIdentityState value)? identity,
    TResult Function(SetupAudioInputState value)? audioInput,
    TResult Function(SetupAudioOutputState value)? audioOutput,
    TResult Function(SetupProximityState value)? proximity,
    TResult Function(SetupCompleteState value)? complete,
    TResult Function(SetupErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SetupErrorState implements SetupState {
  const factory SetupErrorState({required final String message}) =
      _$SetupErrorStateImpl;

  String get message;

  /// Create a copy of SetupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetupErrorStateImplCopyWith<_$SetupErrorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
