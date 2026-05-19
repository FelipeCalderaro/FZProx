"""
DSP utilities — Doppler effect math and pitch-shifting.

Called by the client for each received audio frame before playback.
The hub never touches this; all the work happens client-side.
"""
from __future__ import annotations

import math

import numpy as np

SOUND_SPEED = 343.0  # m/s (air at ~20°C)

# Clamp Doppler to a perceptually useful range.
# Below 0.7 or above 1.5 starts to sound unnatural even for fast cars.
_DOPPLER_MIN = 0.7
_DOPPLER_MAX = 1.5


def doppler_factor(
    self_x: float,
    self_z: float,
    peer_x: float,
    peer_z: float,
    peer_yaw: float,
    peer_speed: float,
) -> float:
    """
    Classic Doppler shift for a moving source, stationary listener.

      f_perceived / f_source = v_sound / (v_sound - v_source_toward_listener)

    peer_yaw is the heading the peer's car faces (radians, Forza convention:
    sin(yaw)=X direction, cos(yaw)=Z direction).
    peer_speed is in m/s.

    Returns a pitch multiplier: >1.0 = approaching (higher pitch),
                                 <1.0 = receding  (lower pitch),
                                  1.0 = no shift.
    """
    dx = self_x - peer_x
    dz = self_z - peer_z
    dist = math.sqrt(dx * dx + dz * dz)
    if dist < 1.0 or peer_speed < 0.5:
        return 1.0

    # Unit vector from peer toward self
    nx, nz = dx / dist, dz / dist

    # Peer velocity vector in world space
    vx = peer_speed * math.sin(peer_yaw)
    vz = peer_speed * math.cos(peer_yaw)

    # Radial component toward listener (positive = approaching)
    v_toward = vx * nx + vz * nz

    # Guard against transonic edge cases
    denom = SOUND_SPEED - v_toward
    if abs(denom) < 10.0:
        denom = math.copysign(10.0, denom)

    return max(_DOPPLER_MIN, min(_DOPPLER_MAX, SOUND_SPEED / denom))


def apply_doppler(frame: np.ndarray, factor: float) -> np.ndarray:
    """
    Pitch-shift a mono int16 PCM frame by resampling.

    factor > 1.0 — source approaching — compress audio — higher pitch
    factor < 1.0 — source receding   — stretch audio  — lower pitch

    Uses linear interpolation on the frame itself (no look-ahead buffer).
    Accurate enough for perceptual Doppler at game distances and speeds.
    """
    if abs(factor - 1.0) < 0.004:
        return frame

    n = len(frame)
    # output[i] samples input at position i*factor
    # factor=1.1: reads to position n*1.1 → compressed → higher pitch
    # factor=0.9: reads to position n*0.9 → stretched  → lower pitch
    x_in = np.arange(n, dtype=np.float64) * factor
    np.clip(x_in, 0.0, float(n - 1), out=x_in)
    return np.interp(x_in, np.arange(n), frame.astype(np.float64)).astype(np.int16)
