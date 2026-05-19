// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SessionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selfId, String roomCode, String username)
        started,
    required TResult Function(int id, String name) peerAdded,
    required TResult Function(int id) peerRemoved,
    required TResult Function(
            int id, double x, double z, double yaw, double speed)
        peerPositionUpdated,
    required TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)
        selfPositionUpdated,
    required TResult Function() gainTick,
    required TResult Function(
            int id,
            double distanceM,
            double rawGain,
            double gainL,
            double gainR,
            double pan,
            double dopplerFactor,
            int bufferMs)
        peerMetricsUpdated,
    required TResult Function(ProximityParams params) proximityParamsChanged,
    required TResult Function() ended,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selfId, String roomCode, String username)? started,
    TResult? Function(int id, String name)? peerAdded,
    TResult? Function(int id)? peerRemoved,
    TResult? Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult? Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult? Function()? gainTick,
    TResult? Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult? Function(ProximityParams params)? proximityParamsChanged,
    TResult? Function()? ended,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selfId, String roomCode, String username)? started,
    TResult Function(int id, String name)? peerAdded,
    TResult Function(int id)? peerRemoved,
    TResult Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult Function()? gainTick,
    TResult Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult Function(ProximityParams params)? proximityParamsChanged,
    TResult Function()? ended,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionStarted value) started,
    required TResult Function(SessionPeerAdded value) peerAdded,
    required TResult Function(SessionPeerRemoved value) peerRemoved,
    required TResult Function(SessionPeerPositionUpdated value)
        peerPositionUpdated,
    required TResult Function(SessionSelfPositionUpdated value)
        selfPositionUpdated,
    required TResult Function(SessionGainTick value) gainTick,
    required TResult Function(SessionPeerMetricsUpdated value)
        peerMetricsUpdated,
    required TResult Function(SessionProximityParamsChanged value)
        proximityParamsChanged,
    required TResult Function(SessionEnded value) ended,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionStarted value)? started,
    TResult? Function(SessionPeerAdded value)? peerAdded,
    TResult? Function(SessionPeerRemoved value)? peerRemoved,
    TResult? Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult? Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult? Function(SessionGainTick value)? gainTick,
    TResult? Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult? Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult? Function(SessionEnded value)? ended,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionStarted value)? started,
    TResult Function(SessionPeerAdded value)? peerAdded,
    TResult Function(SessionPeerRemoved value)? peerRemoved,
    TResult Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult Function(SessionGainTick value)? gainTick,
    TResult Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult Function(SessionEnded value)? ended,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionEventCopyWith<$Res> {
  factory $SessionEventCopyWith(
          SessionEvent value, $Res Function(SessionEvent) then) =
      _$SessionEventCopyWithImpl<$Res, SessionEvent>;
}

/// @nodoc
class _$SessionEventCopyWithImpl<$Res, $Val extends SessionEvent>
    implements $SessionEventCopyWith<$Res> {
  _$SessionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SessionStartedImplCopyWith<$Res> {
  factory _$$SessionStartedImplCopyWith(_$SessionStartedImpl value,
          $Res Function(_$SessionStartedImpl) then) =
      __$$SessionStartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int selfId, String roomCode, String username});
}

/// @nodoc
class __$$SessionStartedImplCopyWithImpl<$Res>
    extends _$SessionEventCopyWithImpl<$Res, _$SessionStartedImpl>
    implements _$$SessionStartedImplCopyWith<$Res> {
  __$$SessionStartedImplCopyWithImpl(
      _$SessionStartedImpl _value, $Res Function(_$SessionStartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selfId = null,
    Object? roomCode = null,
    Object? username = null,
  }) {
    return _then(_$SessionStartedImpl(
      selfId: null == selfId
          ? _value.selfId
          : selfId // ignore: cast_nullable_to_non_nullable
              as int,
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SessionStartedImpl implements SessionStarted {
  const _$SessionStartedImpl(
      {required this.selfId, required this.roomCode, required this.username});

  @override
  final int selfId;
  @override
  final String roomCode;
  @override
  final String username;

  @override
  String toString() {
    return 'SessionEvent.started(selfId: $selfId, roomCode: $roomCode, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionStartedImpl &&
            (identical(other.selfId, selfId) || other.selfId == selfId) &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selfId, roomCode, username);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionStartedImplCopyWith<_$SessionStartedImpl> get copyWith =>
      __$$SessionStartedImplCopyWithImpl<_$SessionStartedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selfId, String roomCode, String username)
        started,
    required TResult Function(int id, String name) peerAdded,
    required TResult Function(int id) peerRemoved,
    required TResult Function(
            int id, double x, double z, double yaw, double speed)
        peerPositionUpdated,
    required TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)
        selfPositionUpdated,
    required TResult Function() gainTick,
    required TResult Function(
            int id,
            double distanceM,
            double rawGain,
            double gainL,
            double gainR,
            double pan,
            double dopplerFactor,
            int bufferMs)
        peerMetricsUpdated,
    required TResult Function(ProximityParams params) proximityParamsChanged,
    required TResult Function() ended,
  }) {
    return started(selfId, roomCode, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selfId, String roomCode, String username)? started,
    TResult? Function(int id, String name)? peerAdded,
    TResult? Function(int id)? peerRemoved,
    TResult? Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult? Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult? Function()? gainTick,
    TResult? Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult? Function(ProximityParams params)? proximityParamsChanged,
    TResult? Function()? ended,
  }) {
    return started?.call(selfId, roomCode, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selfId, String roomCode, String username)? started,
    TResult Function(int id, String name)? peerAdded,
    TResult Function(int id)? peerRemoved,
    TResult Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult Function()? gainTick,
    TResult Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult Function(ProximityParams params)? proximityParamsChanged,
    TResult Function()? ended,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(selfId, roomCode, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionStarted value) started,
    required TResult Function(SessionPeerAdded value) peerAdded,
    required TResult Function(SessionPeerRemoved value) peerRemoved,
    required TResult Function(SessionPeerPositionUpdated value)
        peerPositionUpdated,
    required TResult Function(SessionSelfPositionUpdated value)
        selfPositionUpdated,
    required TResult Function(SessionGainTick value) gainTick,
    required TResult Function(SessionPeerMetricsUpdated value)
        peerMetricsUpdated,
    required TResult Function(SessionProximityParamsChanged value)
        proximityParamsChanged,
    required TResult Function(SessionEnded value) ended,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionStarted value)? started,
    TResult? Function(SessionPeerAdded value)? peerAdded,
    TResult? Function(SessionPeerRemoved value)? peerRemoved,
    TResult? Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult? Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult? Function(SessionGainTick value)? gainTick,
    TResult? Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult? Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult? Function(SessionEnded value)? ended,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionStarted value)? started,
    TResult Function(SessionPeerAdded value)? peerAdded,
    TResult Function(SessionPeerRemoved value)? peerRemoved,
    TResult Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult Function(SessionGainTick value)? gainTick,
    TResult Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult Function(SessionEnded value)? ended,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class SessionStarted implements SessionEvent {
  const factory SessionStarted(
      {required final int selfId,
      required final String roomCode,
      required final String username}) = _$SessionStartedImpl;

  int get selfId;
  String get roomCode;
  String get username;

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionStartedImplCopyWith<_$SessionStartedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionPeerAddedImplCopyWith<$Res> {
  factory _$$SessionPeerAddedImplCopyWith(_$SessionPeerAddedImpl value,
          $Res Function(_$SessionPeerAddedImpl) then) =
      __$$SessionPeerAddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$SessionPeerAddedImplCopyWithImpl<$Res>
    extends _$SessionEventCopyWithImpl<$Res, _$SessionPeerAddedImpl>
    implements _$$SessionPeerAddedImplCopyWith<$Res> {
  __$$SessionPeerAddedImplCopyWithImpl(_$SessionPeerAddedImpl _value,
      $Res Function(_$SessionPeerAddedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$SessionPeerAddedImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SessionPeerAddedImpl implements SessionPeerAdded {
  const _$SessionPeerAddedImpl({required this.id, required this.name});

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'SessionEvent.peerAdded(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionPeerAddedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionPeerAddedImplCopyWith<_$SessionPeerAddedImpl> get copyWith =>
      __$$SessionPeerAddedImplCopyWithImpl<_$SessionPeerAddedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selfId, String roomCode, String username)
        started,
    required TResult Function(int id, String name) peerAdded,
    required TResult Function(int id) peerRemoved,
    required TResult Function(
            int id, double x, double z, double yaw, double speed)
        peerPositionUpdated,
    required TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)
        selfPositionUpdated,
    required TResult Function() gainTick,
    required TResult Function(
            int id,
            double distanceM,
            double rawGain,
            double gainL,
            double gainR,
            double pan,
            double dopplerFactor,
            int bufferMs)
        peerMetricsUpdated,
    required TResult Function(ProximityParams params) proximityParamsChanged,
    required TResult Function() ended,
  }) {
    return peerAdded(id, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selfId, String roomCode, String username)? started,
    TResult? Function(int id, String name)? peerAdded,
    TResult? Function(int id)? peerRemoved,
    TResult? Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult? Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult? Function()? gainTick,
    TResult? Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult? Function(ProximityParams params)? proximityParamsChanged,
    TResult? Function()? ended,
  }) {
    return peerAdded?.call(id, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selfId, String roomCode, String username)? started,
    TResult Function(int id, String name)? peerAdded,
    TResult Function(int id)? peerRemoved,
    TResult Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult Function()? gainTick,
    TResult Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult Function(ProximityParams params)? proximityParamsChanged,
    TResult Function()? ended,
    required TResult orElse(),
  }) {
    if (peerAdded != null) {
      return peerAdded(id, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionStarted value) started,
    required TResult Function(SessionPeerAdded value) peerAdded,
    required TResult Function(SessionPeerRemoved value) peerRemoved,
    required TResult Function(SessionPeerPositionUpdated value)
        peerPositionUpdated,
    required TResult Function(SessionSelfPositionUpdated value)
        selfPositionUpdated,
    required TResult Function(SessionGainTick value) gainTick,
    required TResult Function(SessionPeerMetricsUpdated value)
        peerMetricsUpdated,
    required TResult Function(SessionProximityParamsChanged value)
        proximityParamsChanged,
    required TResult Function(SessionEnded value) ended,
  }) {
    return peerAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionStarted value)? started,
    TResult? Function(SessionPeerAdded value)? peerAdded,
    TResult? Function(SessionPeerRemoved value)? peerRemoved,
    TResult? Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult? Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult? Function(SessionGainTick value)? gainTick,
    TResult? Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult? Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult? Function(SessionEnded value)? ended,
  }) {
    return peerAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionStarted value)? started,
    TResult Function(SessionPeerAdded value)? peerAdded,
    TResult Function(SessionPeerRemoved value)? peerRemoved,
    TResult Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult Function(SessionGainTick value)? gainTick,
    TResult Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult Function(SessionEnded value)? ended,
    required TResult orElse(),
  }) {
    if (peerAdded != null) {
      return peerAdded(this);
    }
    return orElse();
  }
}

abstract class SessionPeerAdded implements SessionEvent {
  const factory SessionPeerAdded(
      {required final int id,
      required final String name}) = _$SessionPeerAddedImpl;

  int get id;
  String get name;

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionPeerAddedImplCopyWith<_$SessionPeerAddedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionPeerRemovedImplCopyWith<$Res> {
  factory _$$SessionPeerRemovedImplCopyWith(_$SessionPeerRemovedImpl value,
          $Res Function(_$SessionPeerRemovedImpl) then) =
      __$$SessionPeerRemovedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$SessionPeerRemovedImplCopyWithImpl<$Res>
    extends _$SessionEventCopyWithImpl<$Res, _$SessionPeerRemovedImpl>
    implements _$$SessionPeerRemovedImplCopyWith<$Res> {
  __$$SessionPeerRemovedImplCopyWithImpl(_$SessionPeerRemovedImpl _value,
      $Res Function(_$SessionPeerRemovedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$SessionPeerRemovedImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SessionPeerRemovedImpl implements SessionPeerRemoved {
  const _$SessionPeerRemovedImpl({required this.id});

  @override
  final int id;

  @override
  String toString() {
    return 'SessionEvent.peerRemoved(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionPeerRemovedImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionPeerRemovedImplCopyWith<_$SessionPeerRemovedImpl> get copyWith =>
      __$$SessionPeerRemovedImplCopyWithImpl<_$SessionPeerRemovedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selfId, String roomCode, String username)
        started,
    required TResult Function(int id, String name) peerAdded,
    required TResult Function(int id) peerRemoved,
    required TResult Function(
            int id, double x, double z, double yaw, double speed)
        peerPositionUpdated,
    required TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)
        selfPositionUpdated,
    required TResult Function() gainTick,
    required TResult Function(
            int id,
            double distanceM,
            double rawGain,
            double gainL,
            double gainR,
            double pan,
            double dopplerFactor,
            int bufferMs)
        peerMetricsUpdated,
    required TResult Function(ProximityParams params) proximityParamsChanged,
    required TResult Function() ended,
  }) {
    return peerRemoved(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selfId, String roomCode, String username)? started,
    TResult? Function(int id, String name)? peerAdded,
    TResult? Function(int id)? peerRemoved,
    TResult? Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult? Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult? Function()? gainTick,
    TResult? Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult? Function(ProximityParams params)? proximityParamsChanged,
    TResult? Function()? ended,
  }) {
    return peerRemoved?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selfId, String roomCode, String username)? started,
    TResult Function(int id, String name)? peerAdded,
    TResult Function(int id)? peerRemoved,
    TResult Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult Function()? gainTick,
    TResult Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult Function(ProximityParams params)? proximityParamsChanged,
    TResult Function()? ended,
    required TResult orElse(),
  }) {
    if (peerRemoved != null) {
      return peerRemoved(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionStarted value) started,
    required TResult Function(SessionPeerAdded value) peerAdded,
    required TResult Function(SessionPeerRemoved value) peerRemoved,
    required TResult Function(SessionPeerPositionUpdated value)
        peerPositionUpdated,
    required TResult Function(SessionSelfPositionUpdated value)
        selfPositionUpdated,
    required TResult Function(SessionGainTick value) gainTick,
    required TResult Function(SessionPeerMetricsUpdated value)
        peerMetricsUpdated,
    required TResult Function(SessionProximityParamsChanged value)
        proximityParamsChanged,
    required TResult Function(SessionEnded value) ended,
  }) {
    return peerRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionStarted value)? started,
    TResult? Function(SessionPeerAdded value)? peerAdded,
    TResult? Function(SessionPeerRemoved value)? peerRemoved,
    TResult? Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult? Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult? Function(SessionGainTick value)? gainTick,
    TResult? Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult? Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult? Function(SessionEnded value)? ended,
  }) {
    return peerRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionStarted value)? started,
    TResult Function(SessionPeerAdded value)? peerAdded,
    TResult Function(SessionPeerRemoved value)? peerRemoved,
    TResult Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult Function(SessionGainTick value)? gainTick,
    TResult Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult Function(SessionEnded value)? ended,
    required TResult orElse(),
  }) {
    if (peerRemoved != null) {
      return peerRemoved(this);
    }
    return orElse();
  }
}

abstract class SessionPeerRemoved implements SessionEvent {
  const factory SessionPeerRemoved({required final int id}) =
      _$SessionPeerRemovedImpl;

  int get id;

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionPeerRemovedImplCopyWith<_$SessionPeerRemovedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionPeerPositionUpdatedImplCopyWith<$Res> {
  factory _$$SessionPeerPositionUpdatedImplCopyWith(
          _$SessionPeerPositionUpdatedImpl value,
          $Res Function(_$SessionPeerPositionUpdatedImpl) then) =
      __$$SessionPeerPositionUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id, double x, double z, double yaw, double speed});
}

/// @nodoc
class __$$SessionPeerPositionUpdatedImplCopyWithImpl<$Res>
    extends _$SessionEventCopyWithImpl<$Res, _$SessionPeerPositionUpdatedImpl>
    implements _$$SessionPeerPositionUpdatedImplCopyWith<$Res> {
  __$$SessionPeerPositionUpdatedImplCopyWithImpl(
      _$SessionPeerPositionUpdatedImpl _value,
      $Res Function(_$SessionPeerPositionUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? x = null,
    Object? z = null,
    Object? yaw = null,
    Object? speed = null,
  }) {
    return _then(_$SessionPeerPositionUpdatedImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
    ));
  }
}

/// @nodoc

class _$SessionPeerPositionUpdatedImpl implements SessionPeerPositionUpdated {
  const _$SessionPeerPositionUpdatedImpl(
      {required this.id,
      required this.x,
      required this.z,
      required this.yaw,
      required this.speed});

  @override
  final int id;
  @override
  final double x;
  @override
  final double z;
  @override
  final double yaw;
  @override
  final double speed;

  @override
  String toString() {
    return 'SessionEvent.peerPositionUpdated(id: $id, x: $x, z: $z, yaw: $yaw, speed: $speed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionPeerPositionUpdatedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.z, z) || other.z == z) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.speed, speed) || other.speed == speed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, x, z, yaw, speed);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionPeerPositionUpdatedImplCopyWith<_$SessionPeerPositionUpdatedImpl>
      get copyWith => __$$SessionPeerPositionUpdatedImplCopyWithImpl<
          _$SessionPeerPositionUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selfId, String roomCode, String username)
        started,
    required TResult Function(int id, String name) peerAdded,
    required TResult Function(int id) peerRemoved,
    required TResult Function(
            int id, double x, double z, double yaw, double speed)
        peerPositionUpdated,
    required TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)
        selfPositionUpdated,
    required TResult Function() gainTick,
    required TResult Function(
            int id,
            double distanceM,
            double rawGain,
            double gainL,
            double gainR,
            double pan,
            double dopplerFactor,
            int bufferMs)
        peerMetricsUpdated,
    required TResult Function(ProximityParams params) proximityParamsChanged,
    required TResult Function() ended,
  }) {
    return peerPositionUpdated(id, x, z, yaw, speed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selfId, String roomCode, String username)? started,
    TResult? Function(int id, String name)? peerAdded,
    TResult? Function(int id)? peerRemoved,
    TResult? Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult? Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult? Function()? gainTick,
    TResult? Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult? Function(ProximityParams params)? proximityParamsChanged,
    TResult? Function()? ended,
  }) {
    return peerPositionUpdated?.call(id, x, z, yaw, speed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selfId, String roomCode, String username)? started,
    TResult Function(int id, String name)? peerAdded,
    TResult Function(int id)? peerRemoved,
    TResult Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult Function()? gainTick,
    TResult Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult Function(ProximityParams params)? proximityParamsChanged,
    TResult Function()? ended,
    required TResult orElse(),
  }) {
    if (peerPositionUpdated != null) {
      return peerPositionUpdated(id, x, z, yaw, speed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionStarted value) started,
    required TResult Function(SessionPeerAdded value) peerAdded,
    required TResult Function(SessionPeerRemoved value) peerRemoved,
    required TResult Function(SessionPeerPositionUpdated value)
        peerPositionUpdated,
    required TResult Function(SessionSelfPositionUpdated value)
        selfPositionUpdated,
    required TResult Function(SessionGainTick value) gainTick,
    required TResult Function(SessionPeerMetricsUpdated value)
        peerMetricsUpdated,
    required TResult Function(SessionProximityParamsChanged value)
        proximityParamsChanged,
    required TResult Function(SessionEnded value) ended,
  }) {
    return peerPositionUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionStarted value)? started,
    TResult? Function(SessionPeerAdded value)? peerAdded,
    TResult? Function(SessionPeerRemoved value)? peerRemoved,
    TResult? Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult? Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult? Function(SessionGainTick value)? gainTick,
    TResult? Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult? Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult? Function(SessionEnded value)? ended,
  }) {
    return peerPositionUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionStarted value)? started,
    TResult Function(SessionPeerAdded value)? peerAdded,
    TResult Function(SessionPeerRemoved value)? peerRemoved,
    TResult Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult Function(SessionGainTick value)? gainTick,
    TResult Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult Function(SessionEnded value)? ended,
    required TResult orElse(),
  }) {
    if (peerPositionUpdated != null) {
      return peerPositionUpdated(this);
    }
    return orElse();
  }
}

abstract class SessionPeerPositionUpdated implements SessionEvent {
  const factory SessionPeerPositionUpdated(
      {required final int id,
      required final double x,
      required final double z,
      required final double yaw,
      required final double speed}) = _$SessionPeerPositionUpdatedImpl;

  int get id;
  double get x;
  double get z;
  double get yaw;
  double get speed;

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionPeerPositionUpdatedImplCopyWith<_$SessionPeerPositionUpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionSelfPositionUpdatedImplCopyWith<$Res> {
  factory _$$SessionSelfPositionUpdatedImplCopyWith(
          _$SessionSelfPositionUpdatedImpl value,
          $Res Function(_$SessionSelfPositionUpdatedImpl) then) =
      __$$SessionSelfPositionUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double x, double z, double yaw, double speed, bool isRaceOn});
}

/// @nodoc
class __$$SessionSelfPositionUpdatedImplCopyWithImpl<$Res>
    extends _$SessionEventCopyWithImpl<$Res, _$SessionSelfPositionUpdatedImpl>
    implements _$$SessionSelfPositionUpdatedImplCopyWith<$Res> {
  __$$SessionSelfPositionUpdatedImplCopyWithImpl(
      _$SessionSelfPositionUpdatedImpl _value,
      $Res Function(_$SessionSelfPositionUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? z = null,
    Object? yaw = null,
    Object? speed = null,
    Object? isRaceOn = null,
  }) {
    return _then(_$SessionSelfPositionUpdatedImpl(
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
      isRaceOn: null == isRaceOn
          ? _value.isRaceOn
          : isRaceOn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SessionSelfPositionUpdatedImpl implements SessionSelfPositionUpdated {
  const _$SessionSelfPositionUpdatedImpl(
      {required this.x,
      required this.z,
      required this.yaw,
      required this.speed,
      required this.isRaceOn});

  @override
  final double x;
  @override
  final double z;
  @override
  final double yaw;
  @override
  final double speed;
  @override
  final bool isRaceOn;

  @override
  String toString() {
    return 'SessionEvent.selfPositionUpdated(x: $x, z: $z, yaw: $yaw, speed: $speed, isRaceOn: $isRaceOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionSelfPositionUpdatedImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.z, z) || other.z == z) &&
            (identical(other.yaw, yaw) || other.yaw == yaw) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.isRaceOn, isRaceOn) ||
                other.isRaceOn == isRaceOn));
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, z, yaw, speed, isRaceOn);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionSelfPositionUpdatedImplCopyWith<_$SessionSelfPositionUpdatedImpl>
      get copyWith => __$$SessionSelfPositionUpdatedImplCopyWithImpl<
          _$SessionSelfPositionUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selfId, String roomCode, String username)
        started,
    required TResult Function(int id, String name) peerAdded,
    required TResult Function(int id) peerRemoved,
    required TResult Function(
            int id, double x, double z, double yaw, double speed)
        peerPositionUpdated,
    required TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)
        selfPositionUpdated,
    required TResult Function() gainTick,
    required TResult Function(
            int id,
            double distanceM,
            double rawGain,
            double gainL,
            double gainR,
            double pan,
            double dopplerFactor,
            int bufferMs)
        peerMetricsUpdated,
    required TResult Function(ProximityParams params) proximityParamsChanged,
    required TResult Function() ended,
  }) {
    return selfPositionUpdated(x, z, yaw, speed, isRaceOn);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selfId, String roomCode, String username)? started,
    TResult? Function(int id, String name)? peerAdded,
    TResult? Function(int id)? peerRemoved,
    TResult? Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult? Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult? Function()? gainTick,
    TResult? Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult? Function(ProximityParams params)? proximityParamsChanged,
    TResult? Function()? ended,
  }) {
    return selfPositionUpdated?.call(x, z, yaw, speed, isRaceOn);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selfId, String roomCode, String username)? started,
    TResult Function(int id, String name)? peerAdded,
    TResult Function(int id)? peerRemoved,
    TResult Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult Function()? gainTick,
    TResult Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult Function(ProximityParams params)? proximityParamsChanged,
    TResult Function()? ended,
    required TResult orElse(),
  }) {
    if (selfPositionUpdated != null) {
      return selfPositionUpdated(x, z, yaw, speed, isRaceOn);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionStarted value) started,
    required TResult Function(SessionPeerAdded value) peerAdded,
    required TResult Function(SessionPeerRemoved value) peerRemoved,
    required TResult Function(SessionPeerPositionUpdated value)
        peerPositionUpdated,
    required TResult Function(SessionSelfPositionUpdated value)
        selfPositionUpdated,
    required TResult Function(SessionGainTick value) gainTick,
    required TResult Function(SessionPeerMetricsUpdated value)
        peerMetricsUpdated,
    required TResult Function(SessionProximityParamsChanged value)
        proximityParamsChanged,
    required TResult Function(SessionEnded value) ended,
  }) {
    return selfPositionUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionStarted value)? started,
    TResult? Function(SessionPeerAdded value)? peerAdded,
    TResult? Function(SessionPeerRemoved value)? peerRemoved,
    TResult? Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult? Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult? Function(SessionGainTick value)? gainTick,
    TResult? Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult? Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult? Function(SessionEnded value)? ended,
  }) {
    return selfPositionUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionStarted value)? started,
    TResult Function(SessionPeerAdded value)? peerAdded,
    TResult Function(SessionPeerRemoved value)? peerRemoved,
    TResult Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult Function(SessionGainTick value)? gainTick,
    TResult Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult Function(SessionEnded value)? ended,
    required TResult orElse(),
  }) {
    if (selfPositionUpdated != null) {
      return selfPositionUpdated(this);
    }
    return orElse();
  }
}

abstract class SessionSelfPositionUpdated implements SessionEvent {
  const factory SessionSelfPositionUpdated(
      {required final double x,
      required final double z,
      required final double yaw,
      required final double speed,
      required final bool isRaceOn}) = _$SessionSelfPositionUpdatedImpl;

  double get x;
  double get z;
  double get yaw;
  double get speed;
  bool get isRaceOn;

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionSelfPositionUpdatedImplCopyWith<_$SessionSelfPositionUpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionGainTickImplCopyWith<$Res> {
  factory _$$SessionGainTickImplCopyWith(_$SessionGainTickImpl value,
          $Res Function(_$SessionGainTickImpl) then) =
      __$$SessionGainTickImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SessionGainTickImplCopyWithImpl<$Res>
    extends _$SessionEventCopyWithImpl<$Res, _$SessionGainTickImpl>
    implements _$$SessionGainTickImplCopyWith<$Res> {
  __$$SessionGainTickImplCopyWithImpl(
      _$SessionGainTickImpl _value, $Res Function(_$SessionGainTickImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SessionGainTickImpl implements SessionGainTick {
  const _$SessionGainTickImpl();

  @override
  String toString() {
    return 'SessionEvent.gainTick()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SessionGainTickImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selfId, String roomCode, String username)
        started,
    required TResult Function(int id, String name) peerAdded,
    required TResult Function(int id) peerRemoved,
    required TResult Function(
            int id, double x, double z, double yaw, double speed)
        peerPositionUpdated,
    required TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)
        selfPositionUpdated,
    required TResult Function() gainTick,
    required TResult Function(
            int id,
            double distanceM,
            double rawGain,
            double gainL,
            double gainR,
            double pan,
            double dopplerFactor,
            int bufferMs)
        peerMetricsUpdated,
    required TResult Function(ProximityParams params) proximityParamsChanged,
    required TResult Function() ended,
  }) {
    return gainTick();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selfId, String roomCode, String username)? started,
    TResult? Function(int id, String name)? peerAdded,
    TResult? Function(int id)? peerRemoved,
    TResult? Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult? Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult? Function()? gainTick,
    TResult? Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult? Function(ProximityParams params)? proximityParamsChanged,
    TResult? Function()? ended,
  }) {
    return gainTick?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selfId, String roomCode, String username)? started,
    TResult Function(int id, String name)? peerAdded,
    TResult Function(int id)? peerRemoved,
    TResult Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult Function()? gainTick,
    TResult Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult Function(ProximityParams params)? proximityParamsChanged,
    TResult Function()? ended,
    required TResult orElse(),
  }) {
    if (gainTick != null) {
      return gainTick();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionStarted value) started,
    required TResult Function(SessionPeerAdded value) peerAdded,
    required TResult Function(SessionPeerRemoved value) peerRemoved,
    required TResult Function(SessionPeerPositionUpdated value)
        peerPositionUpdated,
    required TResult Function(SessionSelfPositionUpdated value)
        selfPositionUpdated,
    required TResult Function(SessionGainTick value) gainTick,
    required TResult Function(SessionPeerMetricsUpdated value)
        peerMetricsUpdated,
    required TResult Function(SessionProximityParamsChanged value)
        proximityParamsChanged,
    required TResult Function(SessionEnded value) ended,
  }) {
    return gainTick(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionStarted value)? started,
    TResult? Function(SessionPeerAdded value)? peerAdded,
    TResult? Function(SessionPeerRemoved value)? peerRemoved,
    TResult? Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult? Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult? Function(SessionGainTick value)? gainTick,
    TResult? Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult? Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult? Function(SessionEnded value)? ended,
  }) {
    return gainTick?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionStarted value)? started,
    TResult Function(SessionPeerAdded value)? peerAdded,
    TResult Function(SessionPeerRemoved value)? peerRemoved,
    TResult Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult Function(SessionGainTick value)? gainTick,
    TResult Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult Function(SessionEnded value)? ended,
    required TResult orElse(),
  }) {
    if (gainTick != null) {
      return gainTick(this);
    }
    return orElse();
  }
}

abstract class SessionGainTick implements SessionEvent {
  const factory SessionGainTick() = _$SessionGainTickImpl;
}

/// @nodoc
abstract class _$$SessionPeerMetricsUpdatedImplCopyWith<$Res> {
  factory _$$SessionPeerMetricsUpdatedImplCopyWith(
          _$SessionPeerMetricsUpdatedImpl value,
          $Res Function(_$SessionPeerMetricsUpdatedImpl) then) =
      __$$SessionPeerMetricsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int id,
      double distanceM,
      double rawGain,
      double gainL,
      double gainR,
      double pan,
      double dopplerFactor,
      int bufferMs});
}

/// @nodoc
class __$$SessionPeerMetricsUpdatedImplCopyWithImpl<$Res>
    extends _$SessionEventCopyWithImpl<$Res, _$SessionPeerMetricsUpdatedImpl>
    implements _$$SessionPeerMetricsUpdatedImplCopyWith<$Res> {
  __$$SessionPeerMetricsUpdatedImplCopyWithImpl(
      _$SessionPeerMetricsUpdatedImpl _value,
      $Res Function(_$SessionPeerMetricsUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? distanceM = null,
    Object? rawGain = null,
    Object? gainL = null,
    Object? gainR = null,
    Object? pan = null,
    Object? dopplerFactor = null,
    Object? bufferMs = null,
  }) {
    return _then(_$SessionPeerMetricsUpdatedImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      distanceM: null == distanceM
          ? _value.distanceM
          : distanceM // ignore: cast_nullable_to_non_nullable
              as double,
      rawGain: null == rawGain
          ? _value.rawGain
          : rawGain // ignore: cast_nullable_to_non_nullable
              as double,
      gainL: null == gainL
          ? _value.gainL
          : gainL // ignore: cast_nullable_to_non_nullable
              as double,
      gainR: null == gainR
          ? _value.gainR
          : gainR // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc

class _$SessionPeerMetricsUpdatedImpl implements SessionPeerMetricsUpdated {
  const _$SessionPeerMetricsUpdatedImpl(
      {required this.id,
      required this.distanceM,
      required this.rawGain,
      required this.gainL,
      required this.gainR,
      required this.pan,
      required this.dopplerFactor,
      required this.bufferMs});

  @override
  final int id;
  @override
  final double distanceM;
  @override
  final double rawGain;
  @override
  final double gainL;
  @override
  final double gainR;
  @override
  final double pan;
  @override
  final double dopplerFactor;
  @override
  final int bufferMs;

  @override
  String toString() {
    return 'SessionEvent.peerMetricsUpdated(id: $id, distanceM: $distanceM, rawGain: $rawGain, gainL: $gainL, gainR: $gainR, pan: $pan, dopplerFactor: $dopplerFactor, bufferMs: $bufferMs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionPeerMetricsUpdatedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.distanceM, distanceM) ||
                other.distanceM == distanceM) &&
            (identical(other.rawGain, rawGain) || other.rawGain == rawGain) &&
            (identical(other.gainL, gainL) || other.gainL == gainL) &&
            (identical(other.gainR, gainR) || other.gainR == gainR) &&
            (identical(other.pan, pan) || other.pan == pan) &&
            (identical(other.dopplerFactor, dopplerFactor) ||
                other.dopplerFactor == dopplerFactor) &&
            (identical(other.bufferMs, bufferMs) ||
                other.bufferMs == bufferMs));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, distanceM, rawGain, gainL,
      gainR, pan, dopplerFactor, bufferMs);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionPeerMetricsUpdatedImplCopyWith<_$SessionPeerMetricsUpdatedImpl>
      get copyWith => __$$SessionPeerMetricsUpdatedImplCopyWithImpl<
          _$SessionPeerMetricsUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selfId, String roomCode, String username)
        started,
    required TResult Function(int id, String name) peerAdded,
    required TResult Function(int id) peerRemoved,
    required TResult Function(
            int id, double x, double z, double yaw, double speed)
        peerPositionUpdated,
    required TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)
        selfPositionUpdated,
    required TResult Function() gainTick,
    required TResult Function(
            int id,
            double distanceM,
            double rawGain,
            double gainL,
            double gainR,
            double pan,
            double dopplerFactor,
            int bufferMs)
        peerMetricsUpdated,
    required TResult Function(ProximityParams params) proximityParamsChanged,
    required TResult Function() ended,
  }) {
    return peerMetricsUpdated(
        id, distanceM, rawGain, gainL, gainR, pan, dopplerFactor, bufferMs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selfId, String roomCode, String username)? started,
    TResult? Function(int id, String name)? peerAdded,
    TResult? Function(int id)? peerRemoved,
    TResult? Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult? Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult? Function()? gainTick,
    TResult? Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult? Function(ProximityParams params)? proximityParamsChanged,
    TResult? Function()? ended,
  }) {
    return peerMetricsUpdated?.call(
        id, distanceM, rawGain, gainL, gainR, pan, dopplerFactor, bufferMs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selfId, String roomCode, String username)? started,
    TResult Function(int id, String name)? peerAdded,
    TResult Function(int id)? peerRemoved,
    TResult Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult Function()? gainTick,
    TResult Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult Function(ProximityParams params)? proximityParamsChanged,
    TResult Function()? ended,
    required TResult orElse(),
  }) {
    if (peerMetricsUpdated != null) {
      return peerMetricsUpdated(
          id, distanceM, rawGain, gainL, gainR, pan, dopplerFactor, bufferMs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionStarted value) started,
    required TResult Function(SessionPeerAdded value) peerAdded,
    required TResult Function(SessionPeerRemoved value) peerRemoved,
    required TResult Function(SessionPeerPositionUpdated value)
        peerPositionUpdated,
    required TResult Function(SessionSelfPositionUpdated value)
        selfPositionUpdated,
    required TResult Function(SessionGainTick value) gainTick,
    required TResult Function(SessionPeerMetricsUpdated value)
        peerMetricsUpdated,
    required TResult Function(SessionProximityParamsChanged value)
        proximityParamsChanged,
    required TResult Function(SessionEnded value) ended,
  }) {
    return peerMetricsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionStarted value)? started,
    TResult? Function(SessionPeerAdded value)? peerAdded,
    TResult? Function(SessionPeerRemoved value)? peerRemoved,
    TResult? Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult? Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult? Function(SessionGainTick value)? gainTick,
    TResult? Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult? Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult? Function(SessionEnded value)? ended,
  }) {
    return peerMetricsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionStarted value)? started,
    TResult Function(SessionPeerAdded value)? peerAdded,
    TResult Function(SessionPeerRemoved value)? peerRemoved,
    TResult Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult Function(SessionGainTick value)? gainTick,
    TResult Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult Function(SessionEnded value)? ended,
    required TResult orElse(),
  }) {
    if (peerMetricsUpdated != null) {
      return peerMetricsUpdated(this);
    }
    return orElse();
  }
}

abstract class SessionPeerMetricsUpdated implements SessionEvent {
  const factory SessionPeerMetricsUpdated(
      {required final int id,
      required final double distanceM,
      required final double rawGain,
      required final double gainL,
      required final double gainR,
      required final double pan,
      required final double dopplerFactor,
      required final int bufferMs}) = _$SessionPeerMetricsUpdatedImpl;

  int get id;
  double get distanceM;
  double get rawGain;
  double get gainL;
  double get gainR;
  double get pan;
  double get dopplerFactor;
  int get bufferMs;

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionPeerMetricsUpdatedImplCopyWith<_$SessionPeerMetricsUpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionProximityParamsChangedImplCopyWith<$Res> {
  factory _$$SessionProximityParamsChangedImplCopyWith(
          _$SessionProximityParamsChangedImpl value,
          $Res Function(_$SessionProximityParamsChangedImpl) then) =
      __$$SessionProximityParamsChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProximityParams params});

  $ProximityParamsCopyWith<$Res> get params;
}

/// @nodoc
class __$$SessionProximityParamsChangedImplCopyWithImpl<$Res>
    extends _$SessionEventCopyWithImpl<$Res,
        _$SessionProximityParamsChangedImpl>
    implements _$$SessionProximityParamsChangedImplCopyWith<$Res> {
  __$$SessionProximityParamsChangedImplCopyWithImpl(
      _$SessionProximityParamsChangedImpl _value,
      $Res Function(_$SessionProximityParamsChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$SessionProximityParamsChangedImpl(
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as ProximityParams,
    ));
  }

  /// Create a copy of SessionEvent
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

class _$SessionProximityParamsChangedImpl
    implements SessionProximityParamsChanged {
  const _$SessionProximityParamsChangedImpl({required this.params});

  @override
  final ProximityParams params;

  @override
  String toString() {
    return 'SessionEvent.proximityParamsChanged(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionProximityParamsChangedImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionProximityParamsChangedImplCopyWith<
          _$SessionProximityParamsChangedImpl>
      get copyWith => __$$SessionProximityParamsChangedImplCopyWithImpl<
          _$SessionProximityParamsChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selfId, String roomCode, String username)
        started,
    required TResult Function(int id, String name) peerAdded,
    required TResult Function(int id) peerRemoved,
    required TResult Function(
            int id, double x, double z, double yaw, double speed)
        peerPositionUpdated,
    required TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)
        selfPositionUpdated,
    required TResult Function() gainTick,
    required TResult Function(
            int id,
            double distanceM,
            double rawGain,
            double gainL,
            double gainR,
            double pan,
            double dopplerFactor,
            int bufferMs)
        peerMetricsUpdated,
    required TResult Function(ProximityParams params) proximityParamsChanged,
    required TResult Function() ended,
  }) {
    return proximityParamsChanged(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selfId, String roomCode, String username)? started,
    TResult? Function(int id, String name)? peerAdded,
    TResult? Function(int id)? peerRemoved,
    TResult? Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult? Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult? Function()? gainTick,
    TResult? Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult? Function(ProximityParams params)? proximityParamsChanged,
    TResult? Function()? ended,
  }) {
    return proximityParamsChanged?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selfId, String roomCode, String username)? started,
    TResult Function(int id, String name)? peerAdded,
    TResult Function(int id)? peerRemoved,
    TResult Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult Function()? gainTick,
    TResult Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult Function(ProximityParams params)? proximityParamsChanged,
    TResult Function()? ended,
    required TResult orElse(),
  }) {
    if (proximityParamsChanged != null) {
      return proximityParamsChanged(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionStarted value) started,
    required TResult Function(SessionPeerAdded value) peerAdded,
    required TResult Function(SessionPeerRemoved value) peerRemoved,
    required TResult Function(SessionPeerPositionUpdated value)
        peerPositionUpdated,
    required TResult Function(SessionSelfPositionUpdated value)
        selfPositionUpdated,
    required TResult Function(SessionGainTick value) gainTick,
    required TResult Function(SessionPeerMetricsUpdated value)
        peerMetricsUpdated,
    required TResult Function(SessionProximityParamsChanged value)
        proximityParamsChanged,
    required TResult Function(SessionEnded value) ended,
  }) {
    return proximityParamsChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionStarted value)? started,
    TResult? Function(SessionPeerAdded value)? peerAdded,
    TResult? Function(SessionPeerRemoved value)? peerRemoved,
    TResult? Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult? Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult? Function(SessionGainTick value)? gainTick,
    TResult? Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult? Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult? Function(SessionEnded value)? ended,
  }) {
    return proximityParamsChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionStarted value)? started,
    TResult Function(SessionPeerAdded value)? peerAdded,
    TResult Function(SessionPeerRemoved value)? peerRemoved,
    TResult Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult Function(SessionGainTick value)? gainTick,
    TResult Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult Function(SessionEnded value)? ended,
    required TResult orElse(),
  }) {
    if (proximityParamsChanged != null) {
      return proximityParamsChanged(this);
    }
    return orElse();
  }
}

abstract class SessionProximityParamsChanged implements SessionEvent {
  const factory SessionProximityParamsChanged(
          {required final ProximityParams params}) =
      _$SessionProximityParamsChangedImpl;

  ProximityParams get params;

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionProximityParamsChangedImplCopyWith<
          _$SessionProximityParamsChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionEndedImplCopyWith<$Res> {
  factory _$$SessionEndedImplCopyWith(
          _$SessionEndedImpl value, $Res Function(_$SessionEndedImpl) then) =
      __$$SessionEndedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SessionEndedImplCopyWithImpl<$Res>
    extends _$SessionEventCopyWithImpl<$Res, _$SessionEndedImpl>
    implements _$$SessionEndedImplCopyWith<$Res> {
  __$$SessionEndedImplCopyWithImpl(
      _$SessionEndedImpl _value, $Res Function(_$SessionEndedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SessionEndedImpl implements SessionEnded {
  const _$SessionEndedImpl();

  @override
  String toString() {
    return 'SessionEvent.ended()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SessionEndedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selfId, String roomCode, String username)
        started,
    required TResult Function(int id, String name) peerAdded,
    required TResult Function(int id) peerRemoved,
    required TResult Function(
            int id, double x, double z, double yaw, double speed)
        peerPositionUpdated,
    required TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)
        selfPositionUpdated,
    required TResult Function() gainTick,
    required TResult Function(
            int id,
            double distanceM,
            double rawGain,
            double gainL,
            double gainR,
            double pan,
            double dopplerFactor,
            int bufferMs)
        peerMetricsUpdated,
    required TResult Function(ProximityParams params) proximityParamsChanged,
    required TResult Function() ended,
  }) {
    return ended();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selfId, String roomCode, String username)? started,
    TResult? Function(int id, String name)? peerAdded,
    TResult? Function(int id)? peerRemoved,
    TResult? Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult? Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult? Function()? gainTick,
    TResult? Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult? Function(ProximityParams params)? proximityParamsChanged,
    TResult? Function()? ended,
  }) {
    return ended?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selfId, String roomCode, String username)? started,
    TResult Function(int id, String name)? peerAdded,
    TResult Function(int id)? peerRemoved,
    TResult Function(int id, double x, double z, double yaw, double speed)?
        peerPositionUpdated,
    TResult Function(
            double x, double z, double yaw, double speed, bool isRaceOn)?
        selfPositionUpdated,
    TResult Function()? gainTick,
    TResult Function(int id, double distanceM, double rawGain, double gainL,
            double gainR, double pan, double dopplerFactor, int bufferMs)?
        peerMetricsUpdated,
    TResult Function(ProximityParams params)? proximityParamsChanged,
    TResult Function()? ended,
    required TResult orElse(),
  }) {
    if (ended != null) {
      return ended();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionStarted value) started,
    required TResult Function(SessionPeerAdded value) peerAdded,
    required TResult Function(SessionPeerRemoved value) peerRemoved,
    required TResult Function(SessionPeerPositionUpdated value)
        peerPositionUpdated,
    required TResult Function(SessionSelfPositionUpdated value)
        selfPositionUpdated,
    required TResult Function(SessionGainTick value) gainTick,
    required TResult Function(SessionPeerMetricsUpdated value)
        peerMetricsUpdated,
    required TResult Function(SessionProximityParamsChanged value)
        proximityParamsChanged,
    required TResult Function(SessionEnded value) ended,
  }) {
    return ended(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionStarted value)? started,
    TResult? Function(SessionPeerAdded value)? peerAdded,
    TResult? Function(SessionPeerRemoved value)? peerRemoved,
    TResult? Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult? Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult? Function(SessionGainTick value)? gainTick,
    TResult? Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult? Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult? Function(SessionEnded value)? ended,
  }) {
    return ended?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionStarted value)? started,
    TResult Function(SessionPeerAdded value)? peerAdded,
    TResult Function(SessionPeerRemoved value)? peerRemoved,
    TResult Function(SessionPeerPositionUpdated value)? peerPositionUpdated,
    TResult Function(SessionSelfPositionUpdated value)? selfPositionUpdated,
    TResult Function(SessionGainTick value)? gainTick,
    TResult Function(SessionPeerMetricsUpdated value)? peerMetricsUpdated,
    TResult Function(SessionProximityParamsChanged value)?
        proximityParamsChanged,
    TResult Function(SessionEnded value)? ended,
    required TResult orElse(),
  }) {
    if (ended != null) {
      return ended(this);
    }
    return orElse();
  }
}

abstract class SessionEnded implements SessionEvent {
  const factory SessionEnded() = _$SessionEndedImpl;
}

/// @nodoc
mixin _$SessionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            int selfId,
            String roomCode,
            String username,
            double selfX,
            double selfZ,
            double selfYaw,
            double selfSpeed,
            bool telemetryActive,
            Map<int, PeerModel> peers,
            ProximityParams proximity)
        active,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(
            int selfId,
            String roomCode,
            String username,
            double selfX,
            double selfZ,
            double selfYaw,
            double selfSpeed,
            bool telemetryActive,
            Map<int, PeerModel> peers,
            ProximityParams proximity)?
        active,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(
            int selfId,
            String roomCode,
            String username,
            double selfX,
            double selfZ,
            double selfYaw,
            double selfSpeed,
            bool telemetryActive,
            Map<int, PeerModel> peers,
            ProximityParams proximity)?
        active,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionIdle value) idle,
    required TResult Function(SessionActive value) active,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionIdle value)? idle,
    TResult? Function(SessionActive value)? active,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionIdle value)? idle,
    TResult Function(SessionActive value)? active,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionStateCopyWith<$Res> {
  factory $SessionStateCopyWith(
          SessionState value, $Res Function(SessionState) then) =
      _$SessionStateCopyWithImpl<$Res, SessionState>;
}

/// @nodoc
class _$SessionStateCopyWithImpl<$Res, $Val extends SessionState>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SessionIdleImplCopyWith<$Res> {
  factory _$$SessionIdleImplCopyWith(
          _$SessionIdleImpl value, $Res Function(_$SessionIdleImpl) then) =
      __$$SessionIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SessionIdleImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionIdleImpl>
    implements _$$SessionIdleImplCopyWith<$Res> {
  __$$SessionIdleImplCopyWithImpl(
      _$SessionIdleImpl _value, $Res Function(_$SessionIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SessionIdleImpl implements SessionIdle {
  const _$SessionIdleImpl();

  @override
  String toString() {
    return 'SessionState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SessionIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            int selfId,
            String roomCode,
            String username,
            double selfX,
            double selfZ,
            double selfYaw,
            double selfSpeed,
            bool telemetryActive,
            Map<int, PeerModel> peers,
            ProximityParams proximity)
        active,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(
            int selfId,
            String roomCode,
            String username,
            double selfX,
            double selfZ,
            double selfYaw,
            double selfSpeed,
            bool telemetryActive,
            Map<int, PeerModel> peers,
            ProximityParams proximity)?
        active,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(
            int selfId,
            String roomCode,
            String username,
            double selfX,
            double selfZ,
            double selfYaw,
            double selfSpeed,
            bool telemetryActive,
            Map<int, PeerModel> peers,
            ProximityParams proximity)?
        active,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionIdle value) idle,
    required TResult Function(SessionActive value) active,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionIdle value)? idle,
    TResult? Function(SessionActive value)? active,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionIdle value)? idle,
    TResult Function(SessionActive value)? active,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class SessionIdle implements SessionState {
  const factory SessionIdle() = _$SessionIdleImpl;
}

/// @nodoc
abstract class _$$SessionActiveImplCopyWith<$Res> {
  factory _$$SessionActiveImplCopyWith(
          _$SessionActiveImpl value, $Res Function(_$SessionActiveImpl) then) =
      __$$SessionActiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int selfId,
      String roomCode,
      String username,
      double selfX,
      double selfZ,
      double selfYaw,
      double selfSpeed,
      bool telemetryActive,
      Map<int, PeerModel> peers,
      ProximityParams proximity});

  $ProximityParamsCopyWith<$Res> get proximity;
}

/// @nodoc
class __$$SessionActiveImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionActiveImpl>
    implements _$$SessionActiveImplCopyWith<$Res> {
  __$$SessionActiveImplCopyWithImpl(
      _$SessionActiveImpl _value, $Res Function(_$SessionActiveImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selfId = null,
    Object? roomCode = null,
    Object? username = null,
    Object? selfX = null,
    Object? selfZ = null,
    Object? selfYaw = null,
    Object? selfSpeed = null,
    Object? telemetryActive = null,
    Object? peers = null,
    Object? proximity = null,
  }) {
    return _then(_$SessionActiveImpl(
      selfId: null == selfId
          ? _value.selfId
          : selfId // ignore: cast_nullable_to_non_nullable
              as int,
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      selfX: null == selfX
          ? _value.selfX
          : selfX // ignore: cast_nullable_to_non_nullable
              as double,
      selfZ: null == selfZ
          ? _value.selfZ
          : selfZ // ignore: cast_nullable_to_non_nullable
              as double,
      selfYaw: null == selfYaw
          ? _value.selfYaw
          : selfYaw // ignore: cast_nullable_to_non_nullable
              as double,
      selfSpeed: null == selfSpeed
          ? _value.selfSpeed
          : selfSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      telemetryActive: null == telemetryActive
          ? _value.telemetryActive
          : telemetryActive // ignore: cast_nullable_to_non_nullable
              as bool,
      peers: null == peers
          ? _value._peers
          : peers // ignore: cast_nullable_to_non_nullable
              as Map<int, PeerModel>,
      proximity: null == proximity
          ? _value.proximity
          : proximity // ignore: cast_nullable_to_non_nullable
              as ProximityParams,
    ));
  }

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProximityParamsCopyWith<$Res> get proximity {
    return $ProximityParamsCopyWith<$Res>(_value.proximity, (value) {
      return _then(_value.copyWith(proximity: value));
    });
  }
}

/// @nodoc

class _$SessionActiveImpl implements SessionActive {
  const _$SessionActiveImpl(
      {required this.selfId,
      required this.roomCode,
      required this.username,
      this.selfX = 0.0,
      this.selfZ = 0.0,
      this.selfYaw = 0.0,
      this.selfSpeed = 0.0,
      this.telemetryActive = false,
      final Map<int, PeerModel> peers = const {},
      this.proximity = const ProximityParams()})
      : _peers = peers;

  @override
  final int selfId;
  @override
  final String roomCode;
  @override
  final String username;
// Self position from telemetry
  @override
  @JsonKey()
  final double selfX;
  @override
  @JsonKey()
  final double selfZ;
  @override
  @JsonKey()
  final double selfYaw;
  @override
  @JsonKey()
  final double selfSpeed;
  @override
  @JsonKey()
  final bool telemetryActive;
// Peers — ordered by distance in the UI
  final Map<int, PeerModel> _peers;
// Peers — ordered by distance in the UI
  @override
  @JsonKey()
  Map<int, PeerModel> get peers {
    if (_peers is EqualUnmodifiableMapView) return _peers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_peers);
  }

// Live proximity config (editable mid-session)
  @override
  @JsonKey()
  final ProximityParams proximity;

  @override
  String toString() {
    return 'SessionState.active(selfId: $selfId, roomCode: $roomCode, username: $username, selfX: $selfX, selfZ: $selfZ, selfYaw: $selfYaw, selfSpeed: $selfSpeed, telemetryActive: $telemetryActive, peers: $peers, proximity: $proximity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionActiveImpl &&
            (identical(other.selfId, selfId) || other.selfId == selfId) &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.selfX, selfX) || other.selfX == selfX) &&
            (identical(other.selfZ, selfZ) || other.selfZ == selfZ) &&
            (identical(other.selfYaw, selfYaw) || other.selfYaw == selfYaw) &&
            (identical(other.selfSpeed, selfSpeed) ||
                other.selfSpeed == selfSpeed) &&
            (identical(other.telemetryActive, telemetryActive) ||
                other.telemetryActive == telemetryActive) &&
            const DeepCollectionEquality().equals(other._peers, _peers) &&
            (identical(other.proximity, proximity) ||
                other.proximity == proximity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selfId,
      roomCode,
      username,
      selfX,
      selfZ,
      selfYaw,
      selfSpeed,
      telemetryActive,
      const DeepCollectionEquality().hash(_peers),
      proximity);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionActiveImplCopyWith<_$SessionActiveImpl> get copyWith =>
      __$$SessionActiveImplCopyWithImpl<_$SessionActiveImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            int selfId,
            String roomCode,
            String username,
            double selfX,
            double selfZ,
            double selfYaw,
            double selfSpeed,
            bool telemetryActive,
            Map<int, PeerModel> peers,
            ProximityParams proximity)
        active,
  }) {
    return active(selfId, roomCode, username, selfX, selfZ, selfYaw, selfSpeed,
        telemetryActive, peers, proximity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(
            int selfId,
            String roomCode,
            String username,
            double selfX,
            double selfZ,
            double selfYaw,
            double selfSpeed,
            bool telemetryActive,
            Map<int, PeerModel> peers,
            ProximityParams proximity)?
        active,
  }) {
    return active?.call(selfId, roomCode, username, selfX, selfZ, selfYaw,
        selfSpeed, telemetryActive, peers, proximity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(
            int selfId,
            String roomCode,
            String username,
            double selfX,
            double selfZ,
            double selfYaw,
            double selfSpeed,
            bool telemetryActive,
            Map<int, PeerModel> peers,
            ProximityParams proximity)?
        active,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(selfId, roomCode, username, selfX, selfZ, selfYaw,
          selfSpeed, telemetryActive, peers, proximity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionIdle value) idle,
    required TResult Function(SessionActive value) active,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionIdle value)? idle,
    TResult? Function(SessionActive value)? active,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionIdle value)? idle,
    TResult Function(SessionActive value)? active,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class SessionActive implements SessionState {
  const factory SessionActive(
      {required final int selfId,
      required final String roomCode,
      required final String username,
      final double selfX,
      final double selfZ,
      final double selfYaw,
      final double selfSpeed,
      final bool telemetryActive,
      final Map<int, PeerModel> peers,
      final ProximityParams proximity}) = _$SessionActiveImpl;

  int get selfId;
  String get roomCode;
  String get username; // Self position from telemetry
  double get selfX;
  double get selfZ;
  double get selfYaw;
  double get selfSpeed;
  bool get telemetryActive; // Peers — ordered by distance in the UI
  Map<int, PeerModel> get peers; // Live proximity config (editable mid-session)
  ProximityParams get proximity;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionActiveImplCopyWith<_$SessionActiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
