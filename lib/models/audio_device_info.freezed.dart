// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_device_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioDeviceInfo {
  int get index => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isOutput => throw _privateConstructorUsedError;
  bool get isLoopback => throw _privateConstructorUsedError;

  /// Create a copy of AudioDeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioDeviceInfoCopyWith<AudioDeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioDeviceInfoCopyWith<$Res> {
  factory $AudioDeviceInfoCopyWith(
          AudioDeviceInfo value, $Res Function(AudioDeviceInfo) then) =
      _$AudioDeviceInfoCopyWithImpl<$Res, AudioDeviceInfo>;
  @useResult
  $Res call({int index, String name, bool isOutput, bool isLoopback});
}

/// @nodoc
class _$AudioDeviceInfoCopyWithImpl<$Res, $Val extends AudioDeviceInfo>
    implements $AudioDeviceInfoCopyWith<$Res> {
  _$AudioDeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioDeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? name = null,
    Object? isOutput = null,
    Object? isLoopback = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isOutput: null == isOutput
          ? _value.isOutput
          : isOutput // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoopback: null == isLoopback
          ? _value.isLoopback
          : isLoopback // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioDeviceInfoImplCopyWith<$Res>
    implements $AudioDeviceInfoCopyWith<$Res> {
  factory _$$AudioDeviceInfoImplCopyWith(_$AudioDeviceInfoImpl value,
          $Res Function(_$AudioDeviceInfoImpl) then) =
      __$$AudioDeviceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, String name, bool isOutput, bool isLoopback});
}

/// @nodoc
class __$$AudioDeviceInfoImplCopyWithImpl<$Res>
    extends _$AudioDeviceInfoCopyWithImpl<$Res, _$AudioDeviceInfoImpl>
    implements _$$AudioDeviceInfoImplCopyWith<$Res> {
  __$$AudioDeviceInfoImplCopyWithImpl(
      _$AudioDeviceInfoImpl _value, $Res Function(_$AudioDeviceInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioDeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? name = null,
    Object? isOutput = null,
    Object? isLoopback = null,
  }) {
    return _then(_$AudioDeviceInfoImpl(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isOutput: null == isOutput
          ? _value.isOutput
          : isOutput // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoopback: null == isLoopback
          ? _value.isLoopback
          : isLoopback // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AudioDeviceInfoImpl implements _AudioDeviceInfo {
  const _$AudioDeviceInfoImpl(
      {required this.index,
      required this.name,
      this.isOutput = false,
      this.isLoopback = false});

  @override
  final int index;
  @override
  final String name;
  @override
  @JsonKey()
  final bool isOutput;
  @override
  @JsonKey()
  final bool isLoopback;

  @override
  String toString() {
    return 'AudioDeviceInfo(index: $index, name: $name, isOutput: $isOutput, isLoopback: $isLoopback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioDeviceInfoImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isOutput, isOutput) ||
                other.isOutput == isOutput) &&
            (identical(other.isLoopback, isLoopback) ||
                other.isLoopback == isLoopback));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, index, name, isOutput, isLoopback);

  /// Create a copy of AudioDeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioDeviceInfoImplCopyWith<_$AudioDeviceInfoImpl> get copyWith =>
      __$$AudioDeviceInfoImplCopyWithImpl<_$AudioDeviceInfoImpl>(
          this, _$identity);
}

abstract class _AudioDeviceInfo implements AudioDeviceInfo {
  const factory _AudioDeviceInfo(
      {required final int index,
      required final String name,
      final bool isOutput,
      final bool isLoopback}) = _$AudioDeviceInfoImpl;

  @override
  int get index;
  @override
  String get name;
  @override
  bool get isOutput;
  @override
  bool get isLoopback;

  /// Create a copy of AudioDeviceInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioDeviceInfoImplCopyWith<_$AudioDeviceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AudioSessionInfo {
  int get pid => throw _privateConstructorUsedError;
  String get exeName => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  int get loopbackIndex => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  int get sharedWith => throw _privateConstructorUsedError;

  /// Create a copy of AudioSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioSessionInfoCopyWith<AudioSessionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioSessionInfoCopyWith<$Res> {
  factory $AudioSessionInfoCopyWith(
          AudioSessionInfo value, $Res Function(AudioSessionInfo) then) =
      _$AudioSessionInfoCopyWithImpl<$Res, AudioSessionInfo>;
  @useResult
  $Res call(
      {int pid,
      String exeName,
      String displayName,
      int loopbackIndex,
      String deviceName,
      int sharedWith});
}

/// @nodoc
class _$AudioSessionInfoCopyWithImpl<$Res, $Val extends AudioSessionInfo>
    implements $AudioSessionInfoCopyWith<$Res> {
  _$AudioSessionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pid = null,
    Object? exeName = null,
    Object? displayName = null,
    Object? loopbackIndex = null,
    Object? deviceName = null,
    Object? sharedWith = null,
  }) {
    return _then(_value.copyWith(
      pid: null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as int,
      exeName: null == exeName
          ? _value.exeName
          : exeName // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      loopbackIndex: null == loopbackIndex
          ? _value.loopbackIndex
          : loopbackIndex // ignore: cast_nullable_to_non_nullable
              as int,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      sharedWith: null == sharedWith
          ? _value.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioSessionInfoImplCopyWith<$Res>
    implements $AudioSessionInfoCopyWith<$Res> {
  factory _$$AudioSessionInfoImplCopyWith(_$AudioSessionInfoImpl value,
          $Res Function(_$AudioSessionInfoImpl) then) =
      __$$AudioSessionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int pid,
      String exeName,
      String displayName,
      int loopbackIndex,
      String deviceName,
      int sharedWith});
}

/// @nodoc
class __$$AudioSessionInfoImplCopyWithImpl<$Res>
    extends _$AudioSessionInfoCopyWithImpl<$Res, _$AudioSessionInfoImpl>
    implements _$$AudioSessionInfoImplCopyWith<$Res> {
  __$$AudioSessionInfoImplCopyWithImpl(_$AudioSessionInfoImpl _value,
      $Res Function(_$AudioSessionInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pid = null,
    Object? exeName = null,
    Object? displayName = null,
    Object? loopbackIndex = null,
    Object? deviceName = null,
    Object? sharedWith = null,
  }) {
    return _then(_$AudioSessionInfoImpl(
      pid: null == pid
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as int,
      exeName: null == exeName
          ? _value.exeName
          : exeName // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      loopbackIndex: null == loopbackIndex
          ? _value.loopbackIndex
          : loopbackIndex // ignore: cast_nullable_to_non_nullable
              as int,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      sharedWith: null == sharedWith
          ? _value.sharedWith
          : sharedWith // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AudioSessionInfoImpl implements _AudioSessionInfo {
  const _$AudioSessionInfoImpl(
      {required this.pid,
      required this.exeName,
      required this.displayName,
      required this.loopbackIndex,
      required this.deviceName,
      this.sharedWith = 1});

  @override
  final int pid;
  @override
  final String exeName;
  @override
  final String displayName;
  @override
  final int loopbackIndex;
  @override
  final String deviceName;
  @override
  @JsonKey()
  final int sharedWith;

  @override
  String toString() {
    return 'AudioSessionInfo(pid: $pid, exeName: $exeName, displayName: $displayName, loopbackIndex: $loopbackIndex, deviceName: $deviceName, sharedWith: $sharedWith)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioSessionInfoImpl &&
            (identical(other.pid, pid) || other.pid == pid) &&
            (identical(other.exeName, exeName) || other.exeName == exeName) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.loopbackIndex, loopbackIndex) ||
                other.loopbackIndex == loopbackIndex) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.sharedWith, sharedWith) ||
                other.sharedWith == sharedWith));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pid, exeName, displayName,
      loopbackIndex, deviceName, sharedWith);

  /// Create a copy of AudioSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioSessionInfoImplCopyWith<_$AudioSessionInfoImpl> get copyWith =>
      __$$AudioSessionInfoImplCopyWithImpl<_$AudioSessionInfoImpl>(
          this, _$identity);
}

abstract class _AudioSessionInfo implements AudioSessionInfo {
  const factory _AudioSessionInfo(
      {required final int pid,
      required final String exeName,
      required final String displayName,
      required final int loopbackIndex,
      required final String deviceName,
      final int sharedWith}) = _$AudioSessionInfoImpl;

  @override
  int get pid;
  @override
  String get exeName;
  @override
  String get displayName;
  @override
  int get loopbackIndex;
  @override
  String get deviceName;
  @override
  int get sharedWith;

  /// Create a copy of AudioSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioSessionInfoImplCopyWith<_$AudioSessionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
