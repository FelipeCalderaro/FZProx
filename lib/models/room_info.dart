import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_info.freezed.dart';

@freezed
class RoomInfo with _$RoomInfo {
  const factory RoomInfo({
    required String code,
    required int    playerCount,
  }) = _RoomInfo;
}
