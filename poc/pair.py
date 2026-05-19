"""
Pair mode POC — validates end-to-end proximity audio between two Python processes.

Two terminals, one machine (or two PCs on LAN):

  Terminal A (listener):
    uv run python -m poc pair --listen

  Terminal B (connector):
    uv run python -m poc pair --connect localhost:9100

Each side:
  - Reads Forza telemetry for its own position (or simulates if Forza not running).
  - Streams raw PCM to the peer over TCP.
  - Receives peer PCM, looks up current distance, applies gain + pan.
  - Plays the spatially-mixed audio through headphones/speakers.

TCP frame format (shared both directions):
  [1B type] [2B payload_len big-endian] [payload]

  type 0x01 AUDIO    payload: 1920 bytes  (int16 mono 48 kHz, 20 ms)
  type 0x02 POSITION payload:   16 bytes  (float32 LE: x, 0, z, yaw)

Positions are sent at ~15 Hz (every 4th audio frame).

To test on a single machine without Forza, use --sim-self on one or both sides:
  uv run python -m poc pair --listen --sim-self --sim-radius 80 --sim-speed 0.3
"""
from __future__ import annotations

import asyncio
import math
import struct
import sys
import time

import numpy as np

from daemon.telemetry import CarState, TelemetryReceiver

from .audio import FRAME_SAMPLES, AudioEngine, PeerAudio
from .proximity import (
    SmoothGain,
    gain_for_distance,
    pan_for_bearing,
    stereo_gains,
    xz_distance,
)

MSG_AUDIO = 0x01
MSG_POS = 0x02
PCM_BYTES = FRAME_SAMPLES * 2  # int16 → 1920 bytes per frame
_HEADER = struct.Struct(">BH")  # type(1) + length(2)


# ── Wire protocol helpers ─────────────────────────────────────────────────────

async def _send(writer: asyncio.StreamWriter, msg_type: int, data: bytes) -> None:
    writer.write(_HEADER.pack(msg_type, len(data)) + data)
    await writer.drain()


async def _recv(reader: asyncio.StreamReader) -> tuple[int, bytes]:
    header = await reader.readexactly(_HEADER.size)
    msg_type, length = _HEADER.unpack(header)
    payload = await reader.readexactly(length)
    return msg_type, payload


# ── Core session (both roles behave identically once connected) ───────────────

async def _session(
    reader: asyncio.StreamReader,
    writer: asyncio.StreamWriter,
    engine: AudioEngine,
    peer_audio: PeerAudio,
    args,
    self_pos: list[float],   # [x, z, yaw]  — updated by telemetry or sim
    telem_ok: list[bool],
) -> None:
    addr = writer.get_extra_info("peername", ("?", 0))
    print(f"  Connected to {addr[0]}:{addr[1]}")
    print()
    print("  dist(m)   gain   [bar]                 pan   L      R      buf(ms)  source")
    print("  " + "─" * 75)

    peer_pos: list[float] = [0.0, 0.0, 0.0]  # [x, z, yaw] — filled by incoming MSG_POS
    smooth = SmoothGain()
    tick = 0

    # ── Sender: outbound audio + position ────────────────────────────────────

    async def sender() -> None:
        pos_counter = 0
        while True:
            frame = engine.pop_capture()
            if frame is not None:
                await _send(writer, MSG_AUDIO, frame.tobytes())
                pos_counter += 1
                if pos_counter >= 4:
                    pos_counter = 0
                    x, z, yaw = self_pos
                    await _send(writer, MSG_POS, struct.pack("<ffff", x, 0.0, z, yaw))
            else:
                await asyncio.sleep(0.005)

    # ── Receiver: inbound audio + position → gain update ─────────────────────

    async def receiver() -> None:
        nonlocal tick
        while True:
            try:
                msg_type, data = await _recv(reader)
            except (asyncio.IncompleteReadError, ConnectionResetError, EOFError):
                print("\n\n  Peer disconnected.")
                return

            if msg_type == MSG_AUDIO:
                pcm = np.frombuffer(data, dtype=np.int16).copy()
                peer_audio.put(pcm)

                # Recompute gain every audio frame (~50 Hz — more than enough)
                sx, sz, syaw = self_pos
                px, pz, _ = peer_pos
                d = xz_distance(sx, sz, px, pz)
                raw_gain = gain_for_distance(d, args.near, args.far, args.curve)
                raw_pan = (
                    0.0
                    if args.no_panning
                    else pan_for_bearing(px - sx, pz - sz, syaw)
                )
                sg, sp = smooth.update(raw_gain, raw_pan)
                gl, gr = stereo_gains(sg, sp)
                peer_audio.set_gains(gl, gr)

                tick += 1
                if tick % 50 == 0:
                    filled = int(sg * 24)
                    bar = "█" * filled + "░" * (24 - filled)
                    source = "Forza" if telem_ok[0] else "sim/origin"
                    sys.stdout.write(
                        f"\r  {d:6.1f}    {sg:.3f}  [{bar}]  {sp:+.2f}  "
                        f"{gl:.3f}  {gr:.3f}  {peer_audio.buffer_ms:3.0f}      [{source}]  "
                    )
                    sys.stdout.flush()

            elif msg_type == MSG_POS:
                px, _, pz, pyaw = struct.unpack("<ffff", data)
                peer_pos[0] = px
                peer_pos[1] = pz
                peer_pos[2] = pyaw

    send_task = asyncio.create_task(sender())
    recv_task = asyncio.create_task(receiver())
    try:
        done, pending = await asyncio.wait(
            [send_task, recv_task],
            return_when=asyncio.FIRST_COMPLETED,
        )
        for t in pending:
            t.cancel()
    finally:
        writer.close()


# ── Position simulation (for testing without Forza) ───────────────────────────

async def _sim_position_loop(
    self_pos: list[float],
    radius: float,
    speed: float,
) -> None:
    angle = 0.0
    while True:
        await asyncio.sleep(1 / 60)
        angle = (angle + speed / 60.0) % (2 * math.pi)
        self_pos[0] = radius * math.cos(angle)   # x
        self_pos[1] = radius * math.sin(angle)   # z
        self_pos[2] = angle                       # yaw follows tangent


# ── Connection setup ──────────────────────────────────────────────────────────

async def _accept_one(port: int) -> tuple[asyncio.StreamReader, asyncio.StreamWriter]:
    loop = asyncio.get_running_loop()
    fut: asyncio.Future[tuple] = loop.create_future()

    async def _handle(r: asyncio.StreamReader, w: asyncio.StreamWriter) -> None:
        if not fut.done():
            fut.set_result((r, w))
        else:
            w.close()

    server = await asyncio.start_server(_handle, "0.0.0.0", port)
    print(f"  Listening on TCP port {port}…  (waiting for peer)")
    async with server:
        return await fut


# ── Main entry point ──────────────────────────────────────────────────────────

async def run_pair(args) -> None:
    print()
    print("  ┌──────────────────────────────────────────┐")
    print("  │   HorizonProx POC — Pair Mode            │")
    print("  └──────────────────────────────────────────┘")
    print()
    print(f"  Attenuation: near={args.near} m  far={args.far} m  curve={args.curve}")
    print(f"  Panning    : {'off' if args.no_panning else 'on'}")
    print(f"  Telemetry  : 127.0.0.1:{args.telemetry_port}")
    if args.sim_self:
        print(f"  Self pos   : SIMULATED  radius={args.sim_radius} m  speed={args.sim_speed} rad/s")
    print()

    # Shared mutable state bridging telemetry callback ↔ asyncio
    self_pos: list[float] = [0.0, 0.0, 0.0]   # [x, z, yaw]
    telem_ok: list[bool] = [False]

    def on_state(s: CarState) -> None:
        self_pos[0] = s.x
        self_pos[1] = s.z
        self_pos[2] = s.yaw
        telem_ok[0] = True

    def on_stale() -> None:
        telem_ok[0] = False

    telem = TelemetryReceiver(
        host="127.0.0.1",
        port=args.telemetry_port,
        on_state=on_state,
        on_stale=on_stale,
    )
    await telem.start()

    engine = AudioEngine()
    peer_audio = engine.add_peer("peer")
    engine.start_pair(
        input_device=getattr(args, "input_device", None),
        output_device=getattr(args, "output_device", None),
        loopback=getattr(args, "loopback", False),
    )
    print(f"  Audio in  : {engine.input_label}")
    print(f"  Audio out : {engine.output_label}")
    print()

    sim_task = None
    if args.sim_self:
        sim_task = asyncio.create_task(
            _sim_position_loop(self_pos, args.sim_radius, args.sim_speed)
        )

    try:
        if args.listen:
            reader, writer = await _accept_one(args.port)
        else:
            host, port_str = args.connect.rsplit(":", 1)
            print(f"  Connecting to {host}:{port_str}…")
            reader, writer = await asyncio.open_connection(host, int(port_str))

        await _session(reader, writer, engine, peer_audio, args, self_pos, telem_ok)

    except KeyboardInterrupt:
        pass
    finally:
        if sim_task:
            sim_task.cancel()
        engine.stop()
        await telem.stop()
        print("\n  Done.")
