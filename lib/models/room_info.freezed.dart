// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoomInfo {
  String get code => throw _privateConstructorUsedError;
  int get playerCount => throw _privateConstructorUsedError;

  /// Create a copy of RoomInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomInfoCopyWith<RoomInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomInfoCopyWith<$Res> {
  factory $RoomInfoCopyWith(RoomInfo value, $Res Function(RoomInfo) then) =
      _$RoomInfoCopyWithImpl<$Res, RoomInfo>;
  @useResult
  $Res call({String code, int playerCount});
}

/// @nodoc
class _$RoomInfoCopyWithImpl<$Res, $Val extends RoomInfo>
    implements $RoomInfoCopyWith<$Res> {
  _$RoomInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? playerCount = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      playerCount: null == playerCount
          ? _value.playerCount
          : playerCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomInfoImplCopyWith<$Res>
    implements $RoomInfoCopyWith<$Res> {
  factory _$$RoomInfoImplCopyWith(
          _$RoomInfoImpl value, $Res Function(_$RoomInfoImpl) then) =
      __$$RoomInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, int playerCount});
}

/// @nodoc
class __$$RoomInfoImplCopyWithImpl<$Res>
    extends _$RoomInfoCopyWithImpl<$Res, _$RoomInfoImpl>
    implements _$$RoomInfoImplCopyWith<$Res> {
  __$$RoomInfoImplCopyWithImpl(
      _$RoomInfoImpl _value, $Res Function(_$RoomInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoomInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? playerCount = null,
  }) {
    return _then(_$RoomInfoImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      playerCount: null == playerCount
          ? _value.playerCount
          : playerCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RoomInfoImpl implements _RoomInfo {
  const _$RoomInfoImpl({required this.code, required this.playerCount});

  @override
  final String code;
  @override
  final int playerCount;

  @override
  String toString() {
    return 'RoomInfo(code: $code, playerCount: $playerCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomInfoImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.playerCount, playerCount) ||
                other.playerCount == playerCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, playerCount);

  /// Create a copy of RoomInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomInfoImplCopyWith<_$RoomInfoImpl> get copyWith =>
      __$$RoomInfoImplCopyWithImpl<_$RoomInfoImpl>(this, _$identity);
}

abstract class _RoomInfo implements RoomInfo {
  const factory _RoomInfo(
      {required final String code,
      required final int playerCount}) = _$RoomInfoImpl;

  @override
  String get code;
  @override
  int get playerCount;

  /// Create a copy of RoomInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomInfoImplCopyWith<_$RoomInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
