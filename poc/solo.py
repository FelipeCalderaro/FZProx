"""
Solo mode POC — validates proximity audio on a single machine.

Two sub-modes:

  Orbit mode (default):
    A simulated peer circles you at --radius metres.  Good for testing the
    panning curve without needing to drive anywhere.

  Fixed mode (--peer-pos X,Z):
    The peer is parked at a fixed world coordinate.  Drive your car in Forza
    toward or away from that point to hear the audio fade in and out.
    Get the coordinates with:  uv run python -m poc track

IMPORTANT: Use headphones in mic mode. Speakers will cause a feedback loop.
"""
from __future__ import annotations

import asyncio
import math
import sys
import time

from daemon.telemetry import CarState, TelemetryReceiver

from .audio import AudioEngine
from .proximity import (
    SmoothGain,
    gain_for_distance,
    pan_for_bearing,
    stereo_gains,
    xz_distance,
)

_TICK_S = 1 / 60  # ~60 Hz update rate for gain/pan


async def run_solo(args) -> None:
    px = getattr(args, "peer_x", None)
    pz = getattr(args, "peer_z", None)
    fixed_peer: tuple[float, float] | None = (px, pz) if (px is not None and pz is not None) else None

    print()
    print("  ┌─────────────────────────────────────────┐")
    print("  │   HorizonProx POC — Solo Mode           │")
    print("  │                                         │")
    print("  │  ⚠  WEAR HEADPHONES (feedback risk!)   │")
    print("  └─────────────────────────────────────────┘")
    print()

    if fixed_peer:
        print(f"  Peer position : FIXED  X={fixed_peer[0]:.1f} m   Z={fixed_peer[1]:.1f} m")
        print(f"  (drive toward that point — distance updates from Forza telemetry)")
    else:
        print(f"  Simulated peer: ORBIT  radius={args.radius:.0f} m  speed={args.speed:.2f} rad/s")

    print(f"  Attenuation   : near={args.near} m  far={args.far} m  curve={args.curve}")
    print(f"  Panning       : {'off' if args.no_panning else 'on'}")
    print(f"  Telemetry     : 127.0.0.1:{args.telemetry_port}")
    print()

    # ── Self position (updated by telemetry callback) ─────────────────────────
    self_x: float = 0.0
    self_z: float = 0.0
    self_yaw: float = 0.0
    telem_ok: bool = False

    def on_state(s: CarState) -> None:
        nonlocal self_x, self_z, self_yaw, telem_ok
        self_x, self_z, self_yaw = s.x, s.z, s.yaw
        telem_ok = True

    def on_stale() -> None:
        nonlocal telem_ok
        telem_ok = False

    telem = TelemetryReceiver(
        host="127.0.0.1",
        port=args.telemetry_port,
        on_state=on_state,
        on_stale=on_stale,
    )
    await telem.start()

    # ── Audio engine ──────────────────────────────────────────────────────────
    engine = AudioEngine()
    peer = engine.add_peer("sim")
    engine.start_solo(
        input_device=getattr(args, "input_device", None),
        output_device=getattr(args, "output_device", None),
        loopback=getattr(args, "loopback", False),
    )
    print(f"  Audio in  : {engine.input_label}")
    print(f"  Audio out : {engine.output_label}")
    print()
    print("  dist(m)   gain   [bar]                 pan   L      R      source")
    print("  " + "─" * 72)

    smooth = SmoothGain()
    angle: float = 0.0
    tick: int = 0

    try:
        while True:
            t0 = time.monotonic()

            # Determine peer position
            if fixed_peer is not None:
                peer_x, peer_z = fixed_peer
            else:
                angle = (angle + args.speed * _TICK_S) % (2 * math.pi)
                peer_x = self_x + args.radius * math.cos(angle)
                peer_z = self_z + args.radius * math.sin(angle)

            d = xz_distance(self_x, self_z, peer_x, peer_z)
            raw_gain = gain_for_distance(d, args.near, args.far, args.curve)

            raw_pan = (
                0.0
                if args.no_panning
                else pan_for_bearing(peer_x - self_x, peer_z - self_z, self_yaw)
            )

            sg, sp = smooth.update(raw_gain, raw_pan)
            gl, gr = stereo_gains(sg, sp)
            peer.set_gains(gl, gr)

            # Route captured audio into the peer buffer for local playback
            frame = engine.pop_capture()
            while frame is not None:
                peer.put(frame)
                frame = engine.pop_capture()

            if tick % 6 == 0:
                filled = int(sg * 24)
                bar = "█" * filled + "░" * (24 - filled)
                source = "Forza" if telem_ok else "origin"
                sys.stdout.write(
                    f"\r  {d:6.1f}    {sg:.3f}  [{bar}]  {sp:+.2f}  {gl:.3f}  {gr:.3f}  [{source}]  "
                )
                sys.stdout.flush()

            tick += 1
            elapsed = time.monotonic() - t0
            await asyncio.sleep(max(0.0, _TICK_S - elapsed))

    except KeyboardInterrupt:
        pass
    finally:
        print("\n\n  Stopping…")
        engine.stop()
        await telem.stop()
        print("  Done.")
