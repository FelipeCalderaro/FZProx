import 'dart:math';
import 'dart:typed_data';

const double _vSound = 343.0; // m/s

/// Returns the Doppler frequency factor for a peer approaching or receding.
/// Returns 1.0 for negligible effects (still / too close).
double computeDopplerFactor({
  required double selfX,
  required double selfZ,
  required double peerX,
  required double peerZ,
  required double peerYaw,
  required double peerSpeed,
}) {
  final dx   = selfX - peerX;
  final dz   = selfZ - peerZ;
  final dist = sqrt(dx * dx + dz * dz);

  if (dist < 1.0 || peerSpeed < 0.5) return 1.0;

  // Unit vector from peer toward self
  final nx = dx / dist;
  final nz = dz / dist;

  // Peer velocity in world space: sin(yaw)=X, cos(yaw)=Z
  final vx = peerSpeed * sin(peerYaw);
  final vz = peerSpeed * cos(peerYaw);

  var vToward = vx * nx + vz * nz;
  var denom   = _vSound - vToward;
  if (denom.abs() < 10.0) denom = denom.isNegative ? -10.0 : 10.0;

  return (_vSound / denom).clamp(0.7, 1.5);
}

/// Pitch-shifts [frame] (960 int16 mono samples) by [factor] via linear interp.
/// factor > 1 → higher pitch (approaching); factor < 1 → lower (receding).
/// Returns the original frame unchanged if the shift is negligible.
Int16List applyDoppler(Int16List frame, double factor) {
  if ((factor - 1.0).abs() < 0.004) return frame;

  final n   = frame.length;
  final out = Int16List(n);

  for (var i = 0; i < n; i++) {
    final pos = (i * factor).clamp(0.0, n - 1.0);
    final lo  = pos.floor();
    final hi  = (lo + 1).clamp(0, n - 1);
    final t   = pos - lo;
    out[i]    = (frame[lo] * (1.0 - t) + frame[hi] * t).round().clamp(-32768, 32767);
  }
  return out;
}
