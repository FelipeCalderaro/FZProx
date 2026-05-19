"""
Proximity audio math — pure Python, no external deps.

Implements §8 (distance attenuation) and §9 (stereo panning) from the spec.
"""
from __future__ import annotations

import math

# Spec §8.2 defaults
NEAR_DEFAULT = 20.0   # meters — full volume inside this radius
FAR_DEFAULT = 180.0   # meters — silence beyond this radius
CURVE_DEFAULT = 1.5   # exponent — between linear (1.0) and inverse-square (2.0)

# EMA smoothing alphas (§8.3, §9)
# Derived from spec: 50ms gain smoothing, 100ms pan smoothing at ~60 Hz updates.
ALPHA_GAIN = 0.3
ALPHA_PAN = 0.15


def xz_distance(x1: float, z1: float, x2: float, z2: float) -> float:
    """2D Euclidean distance on the XZ plane (Y is vertical, ignored for audio)."""
    return math.sqrt((x1 - x2) ** 2 + (z1 - z2) ** 2)


def gain_for_distance(
    d: float,
    near: float = NEAR_DEFAULT,
    far: float = FAR_DEFAULT,
    curve: float = CURVE_DEFAULT,
) -> float:
    """
    Piecewise attenuation curve (spec §8.2):
      d <= near  →  1.0  (full volume)
      near < d < far  →  power curve falloff
      d >= far   →  0.0  (silence)
    """
    if d <= near:
        return 1.0
    if d >= far:
        return 0.0
    return ((far - d) / (far - near)) ** curve


def pan_for_bearing(dx: float, dz: float, yaw_self: float) -> float:
    """
    Stereo pan in [-1, 1] based on peer's direction relative to self's forward vector.
    dx = peer.x - self.x, dz = peer.z - self.z, yaw_self in radians.
    -1 = full left, +1 = full right.
    Falls back to 0 (centre) if dx==dz==0.
    """
    if dx == 0.0 and dz == 0.0:
        return 0.0
    bearing = math.atan2(dx, dz) - yaw_self
    return max(-1.0, min(1.0, math.sin(bearing)))


def stereo_gains(gain: float, pan: float) -> tuple[float, float]:
    """
    Equal-power panning (spec §9):
      gain_L = gain * cos((pan+1)*π/4)
      gain_R = gain * sin((pan+1)*π/4)
    Returns (gain_L, gain_R).
    """
    p = (pan + 1.0) * math.pi / 4.0
    return gain * math.cos(p), gain * math.sin(p)


class SmoothGain:
    """
    Applies exponential moving averages to gain and pan independently,
    preventing audible clicks when positions jump or briefly go stale.
    """

    def __init__(
        self,
        alpha_gain: float = ALPHA_GAIN,
        alpha_pan: float = ALPHA_PAN,
    ) -> None:
        self._ag = alpha_gain
        self._ap = alpha_pan
        self._gain: float | None = None
        self._pan: float = 0.0

    def update(self, gain: float, pan: float) -> tuple[float, float]:
        """Feed new raw gain and pan; returns (smoothed_gain, smoothed_pan)."""
        if self._gain is None:
            self._gain = gain
        else:
            self._gain = self._ag * gain + (1.0 - self._ag) * self._gain
        self._pan = self._ap * pan + (1.0 - self._ap) * self._pan
        return self._gain, self._pan

    def reset(self) -> None:
        self._gain = None
        self._pan = 0.0
