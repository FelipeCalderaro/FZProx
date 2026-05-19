// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hub_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HubEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int port) startRequested,
    required TResult Function() stopRequested,
    required TResult Function() restartRequested,
    required TResult Function() statusRefreshed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int port)? startRequested,
    TResult? Function()? stopRequested,
    TResult? Function()? restartRequested,
    TResult? Function()? statusRefreshed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int port)? startRequested,
    TResult Function()? stopRequested,
    TResult Function()? restartRequested,
    TResult Function()? statusRefreshed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HubStartRequested value) startRequested,
    required TResult Function(HubStopRequested value) stopRequested,
    required TResult Function(HubRestartRequested value) restartRequested,
    required TResult Function(HubStatusRefreshed value) statusRefreshed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HubStartRequested value)? startRequested,
    TResult? Function(HubStopRequested value)? stopRequested,
    TResult? Function(HubRestartRequested value)? restartRequested,
    TResult? Function(HubStatusRefreshed value)? statusRefreshed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HubStartRequested value)? startRequested,
    TResult Function(HubStopRequested value)? stopRequested,
    TResult Function(HubRestartRequested value)? restartRequested,
    TResult Function(HubStatusRefreshed value)? statusRefreshed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HubEventCopyWith<$Res> {
  factory $HubEventCopyWith(HubEvent value, $Res Function(HubEvent) then) =
      _$HubEventCopyWithImpl<$Res, HubEvent>;
}

/// @nodoc
class _$HubEventCopyWithImpl<$Res, $Val extends HubEvent>
    implements $HubEventCopyWith<$Res> {
  _$HubEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HubEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HubStartRequestedImplCopyWith<$Res> {
  factory _$$HubStartRequestedImplCopyWith(_$HubStartRequestedImpl value,
          $Res Function(_$HubStartRequestedImpl) then) =
      __$$HubStartRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int port});
}

/// @nodoc
class __$$HubStartRequestedImplCopyWithImpl<$Res>
    extends _$HubEventCopyWithImpl<$Res, _$HubStartRequestedImpl>
    implements _$$HubStartRequestedImplCopyWith<$Res> {
  __$$HubStartRequestedImplCopyWithImpl(_$HubStartRequestedImpl _value,
      $Res Function(_$HubStartRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HubEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? port = null,
  }) {
    return _then(_$HubStartRequestedImpl(
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HubStartRequestedImpl implements HubStartRequested {
  const _$HubStartRequestedImpl({this.port = kDefaultHubPort});

  @override
  @JsonKey()
  final int port;

  @override
  String toString() {
    return 'HubEvent.startRequested(port: $port)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HubStartRequestedImpl &&
            (identical(other.port, port) || other.port == port));
  }

  @override
  int get hashCode => Object.hash(runtimeType, port);

  /// Create a copy of HubEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HubStartRequestedImplCopyWith<_$HubStartRequestedImpl> get copyWith =>
      __$$HubStartRequestedImplCopyWithImpl<_$HubStartRequestedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int port) startRequested,
    required TResult Function() stopRequested,
    required TResult Function() restartRequested,
    required TResult Function() statusRefreshed,
  }) {
    return startRequested(port);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int port)? startRequested,
    TResult? Function()? stopRequested,
    TResult? Function()? restartRequested,
    TResult? Function()? statusRefreshed,
  }) {
    return startRequested?.call(port);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int port)? startRequested,
    TResult Function()? stopRequested,
    TResult Function()? restartRequested,
    TResult Function()? statusRefreshed,
    required TResult orElse(),
  }) {
    if (startRequested != null) {
      return startRequested(port);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HubStartRequested value) startRequested,
    required TResult Function(HubStopRequested value) stopRequested,
    required TResult Function(HubRestartRequested value) restartRequested,
    required TResult Function(HubStatusRefreshed value) statusRefreshed,
  }) {
    return startRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HubStartRequested value)? startRequested,
    TResult? Function(HubStopRequested value)? stopRequested,
    TResult? Function(HubRestartRequested value)? restartRequested,
    TResult? Function(HubStatusRefreshed value)? statusRefreshed,
  }) {
    return startRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HubStartRequested value)? startRequested,
    TResult Function(HubStopRequested value)? stopRequested,
    TResult Function(HubRestartRequested value)? restartRequested,
    TResult Function(HubStatusRefreshed value)? statusRefreshed,
    required TResult orElse(),
  }) {
    if (startRequested != null) {
      return startRequested(this);
    }
    return orElse();
  }
}

abstract class HubStartRequested implements HubEvent {
  const factory HubStartRequested({final int port}) = _$HubStartRequestedImpl;

  int get port;

  /// Create a copy of HubEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HubStartRequestedImplCopyWith<_$HubStartRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HubStopRequestedImplCopyWith<$Res> {
  factory _$$HubStopRequestedImplCopyWith(_$HubStopRequestedImpl value,
          $Res Function(_$HubStopRequestedImpl) then) =
      __$$HubStopRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HubStopRequestedImplCopyWithImpl<$Res>
    extends _$HubEventCopyWithImpl<$Res, _$HubStopRequestedImpl>
    implements _$$HubStopRequestedImplCopyWith<$Res> {
  __$$HubStopRequestedImplCopyWithImpl(_$HubStopRequestedImpl _value,
      $Res Function(_$HubStopRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HubEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HubStopRequestedImpl implements HubStopRequested {
  const _$HubStopRequestedImpl();

  @override
  String toString() {
    return 'HubEvent.stopRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HubStopRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int port) startRequested,
    required TResult Function() stopRequested,
    required TResult Function() restartRequested,
    required TResult Function() statusRefreshed,
  }) {
    return stopRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int port)? startRequested,
    TResult? Function()? stopRequested,
    TResult? Function()? restartRequested,
    TResult? Function()? statusRefreshed,
  }) {
    return stopRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int port)? startRequested,
    TResult Function()? stopRequested,
    TResult Function()? restartRequested,
    TResult Function()? statusRefreshed,
    required TResult orElse(),
  }) {
    if (stopRequested != null) {
      return stopRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HubStartRequested value) startRequested,
    required TResult Function(HubStopRequested value) stopRequested,
    required TResult Function(HubRestartRequested value) restartRequested,
    required TResult Function(HubStatusRefreshed value) statusRefreshed,
  }) {
    return stopRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HubStartRequested value)? startRequested,
    TResult? Function(HubStopRequested value)? stopRequested,
    TResult? Function(HubRestartRequested value)? restartRequested,
    TResult? Function(HubStatusRefreshed value)? statusRefreshed,
  }) {
    return stopRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HubStartRequested value)? startRequested,
    TResult Function(HubStopRequested value)? stopRequested,
    TResult Function(HubRestartRequested value)? restartRequested,
    TResult Function(HubStatusRefreshed value)? statusRefreshed,
    required TResult orElse(),
  }) {
    if (stopRequested != null) {
      return stopRequested(this);
    }
    return orElse();
  }
}

abstract class HubStopRequested implements HubEvent {
  const factory HubStopRequested() = _$HubStopRequestedImpl;
}

/// @nodoc
abstract class _$$HubRestartRequestedImplCopyWith<$Res> {
  factory _$$HubRestartRequestedImplCopyWith(_$HubRestartRequestedImpl value,
          $Res Function(_$HubRestartRequestedImpl) then) =
      __$$HubRestartRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HubRestartRequestedImplCopyWithImpl<$Res>
    extends _$HubEventCopyWithImpl<$Res, _$HubRestartRequestedImpl>
    implements _$$HubRestartRequestedImplCopyWith<$Res> {
  __$$HubRestartRequestedImplCopyWithImpl(_$HubRestartRequestedImpl _value,
      $Res Function(_$HubRestartRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HubEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HubRestartRequestedImpl implements HubRestartRequested {
  const _$HubRestartRequestedImpl();

  @override
  String toString() {
    return 'HubEvent.restartRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HubRestartRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int port) startRequested,
    required TResult Function() stopRequested,
    required TResult Function() restartRequested,
    required TResult Function() statusRefreshed,
  }) {
    return restartRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int port)? startRequested,
    TResult? Function()? stopRequested,
    TResult? Function()? restartRequested,
    TResult? Function()? statusRefreshed,
  }) {
    return restartRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int port)? startRequested,
    TResult Function()? stopRequested,
    TResult Function()? restartRequested,
    TResult Function()? statusRefreshed,
    required TResult orElse(),
  }) {
    if (restartRequested != null) {
      return restartRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HubStartRequested value) startRequested,
    required TResult Function(HubStopRequested value) stopRequested,
    required TResult Function(HubRestartRequested value) restartRequested,
    required TResult Function(HubStatusRefreshed value) statusRefreshed,
  }) {
    return restartRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HubStartRequested value)? startRequested,
    TResult? Function(HubStopRequested value)? stopRequested,
    TResult? Function(HubRestartRequested value)? restartRequested,
    TResult? Function(HubStatusRefreshed value)? statusRefreshed,
  }) {
    return restartRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HubStartRequested value)? startRequested,
    TResult Function(HubStopRequested value)? stopRequested,
    TResult Function(HubRestartRequested value)? restartRequested,
    TResult Function(HubStatusRefreshed value)? statusRefreshed,
    required TResult orElse(),
  }) {
    if (restartRequested != null) {
      return restartRequested(this);
    }
    return orElse();
  }
}

abstract class HubRestartRequested implements HubEvent {
  const factory HubRestartRequested() = _$HubRestartRequestedImpl;
}

/// @nodoc
abstract class _$$HubStatusRefreshedImplCopyWith<$Res> {
  factory _$$HubStatusRefreshedImplCopyWith(_$HubStatusRefreshedImpl value,
          $Res Function(_$HubStatusRefreshedImpl) then) =
      __$$HubStatusRefreshedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HubStatusRefreshedImplCopyWithImpl<$Res>
    extends _$HubEventCopyWithImpl<$Res, _$HubStatusRefreshedImpl>
    implements _$$HubStatusRefreshedImplCopyWith<$Res> {
  __$$HubStatusRefreshedImplCopyWithImpl(_$HubStatusRefreshedImpl _value,
      $Res Function(_$HubStatusRefreshedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HubEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HubStatusRefreshedImpl implements HubStatusRefreshed {
  const _$HubStatusRefreshedImpl();

  @override
  String toString() {
    return 'HubEvent.statusRefreshed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HubStatusRefreshedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int port) startRequested,
    required TResult Function() stopRequested,
    required TResult Function() restartRequested,
    required TResult Function() statusRefreshed,
  }) {
    return statusRefreshed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int port)? startRequested,
    TResult? Function()? stopRequested,
    TResult? Function()? restartRequested,
    TResult? Function()? statusRefreshed,
  }) {
    return statusRefreshed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int port)? startRequested,
    TResult Function()? stopRequested,
    TResult Function()? restartRequested,
    TResult Function()? statusRefreshed,
    required TResult orElse(),
  }) {
    if (statusRefreshed != null) {
      return statusRefreshed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HubStartRequested value) startRequested,
    required TResult Function(HubStopRequested value) stopRequested,
    required TResult Function(HubRestartRequested value) restartRequested,
    required TResult Function(HubStatusRefreshed value) statusRefreshed,
  }) {
    return statusRefreshed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HubStartRequested value)? startRequested,
    TResult? Function(HubStopRequested value)? stopRequested,
    TResult? Function(HubRestartRequested value)? restartRequested,
    TResult? Function(HubStatusRefreshed value)? statusRefreshed,
  }) {
    return statusRefreshed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HubStartRequested value)? startRequested,
    TResult Function(HubStopRequested value)? stopRequested,
    TResult Function(HubRestartRequested value)? restartRequested,
    TResult Function(HubStatusRefreshed value)? statusRefreshed,
    required TResult orElse(),
  }) {
    if (statusRefreshed != null) {
      return statusRefreshed(this);
    }
    return orElse();
  }
}

abstract class HubStatusRefreshed implements HubEvent {
  const factory HubStatusRefreshed() = _$HubStatusRefreshedImpl;
}

/// @nodoc
mixin _$HubState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function() starting,
    required TResult Function(int port, List<({String code, int count})> rooms)
        running,
    required TResult Function(String message) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function()? starting,
    TResult? Function(int port, List<({String code, int count})> rooms)?
        running,
    TResult? Function(String message)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function()? starting,
    TResult Function(int port, List<({String code, int count})> rooms)? running,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HubStopped value) stopped,
    required TResult Function(HubStarting value) starting,
    required TResult Function(HubRunning value) running,
    required TResult Function(HubFailed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HubStopped value)? stopped,
    TResult? Function(HubStarting value)? starting,
    TResult? Function(HubRunning value)? running,
    TResult? Function(HubFailed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HubStopped value)? stopped,
    TResult Function(HubStarting value)? starting,
    TResult Function(HubRunning value)? running,
    TResult Function(HubFailed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HubStateCopyWith<$Res> {
  factory $HubStateCopyWith(HubState value, $Res Function(HubState) then) =
      _$HubStateCopyWithImpl<$Res, HubState>;
}

/// @nodoc
class _$HubStateCopyWithImpl<$Res, $Val extends HubState>
    implements $HubStateCopyWith<$Res> {
  _$HubStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HubState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HubStoppedImplCopyWith<$Res> {
  factory _$$HubStoppedImplCopyWith(
          _$HubStoppedImpl value, $Res Function(_$HubStoppedImpl) then) =
      __$$HubStoppedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HubStoppedImplCopyWithImpl<$Res>
    extends _$HubStateCopyWithImpl<$Res, _$HubStoppedImpl>
    implements _$$HubStoppedImplCopyWith<$Res> {
  __$$HubStoppedImplCopyWithImpl(
      _$HubStoppedImpl _value, $Res Function(_$HubStoppedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HubState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HubStoppedImpl implements HubStopped {
  const _$HubStoppedImpl();

  @override
  String toString() {
    return 'HubState.stopped()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HubStoppedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function() starting,
    required TResult Function(int port, List<({String code, int count})> rooms)
        running,
    required TResult Function(String message) failed,
  }) {
    return stopped();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function()? starting,
    TResult? Function(int port, List<({String code, int count})> rooms)?
        running,
    TResult? Function(String message)? failed,
  }) {
    return stopped?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function()? starting,
    TResult Function(int port, List<({String code, int count})> rooms)? running,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (stopped != null) {
      return stopped();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HubStopped value) stopped,
    required TResult Function(HubStarting value) starting,
    required TResult Function(HubRunning value) running,
    required TResult Function(HubFailed value) failed,
  }) {
    return stopped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HubStopped value)? stopped,
    TResult? Function(HubStarting value)? starting,
    TResult? Function(HubRunning value)? running,
    TResult? Function(HubFailed value)? failed,
  }) {
    return stopped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HubStopped value)? stopped,
    TResult Function(HubStarting value)? starting,
    TResult Function(HubRunning value)? running,
    TResult Function(HubFailed value)? failed,
    required TResult orElse(),
  }) {
    if (stopped != null) {
      return stopped(this);
    }
    return orElse();
  }
}

abstract class HubStopped implements HubState {
  const factory HubStopped() = _$HubStoppedImpl;
}

/// @nodoc
abstract class _$$HubStartingImplCopyWith<$Res> {
  factory _$$HubStartingImplCopyWith(
          _$HubStartingImpl value, $Res Function(_$HubStartingImpl) then) =
      __$$HubStartingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HubStartingImplCopyWithImpl<$Res>
    extends _$HubStateCopyWithImpl<$Res, _$HubStartingImpl>
    implements _$$HubStartingImplCopyWith<$Res> {
  __$$HubStartingImplCopyWithImpl(
      _$HubStartingImpl _value, $Res Function(_$HubStartingImpl) _then)
      : super(_value, _then);

  /// Create a copy of HubState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HubStartingImpl implements HubStarting {
  const _$HubStartingImpl();

  @override
  String toString() {
    return 'HubState.starting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HubStartingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function() starting,
    required TResult Function(int port, List<({String code, int count})> rooms)
        running,
    required TResult Function(String message) failed,
  }) {
    return starting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function()? starting,
    TResult? Function(int port, List<({String code, int count})> rooms)?
        running,
    TResult? Function(String message)? failed,
  }) {
    return starting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function()? starting,
    TResult Function(int port, List<({String code, int count})> rooms)? running,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (starting != null) {
      return starting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HubStopped value) stopped,
    required TResult Function(HubStarting value) starting,
    required TResult Function(HubRunning value) running,
    required TResult Function(HubFailed value) failed,
  }) {
    return starting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HubStopped value)? stopped,
    TResult? Function(HubStarting value)? starting,
    TResult? Function(HubRunning value)? running,
    TResult? Function(HubFailed value)? failed,
  }) {
    return starting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HubStopped value)? stopped,
    TResult Function(HubStarting value)? starting,
    TResult Function(HubRunning value)? running,
    TResult Function(HubFailed value)? failed,
    required TResult orElse(),
  }) {
    if (starting != null) {
      return starting(this);
    }
    return orElse();
  }
}

abstract class HubStarting implements HubState {
  const factory HubStarting() = _$HubStartingImpl;
}

/// @nodoc
abstract class _$$HubRunningImplCopyWith<$Res> {
  factory _$$HubRunningImplCopyWith(
          _$HubRunningImpl value, $Res Function(_$HubRunningImpl) then) =
      __$$HubRunningImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int port, List<({String code, int count})> rooms});
}

/// @nodoc
class __$$HubRunningImplCopyWithImpl<$Res>
    extends _$HubStateCopyWithImpl<$Res, _$HubRunningImpl>
    implements _$$HubRunningImplCopyWith<$Res> {
  __$$HubRunningImplCopyWithImpl(
      _$HubRunningImpl _value, $Res Function(_$HubRunningImpl) _then)
      : super(_value, _then);

  /// Create a copy of HubState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? port = null,
    Object? rooms = null,
  }) {
    return _then(_$HubRunningImpl(
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      rooms: null == rooms
          ? _value._rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<({String code, int count})>,
    ));
  }
}

/// @nodoc

class _$HubRunningImpl implements HubRunning {
  const _$HubRunningImpl(
      {required this.port,
      required final List<({String code, int count})> rooms})
      : _rooms = rooms;

  @override
  final int port;
  final List<({String code, int count})> _rooms;
  @override
  List<({String code, int count})> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString() {
    return 'HubState.running(port: $port, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HubRunningImpl &&
            (identical(other.port, port) || other.port == port) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, port, const DeepCollectionEquality().hash(_rooms));

  /// Create a copy of HubState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HubRunningImplCopyWith<_$HubRunningImpl> get copyWith =>
      __$$HubRunningImplCopyWithImpl<_$HubRunningImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function() starting,
    required TResult Function(int port, List<({String code, int count})> rooms)
        running,
    required TResult Function(String message) failed,
  }) {
    return running(port, rooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function()? starting,
    TResult? Function(int port, List<({String code, int count})> rooms)?
        running,
    TResult? Function(String message)? failed,
  }) {
    return running?.call(port, rooms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function()? starting,
    TResult Function(int port, List<({String code, int count})> rooms)? running,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (running != null) {
      return running(port, rooms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HubStopped value) stopped,
    required TResult Function(HubStarting value) starting,
    required TResult Function(HubRunning value) running,
    required TResult Function(HubFailed value) failed,
  }) {
    return running(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HubStopped value)? stopped,
    TResult? Function(HubStarting value)? starting,
    TResult? Function(HubRunning value)? running,
    TResult? Function(HubFailed value)? failed,
  }) {
    return running?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HubStopped value)? stopped,
    TResult Function(HubStarting value)? starting,
    TResult Function(HubRunning value)? running,
    TResult Function(HubFailed value)? failed,
    required TResult orElse(),
  }) {
    if (running != null) {
      return running(this);
    }
    return orElse();
  }
}

abstract class HubRunning implements HubState {
  const factory HubRunning(
          {required final int port,
          required final List<({String code, int count})> rooms}) =
      _$HubRunningImpl;

  int get port;
  List<({String code, int count})> get rooms;

  /// Create a copy of HubState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HubRunningImplCopyWith<_$HubRunningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HubFailedImplCopyWith<$Res> {
  factory _$$HubFailedImplCopyWith(
          _$HubFailedImpl value, $Res Function(_$HubFailedImpl) then) =
      __$$HubFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$HubFailedImplCopyWithImpl<$Res>
    extends _$HubStateCopyWithImpl<$Res, _$HubFailedImpl>
    implements _$$HubFailedImplCopyWith<$Res> {
  __$$HubFailedImplCopyWithImpl(
      _$HubFailedImpl _value, $Res Function(_$HubFailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HubState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$HubFailedImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HubFailedImpl implements HubFailed {
  const _$HubFailedImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'HubState.failed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HubFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of HubState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HubFailedImplCopyWith<_$HubFailedImpl> get copyWith =>
      __$$HubFailedImplCopyWithImpl<_$HubFailedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stopped,
    required TResult Function() starting,
    required TResult Function(int port, List<({String code, int count})> rooms)
        running,
    required TResult Function(String message) failed,
  }) {
    return failed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stopped,
    TResult? Function()? starting,
    TResult? Function(int port, List<({String code, int count})> rooms)?
        running,
    TResult? Function(String message)? failed,
  }) {
    return failed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stopped,
    TResult Function()? starting,
    TResult Function(int port, List<({String code, int count})> rooms)? running,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HubStopped value) stopped,
    required TResult Function(HubStarting value) starting,
    required TResult Function(HubRunning value) running,
    required TResult Function(HubFailed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HubStopped value)? stopped,
    TResult? Function(HubStarting value)? starting,
    TResult? Function(HubRunning value)? running,
    TResult? Function(HubFailed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HubStopped value)? stopped,
    TResult Function(HubStarting value)? starting,
    TResult Function(HubRunning value)? running,
    TResult Function(HubFailed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class HubFailed implements HubState {
  const factory HubFailed({required final String message}) = _$HubFailedImpl;

  String get message;

  /// Create a copy of HubState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HubFailedImplCopyWith<_$HubFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
