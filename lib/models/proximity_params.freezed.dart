// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proximity_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProximityParams {
  double get near =>
      throw _privateConstructorUsedError; // full-volume radius in metres
  double get far =>
      throw _privateConstructorUsedError; // silence radius in metres
  double get curve =>
      throw _privateConstructorUsedError; // exponent (2.0 = inverse-square)
  bool get panning => throw _privateConstructorUsedError;

  /// Create a copy of ProximityParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProximityParamsCopyWith<ProximityParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProximityParamsCopyWith<$Res> {
  factory $ProximityParamsCopyWith(
          ProximityParams value, $Res Function(ProximityParams) then) =
      _$ProximityParamsCopyWithImpl<$Res, ProximityParams>;
  @useResult
  $Res call({double near, double far, double curve, bool panning});
}

/// @nodoc
class _$ProximityParamsCopyWithImpl<$Res, $Val extends ProximityParams>
    implements $ProximityParamsCopyWith<$Res> {
  _$ProximityParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProximityParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? near = null,
    Object? far = null,
    Object? curve = null,
    Object? panning = null,
  }) {
    return _then(_value.copyWith(
      near: null == near
          ? _value.near
          : near // ignore: cast_nullable_to_non_nullable
              as double,
      far: null == far
          ? _value.far
          : far // ignore: cast_nullable_to_non_nullable
              as double,
      curve: null == curve
          ? _value.curve
          : curve // ignore: cast_nullable_to_non_nullable
              as double,
      panning: null == panning
          ? _value.panning
          : panning // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProximityParamsImplCopyWith<$Res>
    implements $ProximityParamsCopyWith<$Res> {
  factory _$$ProximityParamsImplCopyWith(_$ProximityParamsImpl value,
          $Res Function(_$ProximityParamsImpl) then) =
      __$$ProximityParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double near, double far, double curve, bool panning});
}

/// @nodoc
class __$$ProximityParamsImplCopyWithImpl<$Res>
    extends _$ProximityParamsCopyWithImpl<$Res, _$ProximityParamsImpl>
    implements _$$ProximityParamsImplCopyWith<$Res> {
  __$$ProximityParamsImplCopyWithImpl(
      _$ProximityParamsImpl _value, $Res Function(_$ProximityParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProximityParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? near = null,
    Object? far = null,
    Object? curve = null,
    Object? panning = null,
  }) {
    return _then(_$ProximityParamsImpl(
      near: null == near
          ? _value.near
          : near // ignore: cast_nullable_to_non_nullable
              as double,
      far: null == far
          ? _value.far
          : far // ignore: cast_nullable_to_non_nullable
              as double,
      curve: null == curve
          ? _value.curve
          : curve // ignore: cast_nullable_to_non_nullable
              as double,
      panning: null == panning
          ? _value.panning
          : panning // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ProximityParamsImpl implements _ProximityParams {
  const _$ProximityParamsImpl(
      {this.near = 10.0,
      this.far = 80.0,
      this.curve = 2.0,
      this.panning = true});

  @override
  @JsonKey()
  final double near;
// full-volume radius in metres
  @override
  @JsonKey()
  final double far;
// silence radius in metres
  @override
  @JsonKey()
  final double curve;
// exponent (2.0 = inverse-square)
  @override
  @JsonKey()
  final bool panning;

  @override
  String toString() {
    return 'ProximityParams(near: $near, far: $far, curve: $curve, panning: $panning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProximityParamsImpl &&
            (identical(other.near, near) || other.near == near) &&
            (identical(other.far, far) || other.far == far) &&
            (identical(other.curve, curve) || other.curve == curve) &&
            (identical(other.panning, panning) || other.panning == panning));
  }

  @override
  int get hashCode => Object.hash(runtimeType, near, far, curve, panning);

  /// Create a copy of ProximityParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProximityParamsImplCopyWith<_$ProximityParamsImpl> get copyWith =>
      __$$ProximityParamsImplCopyWithImpl<_$ProximityParamsImpl>(
          this, _$identity);
}

abstract class _ProximityParams implements ProximityParams {
  const factory _ProximityParams(
      {final double near,
      final double far,
      final double curve,
      final bool panning}) = _$ProximityParamsImpl;

  @override
  double get near; // full-volume radius in metres
  @override
  double get far; // silence radius in metres
  @override
  double get curve; // exponent (2.0 = inverse-square)
  @override
  bool get panning;

  /// Create a copy of ProximityParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProximityParamsImplCopyWith<_$ProximityParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
