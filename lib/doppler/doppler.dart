import 'dart:math';
import 'dart:typed_data';

const double _vSound = 343.0; // m/s

/// Returns the Doppler frequency factor for a peer approaching or receding.
///
/// Uses the full two-body Doppler formula:
///   f' = f * (v_sound + v_observer) / (v_sound - v_source)
///
/// Both the observer (self) and source (peer) radial velocity components are
/// projected onto the peer→self axis.  [selfYaw] and [selfSpeed] are optional
/// so existing call-sites that only supply peer motion still compile.
///
/// Returns 1.0 when the net effect is negligible.
double computeDopplerFactor({
  required double selfX,
  required double selfZ,
  required double peerX,
  required double peerZ,
  required double peerYaw,
  required double peerSpeed,
  double selfYaw   = 0.0,
  double selfSpeed = 0.0,
}) {
  final dx   = selfX - peerX;
  final dz   = selfZ - peerZ;
  final dist = sqrt(dx * dx + dz * dz);

  if (dist < 1.0) return 1.0;

  // Unit vector from peer toward self (direction audio propagates)
  final nx = dx / dist;
  final nz = dz / dist;

  // Peer (source) velocity component toward listener — positive = approaching
  double vSource = 0.0;
  if (peerSpeed >= 0.5) {
    final vx = peerSpeed * sin(peerYaw);
    final vz = peerSpeed * cos(peerYaw);
    vSource = vx * nx + vz * nz;
  }

  // Observer (self) velocity component toward source — positive = moving toward peer
  double vObserver = 0.0;
  if (selfSpeed >= 0.5) {
    final vx = selfSpeed * sin(selfYaw);
    final vz = selfSpeed * cos(selfYaw);
    // Project self velocity onto the peer→self direction, then negate
    // (positive vObserver means self is moving toward peer)
    vObserver = -(vx * nx + vz * nz);
  }

  var denom = _vSound - vSource;
  if (denom.abs() < 10.0) denom = denom.isNegative ? -10.0 : 10.0;

  return ((_vSound + vObserver) / denom).clamp(0.5, 2.0);
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
