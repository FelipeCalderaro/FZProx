import 'package:freezed_annotation/freezed_annotation.dart';

part 'peer_model.freezed.dart';

@freezed
class PeerModel with _$PeerModel {
  const factory PeerModel({
    required int    id,
    required String name,
    // Position (world space, XZ plane)
    @Default(0.0) double x,
    @Default(0.0) double z,
    @Default(0.0) double yaw,
    @Default(0.0) double speed,
    // Computed proximity values (updated by gain loop)
    @Default(0.0) double distanceM,
    @Default(0.0) double gainL,
    @Default(0.0) double gainR,
    @Default(0.0) double rawGain,      // proximity gain before stereo split (0..1)
    @Default(0.0) double pan,          // -1..+1
    @Default(1.0) double dopplerFactor,
    @Default(0)   int    bufferMs,
    // Manual mute — silences this peer regardless of proximity
    @Default(false) bool muted,
    // Per-peer volume multiplier (0.0 = silent, 1.0 = normal, 2.0 = double, etc.)
    @Default(1.0) double volumeMultiplier,
  }) = _PeerModel;
}
