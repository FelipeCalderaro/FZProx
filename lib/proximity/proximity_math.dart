import 'dart:math';

// ── Pure functions ────────────────────────────────────────────────────────────

/// Euclidean distance on the XZ plane (Y ignored).
double xzDistance(double x1, double z1, double x2, double z2) =>
    sqrt(pow(x1 - x2, 2) + pow(z1 - z2, 2));

/// Piecewise power-curve volume attenuation.
/// near ≤ d → 1.0 | near < d < far → ((far-d)/(far-near))^curve | d ≥ far → 0.0
double gainForDistance(double d, double near, double far, double curve) {
  if (d <= near) return 1.0;
  if (d >= far)  return 0.0;
  return pow((far - d) / (far - near), curve).toDouble();
}

/// Stereo pan value [-1, +1] from the bearing of [peer] relative to [self].
/// bearing = atan2(dx, dz) - selfYaw  →  sin(bearing) gives left/right.
double panForBearing(double dx, double dz, double selfYaw) {
  final bearing = atan2(dx, dz) - selfYaw;
  return sin(bearing).clamp(-1.0, 1.0);
}

/// Equal-power stereo split:
///   p = (pan + 1) * π / 4
///   gainL = gain * cos(p),  gainR = gain * sin(p)
(double gainL, double gainR) stereoGains(double gain, double pan) {
  final p = (pan + 1.0) * pi / 4.0;
  return (gain * cos(p), gain * sin(p));
}

// ── EMA smoother (per-peer state) ────────────────────────────────────────────

const double _alphaGain = 0.3;
const double _alphaPan  = 0.15;

class _PeerSmooth {
  double gain;
  double pan;
  bool   initialised;

  _PeerSmooth()
      : gain         = 0.0,
        pan          = 0.0,
        initialised  = false;

  ({double gain, double pan}) update(double rawGain, double rawPan) {
    if (!initialised) {
      gain        = rawGain;
      pan         = rawPan;
      initialised = true;
    } else {
      gain = _alphaGain * rawGain + (1.0 - _alphaGain) * gain;
      pan  = _alphaPan  * rawPan  + (1.0 - _alphaPan)  * pan;
    }
    return (gain: gain, pan: pan);
  }
}

/// Stateful EMA smoothing for all peers. One instance lives in the SessionBloc.
class ProximityMath {
  final Map<int, _PeerSmooth> _peers = {};

  ({double gain, double pan}) smooth(int peerId, double rawGain, double rawPan) {
    final s = _peers.putIfAbsent(peerId, _PeerSmooth.new);
    return s.update(rawGain, rawPan);
  }

  void removePeer(int peerId) => _peers.remove(peerId);

  void reset() => _peers.clear();
}
