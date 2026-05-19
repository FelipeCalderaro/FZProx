"""
HorizonProx POC -- CLI entry point.

  uv run python -m poc track   [options]   # monitor live Forza telemetry
  uv run python -m poc solo    [options]   # single-machine audio validation
  uv run python -m poc pair    [options]   # two-process network validation
  uv run python -m poc devices             # list audio devices + loopback info
"""
from __future__ import annotations

import argparse
import asyncio


def _add_audio_args(p: argparse.ArgumentParser) -> None:
    """Shared audio device flags for solo and pair modes."""
    g = p.add_argument_group("audio input")
    g.add_argument(
        "--input-device",
        metavar="N",
        help=(
            "Capture device index or name (default: system mic). "
            "Run 'devices' to list options. "
            "Accepts any input device: mic, Stereo Mix, VB-Audio Cable Output, etc."
        ),
    )
    g.add_argument(
        "--loopback",
        action="store_true",
        help=(
            "Capture system audio via WASAPI loopback instead of a mic (Windows only). "
            "Without --input-device: captures from the default output (headphones/speakers). "
            "With --input-device N: N must be an OUTPUT device index (e.g. your headphone port). "
            "Tip: route Spotify -> VB-Audio Cable, then --loopback --input-device <cable-idx> "
            "to hear only the proximity-filtered version with no double-audio."
        ),
    )
    g.add_argument(
        "--output-device",
        metavar="N",
        help="Playback device index or name (default: system default output).",
    )


def _build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="python -m poc",
        description="HorizonProx POC -- proximity audio proof-of-concept",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    sub = parser.add_subparsers(dest="mode", required=True)

    # ── devices ───────────────────────────────────────────────────────────────
    sub.add_parser(
        "devices",
        help="List audio devices with index, channel counts, and loopback eligibility",
    )

    # ── track ─────────────────────────────────────────────────────────────────
    t = sub.add_parser(
        "track",
        help="Monitor live Forza UDP telemetry (position, speed, yaw, packet rate)",
        description="""
Track mode -- real-time Forza telemetry monitor.

Shows X/Y/Z position, speed, yaw, packet rate (~60 Hz expected), and total
distance travelled.  Useful for verifying Data Out is configured correctly and
that the coordinate offsets match known in-game positions.

Run Forza, enable Data Out (HUD options -> Data Out -> 127.0.0.1:<port>),
then start this and drive around to see coordinates update live.
""",
    )
    t.add_argument(
        "--telemetry-port",
        type=int,
        default=9988,
        metavar="PORT",
        help="Forza Data Out UDP port (default 9988)",
    )
    t.add_argument(
        "--log",
        metavar="PREFIX",
        help=(
            "Save packets to PREFIX.csv (one row per packet, every 4-byte offset as float32/int32) "
            "and PREFIX_pkt0.hex (annotated hex dump of the first packet). "
            "Open the CSV in Excel: filter speed>0, look for columns that change -- "
            "those are the real position offsets in FH6."
        ),
    )

    # ── solo ──────────────────────────────────────────────────────────────────
    s = sub.add_parser(
        "solo",
        help="Hear any audio source through a proximity filter (fixed or orbiting peer)",
        description="""
Solo mode -- single machine, no networking.

Two sub-modes controlled by --peer-pos:

  Orbit mode (default): a simulated peer circles you at RADIUS metres.
  Fixed mode (--peer-pos X,Z): peer is parked at a world coordinate; you
      drive toward/away from it and hear the audio fade in and out.
      Get the coordinates from:  uv run python -m poc track

Default source: microphone (use headphones to avoid feedback).
With --loopback:  captures whatever is playing on an output device.
""",
    )
    s.add_argument("--peer-x",          type=float, metavar="M",
                   help="Fix peer at world X coordinate (metres). Requires --peer-z.")
    s.add_argument("--peer-z",          type=float, metavar="M",
                   help="Fix peer at world Z coordinate (metres). Requires --peer-x.")
    s.add_argument("--radius",         type=float, default=100.0,  metavar="M",
                   help="Orbit radius in metres -- ignored when --peer-pos is set (default 100)")
    s.add_argument("--speed",          type=float, default=0.2,    metavar="RAD/S",
                   help="Orbit angular speed in rad/s -- ignored when --peer-pos is set (default 0.2)")
    s.add_argument("--near",           type=float, default=10.0,   metavar="M",
                   help="Full-volume distance in metres (default 10)")
    s.add_argument("--far",            type=float, default=80.0,   metavar="M",
                   help="Silence distance in metres (default 80)")
    s.add_argument("--curve",          type=float, default=2.0,    metavar="EXP",
                   help="Attenuation exponent -- 2.0 = inverse-square (physically accurate, default 2.0)")
    s.add_argument("--no-panning",     action="store_true",
                   help="Disable stereo panning (mono attenuation only)")
    s.add_argument("--telemetry-port", type=int,   default=9988,   metavar="PORT",
                   help="Forza Data Out UDP port (default 9988)")
    _add_audio_args(s)

    # ── pair ──────────────────────────────────────────────────────────────────
    p = sub.add_parser(
        "pair",
        help="Two-process audio stream with real proximity mixing",
        description="""
Pair mode -- two terminals (same PC or two PCs on LAN).

  Terminal A:  uv run python -m poc pair --listen
  Terminal B:  uv run python -m poc pair --connect localhost:9100

Each side reads its own Forza telemetry and shares positions over TCP.
Use --sim-self if Forza isn't running on that side.
Any audio source works via --loopback or --input-device.
""",
    )
    role = p.add_mutually_exclusive_group(required=True)
    role.add_argument("--listen",  action="store_true",
                      help="Wait for the other side to connect")
    role.add_argument("--connect", metavar="HOST:PORT",
                      help="Connect to the listening peer (e.g. 192.168.1.5:9100)")
    p.add_argument("--port",           type=int,   default=9100,   metavar="PORT",
                   help="TCP port to listen on (default 9100)")
    p.add_argument("--near",           type=float, default=20.0)
    p.add_argument("--far",            type=float, default=180.0)
    p.add_argument("--curve",          type=float, default=1.5)
    p.add_argument("--no-panning",     action="store_true")
    p.add_argument("--telemetry-port", type=int,   default=9988)
    p.add_argument("--sim-self",       action="store_true",
                   help="Simulate own position with a circle (no Forza needed)")
    p.add_argument("--sim-radius",     type=float, default=50.0,   metavar="M",
                   help="Simulation orbit radius (default 50 m)")
    p.add_argument("--sim-speed",      type=float, default=0.2,    metavar="RAD/S",
                   help="Simulation orbit speed (default 0.2 rad/s)")
    _add_audio_args(p)

    # ── hub ───────────────────────────────────────────────────────────────────
    h = sub.add_parser("hub", help="Start the relay hub -- players connect here")
    h.add_argument(
        "--port",
        type=int,
        default=9200,
        metavar="PORT",
        help="TCP port to listen on (default 9200)",
    )

    # ── client ────────────────────────────────────────────────────────────────
    c = sub.add_parser(
        "client",
        help="TUI client -- connect to a hub for live proximity audio",
        description=(
            "Connect to a HorizonProx hub. "
            "Set your username, point at the hub, drive."
        ),
    )
    c.add_argument("--username", metavar="NAME",
                   help="Your display name (prompted if omitted)")
    c.add_argument("--hub", metavar="HOST:PORT",
                   help="Hub server address (default: localhost:9200, prompted if omitted)")
    c.add_argument("--near",           type=float, default=10.0,  metavar="M")
    c.add_argument("--far",            type=float, default=80.0,  metavar="M")
    c.add_argument("--curve",          type=float, default=2.0,   metavar="EXP")
    c.add_argument("--no-panning",     action="store_true")
    c.add_argument("--telemetry-port", type=int,   default=9988,  metavar="PORT")
    _add_audio_args(c)

    return parser


def main() -> None:
    parser = _build_parser()
    args = parser.parse_args()

    if args.mode == "devices":
        from .audio import list_devices
        list_devices()
        return

    if args.mode == "track":
        from .track import run_track
        try:
            asyncio.run(run_track(args))
        except KeyboardInterrupt:
            pass
        return

    if args.mode == "solo":
        from .solo import run_solo
        try:
            asyncio.run(run_solo(args))
        except KeyboardInterrupt:
            pass

    elif args.mode == "pair":
        from .pair import run_pair
        try:
            asyncio.run(run_pair(args))
        except KeyboardInterrupt:
            pass

    elif args.mode == "hub":
        from .hub import run_hub
        try:
            asyncio.run(run_hub(args))
        except KeyboardInterrupt:
            pass

    elif args.mode == "client":
        from .client import run_client
        try:
            asyncio.run(run_client(args))
        except KeyboardInterrupt:
            pass


if __name__ == "__main__":
    main()
