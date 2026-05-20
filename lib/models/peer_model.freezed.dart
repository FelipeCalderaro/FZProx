// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'peer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PeerModel {
  int get id => throw _privateConstructorUsedError;
  String get name =>
      throw _privateConstructorUsedError; // Position (world space, XZ plane)
  double get x => throw _privateConstructorUsedError;
  double get z => throw _privateConstructorUsedError;
  double get yaw => throw _privateConstructorUsedError;
  double get speed =>
      throw _privateConstructorUsedError; // Computed proximity values (updated by gain loop)
  double get distanceM => throw _privateConstructorUsedError;
  double get gainL => throw _privateConstructorUsedError;
  double get gainR => throw _privateConstructorUsedError;
  double get rawGain =>
      throw _privateConstructorUsedError; // proximity gain before stereo split (0..1)
  double get pan => throw _privateConstructorUsedError; // -1..+1
  double get dopplerFactor => throw _privateConstructorUsedError;
  int get bufferMs =>
      throw _privateConstructorUsedError; // Manual mute — silences this peer regardless of proximity
  bool get muted =>
      throw _privateConstructorUsedError; // Per-peer volume multiplier (0.0 = silent, 1.0 = normal, 2.0 = double, etc.)
  double get volumeMultiplier => throw _privateConstructorUsedError;

  /// Create a copy of PeerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PeerModelCopyWith<PeerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeerModelCopyWith<$Res> {
  factory $PeerModelCopyWith(PeerModel value, $Res Function(PeerModel) then) =
      _$PeerModelCopyWithImpl<$Res, PeerModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      double x,
      double z,
      double yaw,
      double speed,
      double distanceM,
      double gainL,
      double gainR,
      double rawGain,
      double pan,
      double dopplerFactor,
      int bufferMs,
      bool muted,
      double volumeMultiplier});
}

/// @nodoc
class _$PeerModelCopyWithImpl<$Res, $Val extends PeerModel>
    implements $PeerModelCopyWith<$Res> {
  _$PeerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PeerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? x = null,
    Object? z = null,
    Object? yaw = null,
    Object? speed = null,
    Object? distanceM = null,
    Object? gainL = null,
    Object? gainR = null,
    Object? rawGain = null,
    Object? pan = null,
    Object? dopplerFactor = null,
    Object? bufferMs = null,
    Object? muted = null,
    Object? volumeMultiplier = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      yaw: null == yaw
          ? _value.yaw
          : yaw // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      distanceM: null == distanceM
          ? _value.distanceM
          : distanceM // ignore: cast_nullable_to_non_nullable
              as double,
      gainL: null == gainL
          ? _value.gainL
          : gainL // ignore: cast_nullable_to_non_nullable
              as double,
      gainR: null == gainR
          ? _value.gainR
          : gainR // ignore: cast_nullable_to_non_nullable
              as double,
      rawGain: null == rawGain
          ? _value.rawGain
          : rawGain // ignore: cast_nullable_to_non_nullable
              as double,
      pan: null == pan
          ? _value.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as double,
      dopplerFactor: null == dopplerFactor
          ? _value.dopplerFactor
          : dopplerFactor // ignore: cast_nullable_to_non_nullable
              as double,
      bufferMs: null == bufferMs
          ? _value.bufferMs
          : bufferMs // ignore: cast_nullable_to_non_nullable
              as int,
      muted: null == muted
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      volumeMultiplier: null == volumeMultiplier
          ? _value.volumeMultiplier
          : volumeMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PeerModelImplCopyWith<$Res>
    implements $PeerModelCopyWith<$Res> {
  factory _$$PeerModelImplCopyWith(
          _$PeerModelImpl value, $Res Function(_$PeerModelImpl) then) =
      __$$PeerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      double x,
      double z,
      double yaw,
      double speed,
      double distanceM,
      double gainL,
      double gainR,
      double rawGain,
      double pan,
      double dopplerFactor,
      int bufferMs,
      bool muted,
      double volumeMultiplier});
}

/// @nodoc
class __$$PeerModelImplCopyWithImpl<$Res>
    extends _$PeerModelCopyWithImpl<$Res, _$PeerModelImpl>
    implements _$$PeerModelImplCopyWith<$Res> {
  __$$PeerModelImplCopyWithImpl(
      _$PeerModelImpl _value, $Res Function(_$PeerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PeerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? x = null,
    Object? z = null,
    Object? yaw = null,
    Object? speed = null,
    Object? distanceM = null,
    Object? gainL = null,
    Object? gainR = null,
    Object? rawGain = null,
    Object? pan = null,
    Object? dopplerFactor = null,
    Object? bufferMs = null,
    Object? muted = null,
    Object? volumeMultiplier = null,
  }) {
    return _then(_$PeerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      z: null == z
          ? _value.z
          : z // ignore: cast_nullable_to_non_nullable
              as double,
      yaw: null == yaw
          ? _value.yaw
          : yaw // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      distanceM: null == distanceM
          ? _value.distanceM
          : distanceM // ignore: cast_nullable_to_non_nullable
              as double,
      gainL: null == gainL
          ? _value.gainL
          : gainL // ignore: cast_nullable_to_non_nullable
              as double,
      gainR: null == gainR
          ? _value.gainR
          : gainR // ignore: cast_nullable_to_non_nullable
              as double,
      rawGain: null == rawGain
          ? _value.rawGain
          : rawGain // ignore: cast_nullable_to_non_nullable
              as double,
      pan: null == pan
          ? _value.pan
          : pan // ignore: cast_nullable_to_non_nullable
              as double,
      dopplerFactor: null == dopplerFactor
          ? _value.dopplerFactor
          : dopplerFactor // ignore: cast_nullable_to_non_nullable
              as double,
      bufferMs: null == bufferMs
          ? _value.bufferMs
          : bufferMs // ignore: cast_nullable_to_non_nullable
              as int,
      muted: null == muted
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      volumeMultiplier: null == volumeMultiplier
          ? _value.volumeMultiplier
          : volumeMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$PeerModelImpl implements _PeerModel {
  const _$PeerModelImpl(
      {required this.id,
      required this.name,
      this.x = 0.0,
      this.z = 0.0,
      this.yaw = 0.0,
      this.speed = 0.0,
      this.distanceM = 0.0,
      this.gainL = 0.0,
      this.gainR = 0.0,
      this.rawGain = 0.0,
      this.pan = 0.0,
      this.dopplerFactor = 1.0,
      this.bufferMs = 0,
      this.muted = false,
      this.volumeMultiplier = 1.0});

  @override
  final int id;
  @override
  final String name;
// Position (world space, XZ plane)
  @override
  @JsonKey()
  final double x;
  @override
  @JsonKey()
  final double z;
  @override
  @JsonKey()
  final double yaw;
  @override
  @JsonKey()
  final double speed;
// Computed proximity values (updated by gain loop)
  @override
  @JsonKey()
  final double distanceM;
  @override
  @JsonKey()
  final double gainL;
  @override
  @JsonKey()
  final double gainR;
  @override
  @JsonKey()
  final double rawGain;
// proximity gain before stereo split (0..1)
  @override
  @JsonKey()
  final double pan;
// -1..+1
  @override
  @JsonKey()
  final double dopplerFactor;
  @override
  @JsonKey()
  final int bufferMs;
// Manual mute — silences this peer regardless of proximity
  @override
  @JsonKey()
  final bool muted;
// Per-peer volume multiplier (0.0 = silent, 1.0 = normal, 2.0 = double, etc.)
  @override
  @JsonKey()
  final double volumeMultiplier;

  @override
  String toString() {
    return 'PeerModel(id: $id, name: $name, x: $x, z: $z, yaw: $yaw, speed: $speed, distanceM: $distanceM, gainL: $gainL, gainR: $gainR, rawGain: $rawGain, pan: $pan, dopplerFactor: $dopplerFactor, bufferMs: $bufferMs, muted: $muted, volumeMultiplier: $volumeMultiplier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.z, z) || other.z == z) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.distanceM, distanceM) ||
                other.distanceM == distanceM) &&
            (identical(other.gainL, gainL) || other.gainL == gainL) &&
            (identical(other.gainR, gainR) || other.gainR == gainR) &&
            (identical(other.rawGain, rawGain) || other.rawGain == rawGain) &&
            (identical(other.pan, pan) || other.pan == pan) &&
            (identical(other.dopplerFactor, dopplerFactor) ||
                other.dopplerFactor == dopplerFactor) &&
            (identical(other.bufferMs, bufferMs) ||
                other.bufferMs == bufferMs) &&
            (identical(other.muted, muted) || other.muted == muted) &&
            (identical(other.volumeMultiplier, volumeMultiplier) ||
                other.volumeMultiplier == volumeMultiplier));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      x,
      z,
      yaw,
      speed,
      distanceM,
      gainL,
      gainR,
      rawGain,
      pan,
      dopplerFactor,
      bufferMs,
      muted,
      volumeMultiplier);

  /// Create a copy of PeerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PeerModelImplCopyWith<_$PeerModelImpl> get copyWith =>
      __$$PeerModelImplCopyWithImpl<_$PeerModelImpl>(this, _$identity);
}

abstract class _PeerModel implements PeerModel {
  const factory _PeerModel(
      {required final int id,
      required final String name,
      final double x,
      final double z,
      final double yaw,
      final double speed,
      final double distanceM,
      final double gainL,
      final double gainR,
      final double rawGain,
      final double pan,
      final double dopplerFactor,
      final int bufferMs,
      final bool muted,
      final double volumeMultiplier}) = _$PeerModelImpl;

  @override
  int get id;
  @override
  String get name; // Position (world space, XZ plane)
  @override
  double get x;
  @override
  double get z;
  @override
  double get yaw;
  @override
  double get speed; // Computed proximity values (updated by gain loop)
  @override
  double get distanceM;
  @override
  double get gainL;
  @override
  double get gainR;
  @override
  double get rawGain; // proximity gain before stereo split (0..1)
  @override
  double get pan; // -1..+1
  @override
  double get dopplerFactor;
  @override
  int get bufferMs; // Manual mute — silences this peer regardless of proximity
  @override
  bool
      get muted; // Per-peer volume multiplier (0.0 = silent, 1.0 = normal, 2.0 = double, etc.)
  @override
  double get volumeMultiplier;

  /// Create a copy of PeerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PeerModelImplCopyWith<_$PeerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
