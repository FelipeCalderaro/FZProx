// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConnectionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionEventCopyWith<$Res> {
  factory $ConnectionEventCopyWith(
          ConnectionEvent value, $Res Function(ConnectionEvent) then) =
      _$ConnectionEventCopyWithImpl<$Res, ConnectionEvent>;
}

/// @nodoc
class _$ConnectionEventCopyWithImpl<$Res, $Val extends ConnectionEvent>
    implements $ConnectionEventCopyWith<$Res> {
  _$ConnectionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConnectionConnectImplCopyWith<$Res> {
  factory _$$ConnectionConnectImplCopyWith(_$ConnectionConnectImpl value,
          $Res Function(_$ConnectionConnectImpl) then) =
      __$$ConnectionConnectImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String hubHost, int hubPort, String username});
}

/// @nodoc
class __$$ConnectionConnectImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionConnectImpl>
    implements _$$ConnectionConnectImplCopyWith<$Res> {
  __$$ConnectionConnectImplCopyWithImpl(_$ConnectionConnectImpl _value,
      $Res Function(_$ConnectionConnectImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hubHost = null,
    Object? hubPort = null,
    Object? username = null,
  }) {
    return _then(_$ConnectionConnectImpl(
      hubHost: null == hubHost
          ? _value.hubHost
          : hubHost // ignore: cast_nullable_to_non_nullable
              as String,
      hubPort: null == hubPort
          ? _value.hubPort
          : hubPort // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectionConnectImpl implements ConnectionConnect {
  const _$ConnectionConnectImpl(
      {required this.hubHost, required this.hubPort, required this.username});

  @override
  final String hubHost;
  @override
  final int hubPort;
  @override
  final String username;

  @override
  String toString() {
    return 'ConnectionEvent.connect(hubHost: $hubHost, hubPort: $hubPort, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionConnectImpl &&
            (identical(other.hubHost, hubHost) || other.hubHost == hubHost) &&
            (identical(other.hubPort, hubPort) || other.hubPort == hubPort) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hubHost, hubPort, username);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionConnectImplCopyWith<_$ConnectionConnectImpl> get copyWith =>
      __$$ConnectionConnectImplCopyWithImpl<_$ConnectionConnectImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) {
    return connect(hubHost, hubPort, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) {
    return connect?.call(hubHost, hubPort, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) {
    if (connect != null) {
      return connect(hubHost, hubPort, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) {
    return connect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) {
    return connect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) {
    if (connect != null) {
      return connect(this);
    }
    return orElse();
  }
}

abstract class ConnectionConnect implements ConnectionEvent {
  const factory ConnectionConnect(
      {required final String hubHost,
      required final int hubPort,
      required final String username}) = _$ConnectionConnectImpl;

  String get hubHost;
  int get hubPort;
  String get username;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionConnectImplCopyWith<_$ConnectionConnectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionListRoomsImplCopyWith<$Res> {
  factory _$$ConnectionListRoomsImplCopyWith(_$ConnectionListRoomsImpl value,
          $Res Function(_$ConnectionListRoomsImpl) then) =
      __$$ConnectionListRoomsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionListRoomsImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionListRoomsImpl>
    implements _$$ConnectionListRoomsImplCopyWith<$Res> {
  __$$ConnectionListRoomsImplCopyWithImpl(_$ConnectionListRoomsImpl _value,
      $Res Function(_$ConnectionListRoomsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectionListRoomsImpl implements ConnectionListRooms {
  const _$ConnectionListRoomsImpl();

  @override
  String toString() {
    return 'ConnectionEvent.listRooms()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionListRoomsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) {
    return listRooms();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) {
    return listRooms?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) {
    if (listRooms != null) {
      return listRooms();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) {
    return listRooms(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) {
    return listRooms?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) {
    if (listRooms != null) {
      return listRooms(this);
    }
    return orElse();
  }
}

abstract class ConnectionListRooms implements ConnectionEvent {
  const factory ConnectionListRooms() = _$ConnectionListRoomsImpl;
}

/// @nodoc
abstract class _$$ConnectionJoinRoomImplCopyWith<$Res> {
  factory _$$ConnectionJoinRoomImplCopyWith(_$ConnectionJoinRoomImpl value,
          $Res Function(_$ConnectionJoinRoomImpl) then) =
      __$$ConnectionJoinRoomImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String code, String username});
}

/// @nodoc
class __$$ConnectionJoinRoomImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionJoinRoomImpl>
    implements _$$ConnectionJoinRoomImplCopyWith<$Res> {
  __$$ConnectionJoinRoomImplCopyWithImpl(_$ConnectionJoinRoomImpl _value,
      $Res Function(_$ConnectionJoinRoomImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? username = null,
  }) {
    return _then(_$ConnectionJoinRoomImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectionJoinRoomImpl implements ConnectionJoinRoom {
  const _$ConnectionJoinRoomImpl({required this.code, required this.username});

  @override
  final String code;
  @override
  final String username;

  @override
  String toString() {
    return 'ConnectionEvent.joinRoom(code: $code, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionJoinRoomImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, username);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionJoinRoomImplCopyWith<_$ConnectionJoinRoomImpl> get copyWith =>
      __$$ConnectionJoinRoomImplCopyWithImpl<_$ConnectionJoinRoomImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) {
    return joinRoom(code, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) {
    return joinRoom?.call(code, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) {
    if (joinRoom != null) {
      return joinRoom(code, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) {
    return joinRoom(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) {
    return joinRoom?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) {
    if (joinRoom != null) {
      return joinRoom(this);
    }
    return orElse();
  }
}

abstract class ConnectionJoinRoom implements ConnectionEvent {
  const factory ConnectionJoinRoom(
      {required final String code,
      required final String username}) = _$ConnectionJoinRoomImpl;

  String get code;
  String get username;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionJoinRoomImplCopyWith<_$ConnectionJoinRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionCreateRoomImplCopyWith<$Res> {
  factory _$$ConnectionCreateRoomImplCopyWith(_$ConnectionCreateRoomImpl value,
          $Res Function(_$ConnectionCreateRoomImpl) then) =
      __$$ConnectionCreateRoomImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String username});
}

/// @nodoc
class __$$ConnectionCreateRoomImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionCreateRoomImpl>
    implements _$$ConnectionCreateRoomImplCopyWith<$Res> {
  __$$ConnectionCreateRoomImplCopyWithImpl(_$ConnectionCreateRoomImpl _value,
      $Res Function(_$ConnectionCreateRoomImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
  }) {
    return _then(_$ConnectionCreateRoomImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectionCreateRoomImpl implements ConnectionCreateRoom {
  const _$ConnectionCreateRoomImpl({required this.username});

  @override
  final String username;

  @override
  String toString() {
    return 'ConnectionEvent.createRoom(username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionCreateRoomImpl &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionCreateRoomImplCopyWith<_$ConnectionCreateRoomImpl>
      get copyWith =>
          __$$ConnectionCreateRoomImplCopyWithImpl<_$ConnectionCreateRoomImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) {
    return createRoom(username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) {
    return createRoom?.call(username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) {
    if (createRoom != null) {
      return createRoom(username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) {
    return createRoom(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) {
    return createRoom?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) {
    if (createRoom != null) {
      return createRoom(this);
    }
    return orElse();
  }
}

abstract class ConnectionCreateRoom implements ConnectionEvent {
  const factory ConnectionCreateRoom({required final String username}) =
      _$ConnectionCreateRoomImpl;

  String get username;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionCreateRoomImplCopyWith<_$ConnectionCreateRoomImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionDisconnectImplCopyWith<$Res> {
  factory _$$ConnectionDisconnectImplCopyWith(_$ConnectionDisconnectImpl value,
          $Res Function(_$ConnectionDisconnectImpl) then) =
      __$$ConnectionDisconnectImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionDisconnectImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionDisconnectImpl>
    implements _$$ConnectionDisconnectImplCopyWith<$Res> {
  __$$ConnectionDisconnectImplCopyWithImpl(_$ConnectionDisconnectImpl _value,
      $Res Function(_$ConnectionDisconnectImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectionDisconnectImpl implements ConnectionDisconnect {
  const _$ConnectionDisconnectImpl();

  @override
  String toString() {
    return 'ConnectionEvent.disconnect()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionDisconnectImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) {
    return disconnect();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) {
    return disconnect?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) {
    return disconnect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) {
    return disconnect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect(this);
    }
    return orElse();
  }
}

abstract class ConnectionDisconnect implements ConnectionEvent {
  const factory ConnectionDisconnect() = _$ConnectionDisconnectImpl;
}

/// @nodoc
abstract class _$$ConnectionRoomListReceivedImplCopyWith<$Res> {
  factory _$$ConnectionRoomListReceivedImplCopyWith(
          _$ConnectionRoomListReceivedImpl value,
          $Res Function(_$ConnectionRoomListReceivedImpl) then) =
      __$$ConnectionRoomListReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<RoomInfo> rooms});
}

/// @nodoc
class __$$ConnectionRoomListReceivedImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res,
        _$ConnectionRoomListReceivedImpl>
    implements _$$ConnectionRoomListReceivedImplCopyWith<$Res> {
  __$$ConnectionRoomListReceivedImplCopyWithImpl(
      _$ConnectionRoomListReceivedImpl _value,
      $Res Function(_$ConnectionRoomListReceivedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rooms = null,
  }) {
    return _then(_$ConnectionRoomListReceivedImpl(
      rooms: null == rooms
          ? _value._rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<RoomInfo>,
    ));
  }
}

/// @nodoc

class _$ConnectionRoomListReceivedImpl implements ConnectionRoomListReceived {
  const _$ConnectionRoomListReceivedImpl({required final List<RoomInfo> rooms})
      : _rooms = rooms;

  final List<RoomInfo> _rooms;
  @override
  List<RoomInfo> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString() {
    return 'ConnectionEvent.roomListReceived(rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionRoomListReceivedImpl &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_rooms));

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionRoomListReceivedImplCopyWith<_$ConnectionRoomListReceivedImpl>
      get copyWith => __$$ConnectionRoomListReceivedImplCopyWithImpl<
          _$ConnectionRoomListReceivedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) {
    return roomListReceived(rooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) {
    return roomListReceived?.call(rooms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) {
    if (roomListReceived != null) {
      return roomListReceived(rooms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) {
    return roomListReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) {
    return roomListReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) {
    if (roomListReceived != null) {
      return roomListReceived(this);
    }
    return orElse();
  }
}

abstract class ConnectionRoomListReceived implements ConnectionEvent {
  const factory ConnectionRoomListReceived(
      {required final List<RoomInfo> rooms}) = _$ConnectionRoomListReceivedImpl;

  List<RoomInfo> get rooms;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionRoomListReceivedImplCopyWith<_$ConnectionRoomListReceivedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionWelcomeReceivedImplCopyWith<$Res> {
  factory _$$ConnectionWelcomeReceivedImplCopyWith(
          _$ConnectionWelcomeReceivedImpl value,
          $Res Function(_$ConnectionWelcomeReceivedImpl) then) =
      __$$ConnectionWelcomeReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int selfId, String roomCode, List<({int id, String name})> peers});
}

/// @nodoc
class __$$ConnectionWelcomeReceivedImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionWelcomeReceivedImpl>
    implements _$$ConnectionWelcomeReceivedImplCopyWith<$Res> {
  __$$ConnectionWelcomeReceivedImplCopyWithImpl(
      _$ConnectionWelcomeReceivedImpl _value,
      $Res Function(_$ConnectionWelcomeReceivedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selfId = null,
    Object? roomCode = null,
    Object? peers = null,
  }) {
    return _then(_$ConnectionWelcomeReceivedImpl(
      selfId: null == selfId
          ? _value.selfId
          : selfId // ignore: cast_nullable_to_non_nullable
              as int,
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
      peers: null == peers
          ? _value._peers
          : peers // ignore: cast_nullable_to_non_nullable
              as List<({int id, String name})>,
    ));
  }
}

/// @nodoc

class _$ConnectionWelcomeReceivedImpl implements ConnectionWelcomeReceived {
  const _$ConnectionWelcomeReceivedImpl(
      {required this.selfId,
      required this.roomCode,
      required final List<({int id, String name})> peers})
      : _peers = peers;

  @override
  final int selfId;
  @override
  final String roomCode;
  final List<({int id, String name})> _peers;
  @override
  List<({int id, String name})> get peers {
    if (_peers is EqualUnmodifiableListView) return _peers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_peers);
  }

  @override
  String toString() {
    return 'ConnectionEvent.welcomeReceived(selfId: $selfId, roomCode: $roomCode, peers: $peers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionWelcomeReceivedImpl &&
            (identical(other.selfId, selfId) || other.selfId == selfId) &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode) &&
            const DeepCollectionEquality().equals(other._peers, _peers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selfId, roomCode,
      const DeepCollectionEquality().hash(_peers));

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionWelcomeReceivedImplCopyWith<_$ConnectionWelcomeReceivedImpl>
      get copyWith => __$$ConnectionWelcomeReceivedImplCopyWithImpl<
          _$ConnectionWelcomeReceivedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) {
    return welcomeReceived(selfId, roomCode, peers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) {
    return welcomeReceived?.call(selfId, roomCode, peers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) {
    if (welcomeReceived != null) {
      return welcomeReceived(selfId, roomCode, peers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) {
    return welcomeReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) {
    return welcomeReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) {
    if (welcomeReceived != null) {
      return welcomeReceived(this);
    }
    return orElse();
  }
}

abstract class ConnectionWelcomeReceived implements ConnectionEvent {
  const factory ConnectionWelcomeReceived(
          {required final int selfId,
          required final String roomCode,
          required final List<({int id, String name})> peers}) =
      _$ConnectionWelcomeReceivedImpl;

  int get selfId;
  String get roomCode;
  List<({int id, String name})> get peers;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionWelcomeReceivedImplCopyWith<_$ConnectionWelcomeReceivedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionErrorReceivedImplCopyWith<$Res> {
  factory _$$ConnectionErrorReceivedImplCopyWith(
          _$ConnectionErrorReceivedImpl value,
          $Res Function(_$ConnectionErrorReceivedImpl) then) =
      __$$ConnectionErrorReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ConnectionErrorReceivedImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionErrorReceivedImpl>
    implements _$$ConnectionErrorReceivedImplCopyWith<$Res> {
  __$$ConnectionErrorReceivedImplCopyWithImpl(
      _$ConnectionErrorReceivedImpl _value,
      $Res Function(_$ConnectionErrorReceivedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ConnectionErrorReceivedImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectionErrorReceivedImpl implements ConnectionErrorReceived {
  const _$ConnectionErrorReceivedImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ConnectionEvent.errorReceived(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionErrorReceivedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionErrorReceivedImplCopyWith<_$ConnectionErrorReceivedImpl>
      get copyWith => __$$ConnectionErrorReceivedImplCopyWithImpl<
          _$ConnectionErrorReceivedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) {
    return errorReceived(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) {
    return errorReceived?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) {
    if (errorReceived != null) {
      return errorReceived(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) {
    return errorReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) {
    return errorReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) {
    if (errorReceived != null) {
      return errorReceived(this);
    }
    return orElse();
  }
}

abstract class ConnectionErrorReceived implements ConnectionEvent {
  const factory ConnectionErrorReceived({required final String message}) =
      _$ConnectionErrorReceivedImpl;

  String get message;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionErrorReceivedImplCopyWith<_$ConnectionErrorReceivedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionPeerJoinedImplCopyWith<$Res> {
  factory _$$ConnectionPeerJoinedImplCopyWith(_$ConnectionPeerJoinedImpl value,
          $Res Function(_$ConnectionPeerJoinedImpl) then) =
      __$$ConnectionPeerJoinedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$ConnectionPeerJoinedImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionPeerJoinedImpl>
    implements _$$ConnectionPeerJoinedImplCopyWith<$Res> {
  __$$ConnectionPeerJoinedImplCopyWithImpl(_$ConnectionPeerJoinedImpl _value,
      $Res Function(_$ConnectionPeerJoinedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$ConnectionPeerJoinedImpl(
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

class _$ConnectionPeerJoinedImpl implements ConnectionPeerJoined {
  const _$ConnectionPeerJoinedImpl({required this.id, required this.name});

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'ConnectionEvent.peerJoined(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionPeerJoinedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionPeerJoinedImplCopyWith<_$ConnectionPeerJoinedImpl>
      get copyWith =>
          __$$ConnectionPeerJoinedImplCopyWithImpl<_$ConnectionPeerJoinedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) {
    return peerJoined(id, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) {
    return peerJoined?.call(id, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) {
    if (peerJoined != null) {
      return peerJoined(id, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) {
    return peerJoined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) {
    return peerJoined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) {
    if (peerJoined != null) {
      return peerJoined(this);
    }
    return orElse();
  }
}

abstract class ConnectionPeerJoined implements ConnectionEvent {
  const factory ConnectionPeerJoined(
      {required final int id,
      required final String name}) = _$ConnectionPeerJoinedImpl;

  int get id;
  String get name;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionPeerJoinedImplCopyWith<_$ConnectionPeerJoinedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionPeerLeftImplCopyWith<$Res> {
  factory _$$ConnectionPeerLeftImplCopyWith(_$ConnectionPeerLeftImpl value,
          $Res Function(_$ConnectionPeerLeftImpl) then) =
      __$$ConnectionPeerLeftImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$ConnectionPeerLeftImplCopyWithImpl<$Res>
    extends _$ConnectionEventCopyWithImpl<$Res, _$ConnectionPeerLeftImpl>
    implements _$$ConnectionPeerLeftImplCopyWith<$Res> {
  __$$ConnectionPeerLeftImplCopyWithImpl(_$ConnectionPeerLeftImpl _value,
      $Res Function(_$ConnectionPeerLeftImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$ConnectionPeerLeftImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ConnectionPeerLeftImpl implements ConnectionPeerLeft {
  const _$ConnectionPeerLeftImpl({required this.id});

  @override
  final int id;

  @override
  String toString() {
    return 'ConnectionEvent.peerLeft(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionPeerLeftImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionPeerLeftImplCopyWith<_$ConnectionPeerLeftImpl> get copyWith =>
      __$$ConnectionPeerLeftImplCopyWithImpl<_$ConnectionPeerLeftImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String hubHost, int hubPort, String username)
        connect,
    required TResult Function() listRooms,
    required TResult Function(String code, String username) joinRoom,
    required TResult Function(String username) createRoom,
    required TResult Function() disconnect,
    required TResult Function(List<RoomInfo> rooms) roomListReceived,
    required TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)
        welcomeReceived,
    required TResult Function(String message) errorReceived,
    required TResult Function(int id, String name) peerJoined,
    required TResult Function(int id) peerLeft,
  }) {
    return peerLeft(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String hubHost, int hubPort, String username)? connect,
    TResult? Function()? listRooms,
    TResult? Function(String code, String username)? joinRoom,
    TResult? Function(String username)? createRoom,
    TResult? Function()? disconnect,
    TResult? Function(List<RoomInfo> rooms)? roomListReceived,
    TResult? Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult? Function(String message)? errorReceived,
    TResult? Function(int id, String name)? peerJoined,
    TResult? Function(int id)? peerLeft,
  }) {
    return peerLeft?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String hubHost, int hubPort, String username)? connect,
    TResult Function()? listRooms,
    TResult Function(String code, String username)? joinRoom,
    TResult Function(String username)? createRoom,
    TResult Function()? disconnect,
    TResult Function(List<RoomInfo> rooms)? roomListReceived,
    TResult Function(
            int selfId, String roomCode, List<({int id, String name})> peers)?
        welcomeReceived,
    TResult Function(String message)? errorReceived,
    TResult Function(int id, String name)? peerJoined,
    TResult Function(int id)? peerLeft,
    required TResult orElse(),
  }) {
    if (peerLeft != null) {
      return peerLeft(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionConnect value) connect,
    required TResult Function(ConnectionListRooms value) listRooms,
    required TResult Function(ConnectionJoinRoom value) joinRoom,
    required TResult Function(ConnectionCreateRoom value) createRoom,
    required TResult Function(ConnectionDisconnect value) disconnect,
    required TResult Function(ConnectionRoomListReceived value)
        roomListReceived,
    required TResult Function(ConnectionWelcomeReceived value) welcomeReceived,
    required TResult Function(ConnectionErrorReceived value) errorReceived,
    required TResult Function(ConnectionPeerJoined value) peerJoined,
    required TResult Function(ConnectionPeerLeft value) peerLeft,
  }) {
    return peerLeft(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionConnect value)? connect,
    TResult? Function(ConnectionListRooms value)? listRooms,
    TResult? Function(ConnectionJoinRoom value)? joinRoom,
    TResult? Function(ConnectionCreateRoom value)? createRoom,
    TResult? Function(ConnectionDisconnect value)? disconnect,
    TResult? Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult? Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult? Function(ConnectionErrorReceived value)? errorReceived,
    TResult? Function(ConnectionPeerJoined value)? peerJoined,
    TResult? Function(ConnectionPeerLeft value)? peerLeft,
  }) {
    return peerLeft?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionConnect value)? connect,
    TResult Function(ConnectionListRooms value)? listRooms,
    TResult Function(ConnectionJoinRoom value)? joinRoom,
    TResult Function(ConnectionCreateRoom value)? createRoom,
    TResult Function(ConnectionDisconnect value)? disconnect,
    TResult Function(ConnectionRoomListReceived value)? roomListReceived,
    TResult Function(ConnectionWelcomeReceived value)? welcomeReceived,
    TResult Function(ConnectionErrorReceived value)? errorReceived,
    TResult Function(ConnectionPeerJoined value)? peerJoined,
    TResult Function(ConnectionPeerLeft value)? peerLeft,
    required TResult orElse(),
  }) {
    if (peerLeft != null) {
      return peerLeft(this);
    }
    return orElse();
  }
}

abstract class ConnectionPeerLeft implements ConnectionEvent {
  const factory ConnectionPeerLeft({required final int id}) =
      _$ConnectionPeerLeftImpl;

  int get id;

  /// Create a copy of ConnectionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionPeerLeftImplCopyWith<_$ConnectionPeerLeftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ConnectionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String hubHost, int hubPort, String username)
        connecting,
    required TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)
        selectingRoom,
    required TResult Function(
            String hubHost, int hubPort, String username, String roomCode)
        joining,
    required TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)
        inSession,
    required TResult Function(String message) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String hubHost, int hubPort, String username)? connecting,
    TResult? Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult? Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult? Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult? Function(String message)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String hubHost, int hubPort, String username)? connecting,
    TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionIdle value) idle,
    required TResult Function(ConnectionConnecting value) connecting,
    required TResult Function(ConnectionSelectingRoom value) selectingRoom,
    required TResult Function(ConnectionJoining value) joining,
    required TResult Function(ConnectionInSession value) inSession,
    required TResult Function(ConnectionFailed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionIdle value)? idle,
    TResult? Function(ConnectionConnecting value)? connecting,
    TResult? Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult? Function(ConnectionJoining value)? joining,
    TResult? Function(ConnectionInSession value)? inSession,
    TResult? Function(ConnectionFailed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionIdle value)? idle,
    TResult Function(ConnectionConnecting value)? connecting,
    TResult Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult Function(ConnectionJoining value)? joining,
    TResult Function(ConnectionInSession value)? inSession,
    TResult Function(ConnectionFailed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionStateCopyWith<$Res> {
  factory $ConnectionStateCopyWith(
          ConnectionState value, $Res Function(ConnectionState) then) =
      _$ConnectionStateCopyWithImpl<$Res, ConnectionState>;
}

/// @nodoc
class _$ConnectionStateCopyWithImpl<$Res, $Val extends ConnectionState>
    implements $ConnectionStateCopyWith<$Res> {
  _$ConnectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConnectionIdleImplCopyWith<$Res> {
  factory _$$ConnectionIdleImplCopyWith(_$ConnectionIdleImpl value,
          $Res Function(_$ConnectionIdleImpl) then) =
      __$$ConnectionIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionIdleImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectionIdleImpl>
    implements _$$ConnectionIdleImplCopyWith<$Res> {
  __$$ConnectionIdleImplCopyWithImpl(
      _$ConnectionIdleImpl _value, $Res Function(_$ConnectionIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectionIdleImpl implements ConnectionIdle {
  const _$ConnectionIdleImpl();

  @override
  String toString() {
    return 'ConnectionState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectionIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String hubHost, int hubPort, String username)
        connecting,
    required TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)
        selectingRoom,
    required TResult Function(
            String hubHost, int hubPort, String username, String roomCode)
        joining,
    required TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)
        inSession,
    required TResult Function(String message) failed,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String hubHost, int hubPort, String username)? connecting,
    TResult? Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult? Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult? Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult? Function(String message)? failed,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String hubHost, int hubPort, String username)? connecting,
    TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult Function(String message)? failed,
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
    required TResult Function(ConnectionIdle value) idle,
    required TResult Function(ConnectionConnecting value) connecting,
    required TResult Function(ConnectionSelectingRoom value) selectingRoom,
    required TResult Function(ConnectionJoining value) joining,
    required TResult Function(ConnectionInSession value) inSession,
    required TResult Function(ConnectionFailed value) failed,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionIdle value)? idle,
    TResult? Function(ConnectionConnecting value)? connecting,
    TResult? Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult? Function(ConnectionJoining value)? joining,
    TResult? Function(ConnectionInSession value)? inSession,
    TResult? Function(ConnectionFailed value)? failed,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionIdle value)? idle,
    TResult Function(ConnectionConnecting value)? connecting,
    TResult Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult Function(ConnectionJoining value)? joining,
    TResult Function(ConnectionInSession value)? inSession,
    TResult Function(ConnectionFailed value)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class ConnectionIdle implements ConnectionState {
  const factory ConnectionIdle() = _$ConnectionIdleImpl;
}

/// @nodoc
abstract class _$$ConnectionConnectingImplCopyWith<$Res> {
  factory _$$ConnectionConnectingImplCopyWith(_$ConnectionConnectingImpl value,
          $Res Function(_$ConnectionConnectingImpl) then) =
      __$$ConnectionConnectingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String hubHost, int hubPort, String username});
}

/// @nodoc
class __$$ConnectionConnectingImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectionConnectingImpl>
    implements _$$ConnectionConnectingImplCopyWith<$Res> {
  __$$ConnectionConnectingImplCopyWithImpl(_$ConnectionConnectingImpl _value,
      $Res Function(_$ConnectionConnectingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hubHost = null,
    Object? hubPort = null,
    Object? username = null,
  }) {
    return _then(_$ConnectionConnectingImpl(
      hubHost: null == hubHost
          ? _value.hubHost
          : hubHost // ignore: cast_nullable_to_non_nullable
              as String,
      hubPort: null == hubPort
          ? _value.hubPort
          : hubPort // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectionConnectingImpl implements ConnectionConnecting {
  const _$ConnectionConnectingImpl(
      {required this.hubHost, required this.hubPort, required this.username});

  @override
  final String hubHost;
  @override
  final int hubPort;
  @override
  final String username;

  @override
  String toString() {
    return 'ConnectionState.connecting(hubHost: $hubHost, hubPort: $hubPort, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionConnectingImpl &&
            (identical(other.hubHost, hubHost) || other.hubHost == hubHost) &&
            (identical(other.hubPort, hubPort) || other.hubPort == hubPort) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hubHost, hubPort, username);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionConnectingImplCopyWith<_$ConnectionConnectingImpl>
      get copyWith =>
          __$$ConnectionConnectingImplCopyWithImpl<_$ConnectionConnectingImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String hubHost, int hubPort, String username)
        connecting,
    required TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)
        selectingRoom,
    required TResult Function(
            String hubHost, int hubPort, String username, String roomCode)
        joining,
    required TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)
        inSession,
    required TResult Function(String message) failed,
  }) {
    return connecting(hubHost, hubPort, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String hubHost, int hubPort, String username)? connecting,
    TResult? Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult? Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult? Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult? Function(String message)? failed,
  }) {
    return connecting?.call(hubHost, hubPort, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String hubHost, int hubPort, String username)? connecting,
    TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting(hubHost, hubPort, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionIdle value) idle,
    required TResult Function(ConnectionConnecting value) connecting,
    required TResult Function(ConnectionSelectingRoom value) selectingRoom,
    required TResult Function(ConnectionJoining value) joining,
    required TResult Function(ConnectionInSession value) inSession,
    required TResult Function(ConnectionFailed value) failed,
  }) {
    return connecting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionIdle value)? idle,
    TResult? Function(ConnectionConnecting value)? connecting,
    TResult? Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult? Function(ConnectionJoining value)? joining,
    TResult? Function(ConnectionInSession value)? inSession,
    TResult? Function(ConnectionFailed value)? failed,
  }) {
    return connecting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionIdle value)? idle,
    TResult Function(ConnectionConnecting value)? connecting,
    TResult Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult Function(ConnectionJoining value)? joining,
    TResult Function(ConnectionInSession value)? inSession,
    TResult Function(ConnectionFailed value)? failed,
    required TResult orElse(),
  }) {
    if (connecting != null) {
      return connecting(this);
    }
    return orElse();
  }
}

abstract class ConnectionConnecting implements ConnectionState {
  const factory ConnectionConnecting(
      {required final String hubHost,
      required final int hubPort,
      required final String username}) = _$ConnectionConnectingImpl;

  String get hubHost;
  int get hubPort;
  String get username;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionConnectingImplCopyWith<_$ConnectionConnectingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionSelectingRoomImplCopyWith<$Res> {
  factory _$$ConnectionSelectingRoomImplCopyWith(
          _$ConnectionSelectingRoomImpl value,
          $Res Function(_$ConnectionSelectingRoomImpl) then) =
      __$$ConnectionSelectingRoomImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String hubHost, int hubPort, String username, List<RoomInfo> rooms});
}

/// @nodoc
class __$$ConnectionSelectingRoomImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectionSelectingRoomImpl>
    implements _$$ConnectionSelectingRoomImplCopyWith<$Res> {
  __$$ConnectionSelectingRoomImplCopyWithImpl(
      _$ConnectionSelectingRoomImpl _value,
      $Res Function(_$ConnectionSelectingRoomImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hubHost = null,
    Object? hubPort = null,
    Object? username = null,
    Object? rooms = null,
  }) {
    return _then(_$ConnectionSelectingRoomImpl(
      hubHost: null == hubHost
          ? _value.hubHost
          : hubHost // ignore: cast_nullable_to_non_nullable
              as String,
      hubPort: null == hubPort
          ? _value.hubPort
          : hubPort // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      rooms: null == rooms
          ? _value._rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<RoomInfo>,
    ));
  }
}

/// @nodoc

class _$ConnectionSelectingRoomImpl implements ConnectionSelectingRoom {
  const _$ConnectionSelectingRoomImpl(
      {required this.hubHost,
      required this.hubPort,
      required this.username,
      required final List<RoomInfo> rooms})
      : _rooms = rooms;

  @override
  final String hubHost;
  @override
  final int hubPort;
  @override
  final String username;
  final List<RoomInfo> _rooms;
  @override
  List<RoomInfo> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString() {
    return 'ConnectionState.selectingRoom(hubHost: $hubHost, hubPort: $hubPort, username: $username, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionSelectingRoomImpl &&
            (identical(other.hubHost, hubHost) || other.hubHost == hubHost) &&
            (identical(other.hubPort, hubPort) || other.hubPort == hubPort) &&
            (identical(other.username, username) ||
                other.username == username) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hubHost, hubPort, username,
      const DeepCollectionEquality().hash(_rooms));

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionSelectingRoomImplCopyWith<_$ConnectionSelectingRoomImpl>
      get copyWith => __$$ConnectionSelectingRoomImplCopyWithImpl<
          _$ConnectionSelectingRoomImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String hubHost, int hubPort, String username)
        connecting,
    required TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)
        selectingRoom,
    required TResult Function(
            String hubHost, int hubPort, String username, String roomCode)
        joining,
    required TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)
        inSession,
    required TResult Function(String message) failed,
  }) {
    return selectingRoom(hubHost, hubPort, username, rooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String hubHost, int hubPort, String username)? connecting,
    TResult? Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult? Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult? Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult? Function(String message)? failed,
  }) {
    return selectingRoom?.call(hubHost, hubPort, username, rooms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String hubHost, int hubPort, String username)? connecting,
    TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (selectingRoom != null) {
      return selectingRoom(hubHost, hubPort, username, rooms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionIdle value) idle,
    required TResult Function(ConnectionConnecting value) connecting,
    required TResult Function(ConnectionSelectingRoom value) selectingRoom,
    required TResult Function(ConnectionJoining value) joining,
    required TResult Function(ConnectionInSession value) inSession,
    required TResult Function(ConnectionFailed value) failed,
  }) {
    return selectingRoom(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionIdle value)? idle,
    TResult? Function(ConnectionConnecting value)? connecting,
    TResult? Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult? Function(ConnectionJoining value)? joining,
    TResult? Function(ConnectionInSession value)? inSession,
    TResult? Function(ConnectionFailed value)? failed,
  }) {
    return selectingRoom?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionIdle value)? idle,
    TResult Function(ConnectionConnecting value)? connecting,
    TResult Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult Function(ConnectionJoining value)? joining,
    TResult Function(ConnectionInSession value)? inSession,
    TResult Function(ConnectionFailed value)? failed,
    required TResult orElse(),
  }) {
    if (selectingRoom != null) {
      return selectingRoom(this);
    }
    return orElse();
  }
}

abstract class ConnectionSelectingRoom implements ConnectionState {
  const factory ConnectionSelectingRoom(
      {required final String hubHost,
      required final int hubPort,
      required final String username,
      required final List<RoomInfo> rooms}) = _$ConnectionSelectingRoomImpl;

  String get hubHost;
  int get hubPort;
  String get username;
  List<RoomInfo> get rooms;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionSelectingRoomImplCopyWith<_$ConnectionSelectingRoomImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionJoiningImplCopyWith<$Res> {
  factory _$$ConnectionJoiningImplCopyWith(_$ConnectionJoiningImpl value,
          $Res Function(_$ConnectionJoiningImpl) then) =
      __$$ConnectionJoiningImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String hubHost, int hubPort, String username, String roomCode});
}

/// @nodoc
class __$$ConnectionJoiningImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectionJoiningImpl>
    implements _$$ConnectionJoiningImplCopyWith<$Res> {
  __$$ConnectionJoiningImplCopyWithImpl(_$ConnectionJoiningImpl _value,
      $Res Function(_$ConnectionJoiningImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hubHost = null,
    Object? hubPort = null,
    Object? username = null,
    Object? roomCode = null,
  }) {
    return _then(_$ConnectionJoiningImpl(
      hubHost: null == hubHost
          ? _value.hubHost
          : hubHost // ignore: cast_nullable_to_non_nullable
              as String,
      hubPort: null == hubPort
          ? _value.hubPort
          : hubPort // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectionJoiningImpl implements ConnectionJoining {
  const _$ConnectionJoiningImpl(
      {required this.hubHost,
      required this.hubPort,
      required this.username,
      required this.roomCode});

  @override
  final String hubHost;
  @override
  final int hubPort;
  @override
  final String username;
  @override
  final String roomCode;

  @override
  String toString() {
    return 'ConnectionState.joining(hubHost: $hubHost, hubPort: $hubPort, username: $username, roomCode: $roomCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionJoiningImpl &&
            (identical(other.hubHost, hubHost) || other.hubHost == hubHost) &&
            (identical(other.hubPort, hubPort) || other.hubPort == hubPort) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, hubHost, hubPort, username, roomCode);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionJoiningImplCopyWith<_$ConnectionJoiningImpl> get copyWith =>
      __$$ConnectionJoiningImplCopyWithImpl<_$ConnectionJoiningImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String hubHost, int hubPort, String username)
        connecting,
    required TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)
        selectingRoom,
    required TResult Function(
            String hubHost, int hubPort, String username, String roomCode)
        joining,
    required TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)
        inSession,
    required TResult Function(String message) failed,
  }) {
    return joining(hubHost, hubPort, username, roomCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String hubHost, int hubPort, String username)? connecting,
    TResult? Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult? Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult? Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult? Function(String message)? failed,
  }) {
    return joining?.call(hubHost, hubPort, username, roomCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String hubHost, int hubPort, String username)? connecting,
    TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (joining != null) {
      return joining(hubHost, hubPort, username, roomCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionIdle value) idle,
    required TResult Function(ConnectionConnecting value) connecting,
    required TResult Function(ConnectionSelectingRoom value) selectingRoom,
    required TResult Function(ConnectionJoining value) joining,
    required TResult Function(ConnectionInSession value) inSession,
    required TResult Function(ConnectionFailed value) failed,
  }) {
    return joining(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionIdle value)? idle,
    TResult? Function(ConnectionConnecting value)? connecting,
    TResult? Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult? Function(ConnectionJoining value)? joining,
    TResult? Function(ConnectionInSession value)? inSession,
    TResult? Function(ConnectionFailed value)? failed,
  }) {
    return joining?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionIdle value)? idle,
    TResult Function(ConnectionConnecting value)? connecting,
    TResult Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult Function(ConnectionJoining value)? joining,
    TResult Function(ConnectionInSession value)? inSession,
    TResult Function(ConnectionFailed value)? failed,
    required TResult orElse(),
  }) {
    if (joining != null) {
      return joining(this);
    }
    return orElse();
  }
}

abstract class ConnectionJoining implements ConnectionState {
  const factory ConnectionJoining(
      {required final String hubHost,
      required final int hubPort,
      required final String username,
      required final String roomCode}) = _$ConnectionJoiningImpl;

  String get hubHost;
  int get hubPort;
  String get username;
  String get roomCode;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionJoiningImplCopyWith<_$ConnectionJoiningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionInSessionImplCopyWith<$Res> {
  factory _$$ConnectionInSessionImplCopyWith(_$ConnectionInSessionImpl value,
          $Res Function(_$ConnectionInSessionImpl) then) =
      __$$ConnectionInSessionImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int selfId,
      String roomCode,
      String username,
      String hubHost,
      int hubPort,
      List<({int id, String name})> existingPeers});
}

/// @nodoc
class __$$ConnectionInSessionImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectionInSessionImpl>
    implements _$$ConnectionInSessionImplCopyWith<$Res> {
  __$$ConnectionInSessionImplCopyWithImpl(_$ConnectionInSessionImpl _value,
      $Res Function(_$ConnectionInSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selfId = null,
    Object? roomCode = null,
    Object? username = null,
    Object? hubHost = null,
    Object? hubPort = null,
    Object? existingPeers = null,
  }) {
    return _then(_$ConnectionInSessionImpl(
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
      hubHost: null == hubHost
          ? _value.hubHost
          : hubHost // ignore: cast_nullable_to_non_nullable
              as String,
      hubPort: null == hubPort
          ? _value.hubPort
          : hubPort // ignore: cast_nullable_to_non_nullable
              as int,
      existingPeers: null == existingPeers
          ? _value._existingPeers
          : existingPeers // ignore: cast_nullable_to_non_nullable
              as List<({int id, String name})>,
    ));
  }
}

/// @nodoc

class _$ConnectionInSessionImpl implements ConnectionInSession {
  const _$ConnectionInSessionImpl(
      {required this.selfId,
      required this.roomCode,
      required this.username,
      required this.hubHost,
      required this.hubPort,
      final List<({int id, String name})> existingPeers = const []})
      : _existingPeers = existingPeers;

  @override
  final int selfId;
  @override
  final String roomCode;
  @override
  final String username;
  @override
  final String hubHost;
  @override
  final int hubPort;

  /// Peers that were already in the room at join time (from the WELCOME packet).
  final List<({int id, String name})> _existingPeers;

  /// Peers that were already in the room at join time (from the WELCOME packet).
  @override
  @JsonKey()
  List<({int id, String name})> get existingPeers {
    if (_existingPeers is EqualUnmodifiableListView) return _existingPeers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_existingPeers);
  }

  @override
  String toString() {
    return 'ConnectionState.inSession(selfId: $selfId, roomCode: $roomCode, username: $username, hubHost: $hubHost, hubPort: $hubPort, existingPeers: $existingPeers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionInSessionImpl &&
            (identical(other.selfId, selfId) || other.selfId == selfId) &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.hubHost, hubHost) || other.hubHost == hubHost) &&
            (identical(other.hubPort, hubPort) || other.hubPort == hubPort) &&
            const DeepCollectionEquality()
                .equals(other._existingPeers, _existingPeers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selfId, roomCode, username,
      hubHost, hubPort, const DeepCollectionEquality().hash(_existingPeers));

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionInSessionImplCopyWith<_$ConnectionInSessionImpl> get copyWith =>
      __$$ConnectionInSessionImplCopyWithImpl<_$ConnectionInSessionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String hubHost, int hubPort, String username)
        connecting,
    required TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)
        selectingRoom,
    required TResult Function(
            String hubHost, int hubPort, String username, String roomCode)
        joining,
    required TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)
        inSession,
    required TResult Function(String message) failed,
  }) {
    return inSession(
        selfId, roomCode, username, hubHost, hubPort, existingPeers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String hubHost, int hubPort, String username)? connecting,
    TResult? Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult? Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult? Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult? Function(String message)? failed,
  }) {
    return inSession?.call(
        selfId, roomCode, username, hubHost, hubPort, existingPeers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String hubHost, int hubPort, String username)? connecting,
    TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult Function(String message)? failed,
    required TResult orElse(),
  }) {
    if (inSession != null) {
      return inSession(
          selfId, roomCode, username, hubHost, hubPort, existingPeers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectionIdle value) idle,
    required TResult Function(ConnectionConnecting value) connecting,
    required TResult Function(ConnectionSelectingRoom value) selectingRoom,
    required TResult Function(ConnectionJoining value) joining,
    required TResult Function(ConnectionInSession value) inSession,
    required TResult Function(ConnectionFailed value) failed,
  }) {
    return inSession(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionIdle value)? idle,
    TResult? Function(ConnectionConnecting value)? connecting,
    TResult? Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult? Function(ConnectionJoining value)? joining,
    TResult? Function(ConnectionInSession value)? inSession,
    TResult? Function(ConnectionFailed value)? failed,
  }) {
    return inSession?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionIdle value)? idle,
    TResult Function(ConnectionConnecting value)? connecting,
    TResult Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult Function(ConnectionJoining value)? joining,
    TResult Function(ConnectionInSession value)? inSession,
    TResult Function(ConnectionFailed value)? failed,
    required TResult orElse(),
  }) {
    if (inSession != null) {
      return inSession(this);
    }
    return orElse();
  }
}

abstract class ConnectionInSession implements ConnectionState {
  const factory ConnectionInSession(
          {required final int selfId,
          required final String roomCode,
          required final String username,
          required final String hubHost,
          required final int hubPort,
          final List<({int id, String name})> existingPeers}) =
      _$ConnectionInSessionImpl;

  int get selfId;
  String get roomCode;
  String get username;
  String get hubHost;
  int get hubPort;

  /// Peers that were already in the room at join time (from the WELCOME packet).
  List<({int id, String name})> get existingPeers;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionInSessionImplCopyWith<_$ConnectionInSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionFailedImplCopyWith<$Res> {
  factory _$$ConnectionFailedImplCopyWith(_$ConnectionFailedImpl value,
          $Res Function(_$ConnectionFailedImpl) then) =
      __$$ConnectionFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ConnectionFailedImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectionFailedImpl>
    implements _$$ConnectionFailedImplCopyWith<$Res> {
  __$$ConnectionFailedImplCopyWithImpl(_$ConnectionFailedImpl _value,
      $Res Function(_$ConnectionFailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ConnectionFailedImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConnectionFailedImpl implements ConnectionFailed {
  const _$ConnectionFailedImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ConnectionState.failed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionFailedImplCopyWith<_$ConnectionFailedImpl> get copyWith =>
      __$$ConnectionFailedImplCopyWithImpl<_$ConnectionFailedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String hubHost, int hubPort, String username)
        connecting,
    required TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)
        selectingRoom,
    required TResult Function(
            String hubHost, int hubPort, String username, String roomCode)
        joining,
    required TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)
        inSession,
    required TResult Function(String message) failed,
  }) {
    return failed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String hubHost, int hubPort, String username)? connecting,
    TResult? Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult? Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult? Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
    TResult? Function(String message)? failed,
  }) {
    return failed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String hubHost, int hubPort, String username)? connecting,
    TResult Function(
            String hubHost, int hubPort, String username, List<RoomInfo> rooms)?
        selectingRoom,
    TResult Function(
            String hubHost, int hubPort, String username, String roomCode)?
        joining,
    TResult Function(
            int selfId,
            String roomCode,
            String username,
            String hubHost,
            int hubPort,
            List<({int id, String name})> existingPeers)?
        inSession,
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
    required TResult Function(ConnectionIdle value) idle,
    required TResult Function(ConnectionConnecting value) connecting,
    required TResult Function(ConnectionSelectingRoom value) selectingRoom,
    required TResult Function(ConnectionJoining value) joining,
    required TResult Function(ConnectionInSession value) inSession,
    required TResult Function(ConnectionFailed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectionIdle value)? idle,
    TResult? Function(ConnectionConnecting value)? connecting,
    TResult? Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult? Function(ConnectionJoining value)? joining,
    TResult? Function(ConnectionInSession value)? inSession,
    TResult? Function(ConnectionFailed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectionIdle value)? idle,
    TResult Function(ConnectionConnecting value)? connecting,
    TResult Function(ConnectionSelectingRoom value)? selectingRoom,
    TResult Function(ConnectionJoining value)? joining,
    TResult Function(ConnectionInSession value)? inSession,
    TResult Function(ConnectionFailed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class ConnectionFailed implements ConnectionState {
  const factory ConnectionFailed({required final String message}) =
      _$ConnectionFailedImpl;

  String get message;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionFailedImplCopyWith<_$ConnectionFailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
