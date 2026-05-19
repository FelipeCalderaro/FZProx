import 'package:freezed_annotation/freezed_annotation.dart';

part 'car_state.freezed.dart';

@freezed
class CarState with _$CarState {
  const factory CarState({
    @Default(0.0) double x,
    @Default(0.0) double y,
    @Default(0.0) double z,
    @Default(0.0) double yaw,
    @Default(0.0) double pitch,
    @Default(0.0) double roll,
    @Default(0.0) double speed,
    @Default(false) bool isRaceOn,
    @Default(0) int timestampMs,
  }) = _CarState;
}
