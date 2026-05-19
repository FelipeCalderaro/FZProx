import 'package:freezed_annotation/freezed_annotation.dart';

part 'proximity_params.freezed.dart';

@freezed
class ProximityParams with _$ProximityParams {
  const factory ProximityParams({
    @Default(10.0) double near,   // full-volume radius in metres
    @Default(80.0) double far,    // silence radius in metres
    @Default(2.0)  double curve,  // exponent (2.0 = inverse-square)
    @Default(true) bool   panning,
  }) = _ProximityParams;
}
