"""
HorizonProx POC — Client mode.

TUI client: connect to a hub, pick or create a room, stream proximity audio,
and render a live panel showing every peer with distance, volume, pan, Doppler
factor, and playback buffer health.

Usage:
  uv run python -m poc client --hub 192.168.1.5:9200
"""
from __future__ import annotations

import asyncio
import struct
from dataclasses import dataclass, field

import numpy as np

from daemon.telemetry import CarState, TelemetryReceiver

from .audio import FRAME_SAMPLES, AudioEngine, PeerAudio, _build_app_list
from .dsp import apply_doppler, doppler_factor
from .hub import (
    C2H_AUDIO,
    C2H_HELLO,
    C2H_LIST,
    C2H_STATE,
    H2C_ERROR,
    H2C_PEER_AUDIO,
    H2C_PEER_JOINED,
    H2C_PEER_LEFT,
    H2C_PEER_STATE,
    H2C_ROOM_LIST,
    H2C_WELCOME,
    _recv,
    _send,
)
from .proximity import (
    SmoothGain,
    gain_for_distance,
    pan_for_bearing,
    stereo_gains,
    xz_distance,
)

_STATE_STRUCT = struct.Struct("<ffff")  # x, z, yaw, speed
PCM_BYTES = FRAME_SAMPLES * 2          # 1920 bytes per frame


# ── Peer state ────────────────────────────────────────────────────────────────

@dataclass
class PeerState:
    id: int
    username: str
    pos: list[float] = field(default_factory=lambda: [0.0, 0.0, 0.0, 0.0])  # x,z,yaw,speed
    audio: PeerAudio | None = None
    smooth: SmoothGain = field(default_factory=SmoothGain)
    last_gain: float = 0.0
    last_pan: float = 0.0
    last_dist: float = float("inf")
    last_doppler: float = 1.0


# ── Rich TUI panel ────────────────────────────────────────────────────────────

def _render(
    username: str,
    hub_addr: str,
    room_code: str,
    self_id: int,
    self_pos: list[float],
    telem_ok: list[bool],
    peers: dict[int, PeerState],
    engine: AudioEngine,
):
    from rich.console import Group
    from rich.panel import Panel
    from rich.table import Table
    from rich.text import Text

    sx, sz, syaw, sspeed = self_pos

    if telem_ok[0]:
        telem_line = Text.assemble(
            ("  Forza  ", "green bold"),
            (f"X={sx:.0f}  Z={sz:.0f}  Yaw={syaw:.2f} rad  Speed={sspeed:.1f} m/s", "green"),
        )
    else:
        telem_line = Text("  origin (no Forza telemetry)", style="dim")

    audio_line = Text(
        f"  in: {engine.input_label}   out: {engine.output_label}",
        style="dim",
    )

    table = Table(show_header=True, header_style="bold", box=None, padding=(0, 1))
    table.add_column("Player",   width=18, no_wrap=True)
    table.add_column("Dist (m)", width=9,  justify="right")
    table.add_column("Volume",   width=26)
    table.add_column("Pan",      width=6,  justify="right")
    table.add_column("Doppler",  width=8,  justify="right")
    table.add_column("Buf",      width=7,  justify="right")

    if peers:
        for ps in sorted(peers.values(), key=lambda p: p.last_dist):
            dist_str = f"{ps.last_dist:.0f}" if ps.last_dist < float("inf") else "--"
            filled = int(ps.last_gain * 20)
            bar = "X" * filled + "." * (20 - filled)
            vol_str = f"[{bar}] {ps.last_gain:.2f}"
            pan_str = f"{ps.last_pan:+.2f}"
            dop_str = f"{ps.last_doppler:.3f}"
            buf_str = f"{ps.audio.buffer_ms:.0f} ms" if ps.audio else "--"
            table.add_row(
                ps.username[:18], dist_str, vol_str, pan_str, dop_str, buf_str
            )
    else:
        table.add_row(
            Text("(waiting for other players...)", style="dim italic"),
            "", "", "", "", "",
        )

    content = Group(telem_line, audio_line, Text(""), table)
    return Panel(
        content,
        title=(
            f"HorizonProx  [bold]o[/bold]  {username}"
            f"  room=[bold cyan]{room_code}[/bold cyan]"
            f"  @{hub_addr}  (id={self_id})"
        ),
        border_style="blue",
    )


# ── Client session (post-join) ────────────────────────────────────────────────

async def _client_session(
    reader: asyncio.StreamReader,
    writer: asyncio.StreamWriter,
    username: str,
    room_code: str,
    self_id: int,
    engine: AudioEngine,
    peers: dict[int, PeerState],
    self_pos: list[float],   # [x, z, yaw, speed]
    telem_ok: list[bool],
    args,
) -> None:
    hub_addr: str = getattr(args, "_hub_addr", "hub")

    # ── Sender ───────────────────────────────────────────────────────────────

    async def sender() -> None:
        pos_counter = 0
        while True:
            frame = engine.pop_capture()
            if frame is not None:
                await _send(writer, C2H_AUDIO, frame.tobytes())
                pos_counter += 1
                if pos_counter >= 4:   # send STATE roughly every 4 audio frames (~50 ms)
                    pos_counter = 0
                    await _send(writer, C2H_STATE, _STATE_STRUCT.pack(*self_pos))
            else:
                await asyncio.sleep(0.005)

    # ── Receiver ─────────────────────────────────────────────────────────────

    async def receiver() -> None:
        while True:
            try:
                msg_type, data = await _recv(reader)
            except (asyncio.IncompleteReadError, ConnectionResetError, EOFError):
                return

            if msg_type == H2C_PEER_AUDIO and len(data) >= 1:
                pid = data[0]
                if pid in peers and peers[pid].audio is not None:
                    ps = peers[pid]
                    raw = np.frombuffer(data[1:], dtype=np.int16).copy()
                    px, pz, pyaw, pspeed = ps.pos
                    df = doppler_factor(
                        self_pos[0], self_pos[1],
                        px, pz, pyaw, pspeed,
                    )
                    ps.last_doppler = df
                    ps.audio.put(apply_doppler(raw, df))

            elif msg_type == H2C_PEER_STATE and len(data) >= 17:
                pid = data[0]
                if pid in peers:
                    peers[pid].pos = list(_STATE_STRUCT.unpack_from(data, 1))

            elif msg_type == H2C_PEER_JOINED and len(data) >= 2:
                pid, name_len = data[0], data[1]
                name = data[2: 2 + name_len].decode("utf-8", errors="replace")
                peer_audio = engine.add_peer(f"peer_{pid}")
                peers[pid] = PeerState(id=pid, username=name, audio=peer_audio)

            elif msg_type == H2C_PEER_LEFT and len(data) >= 1:
                pid = data[0]
                engine.remove_peer(f"peer_{pid}")
                peers.pop(pid, None)

    # ── Gain + TUI ────────────────────────────────────────────────────────────

    async def gain_and_tui() -> None:
        from rich.console import Console
        from rich.live import Live

        console = Console()
        tick = 0
        with Live(
            _render(
                username, hub_addr, room_code, self_id,
                self_pos, telem_ok, peers, engine,
            ),
            console=console,
            refresh_per_second=10,
            screen=False,
        ) as live:
            while True:
                await asyncio.sleep(1 / 60)
                tick += 1

                sx, sz, syaw = self_pos[0], self_pos[1], self_pos[2]
                for ps in peers.values():
                    px, pz = ps.pos[0], ps.pos[1]
                    d = xz_distance(sx, sz, px, pz)
                    raw_gain = gain_for_distance(d, args.near, args.far, args.curve)
                    raw_pan = (
                        0.0 if args.no_panning
                        else pan_for_bearing(px - sx, pz - sz, syaw)
                    )
                    sg, sp = ps.smooth.update(raw_gain, raw_pan)
                    gl, gr = stereo_gains(sg, sp)
                    if ps.audio is not None:
                        ps.audio.set_gains(gl, gr)
                    ps.last_gain = sg
                    ps.last_pan = sp
                    ps.last_dist = d

                if tick % 6 == 0:
                    live.update(
                        _render(
                            username, hub_addr, room_code, self_id,
                            self_pos, telem_ok, peers, engine,
                        )
                    )

    send_task = asyncio.create_task(sender())
    recv_task = asyncio.create_task(receiver())
    tui_task  = asyncio.create_task(gain_and_tui())

    done, pending = await asyncio.wait(
        [send_task, recv_task, tui_task],
        return_when=asyncio.FIRST_COMPLETED,
    )
    for t in pending:
        t.cancel()
    await asyncio.gather(*pending, return_exceptions=True)


# ── Setup wizard helpers ──────────────────────────────────────────────────────

def _wizard_devices(console, args) -> None:
    """Interactively pick input source and output device. Mutates args."""
    import sounddevice as sd
    from rich.prompt import Prompt
    from rich.table import Table

    devices = sd.query_devices()
    apis = sd.query_hostapis()
    default_in  = sd.default.device[0]
    default_out = sd.default.device[1]

    # All devices — anything can be an input source (output-only devices go
    # through loopback capture automatically when selected as input).
    all_devs = list(enumerate(devices))
    outputs  = [(i, d) for i, d in all_devs if d["max_output_channels"] > 0]

    def _type_label(d) -> str:
        has_in  = d["max_input_channels"]  > 0
        has_out = d["max_output_channels"] > 0
        if has_in and has_out:
            return "in/out"
        if has_in:
            return "in"
        return "out"

    def _input_table() -> Table:
        t = Table(show_header=True, header_style="bold dim", box=None, padding=(0, 1))
        t.add_column("#",      width=4,  justify="right")
        t.add_column("Device", width=44, no_wrap=True)
        t.add_column("API",    width=10, no_wrap=True)
        t.add_column("Type",   width=7)
        t.add_column("",       width=11)
        return t

    def _output_table() -> Table:
        t = Table(show_header=True, header_style="bold dim", box=None, padding=(0, 1))
        t.add_column("#",      width=4,  justify="right")
        t.add_column("Device", width=44, no_wrap=True)
        t.add_column("API",    width=10, no_wrap=True)
        t.add_column("Ch",     width=3,  justify="right")
        t.add_column("",       width=11)
        return t

    # Initialise app-capture fields (may be set below)
    args.app_loopback_idx  = None
    args.app_display_name  = None
    args.app_pid           = None

    # ── Input ─────────────────────────────────────────────────────────────────
    console.print()
    console.rule("  Audio Input", style="dim")
    console.print(
        "  [dim][bold cyan]Enter[/bold cyan] = app capture (Spotify, game, etc.)  "
        "or type a device number for mic / loopback.[/dim]"
    )
    console.print()

    t = _input_table()
    t.add_row(
        "[bold cyan]A[/bold cyan]",
        "[bold]App capture[/bold] -- pick a running program (Spotify, game, etc.)",
        "", "[bold cyan]default[/bold cyan]", "",
    )
    for i, d in all_devs:
        api   = apis[d["hostapi"]]["name"][:10]
        typ   = _type_label(d)
        flags = []
        if i == default_in:
            flags.append("[dim](sys-in)[/dim]")
        if i == default_out:
            flags.append("[dim](sys-out)[/dim]")
        t.add_row(str(i), d["name"][:44], api, typ, " ".join(flags))
    console.print(t)
    console.print()

    in_choice = Prompt.ask(
        "  Input ([bold cyan]A[/bold cyan] for app, number for device)",
        default="A",
    ).strip().upper()

    if in_choice == "A":
        # ── App selection ──────────────────────────────────────────────────
        console.print()
        console.print("  [dim]Scanning audio sessions...[/dim]")
        apps = _build_app_list()

        if not apps:
            console.print("  [yellow]No active audio sessions found. Falling back to default mic.[/yellow]")
            args.loopback = False
            args.input_device = None
        else:
            console.print()
            console.rule("  Apps currently producing audio", style="dim")
            console.print(
                "  [dim]Per-process capture (isolated) when available; "
                "otherwise device loopback (fewest co-tenants).[/dim]"
            )
            console.print()
            at = Table(show_header=True, header_style="bold dim", box=None, padding=(0, 1))
            at.add_column("#",        width=4,  justify="right")
            at.add_column("App",      width=22, no_wrap=True)
            at.add_column("Device",   width=30, no_wrap=True)
            at.add_column("Sharing",  width=22)
            for idx_a, app in enumerate(apps):
                shared = app["shared_with"]
                share_str = (
                    "[green]only app on device[/green]" if shared == 0
                    else f"[yellow]+{shared} other app{'s' if shared != 1 else ''}[/yellow]"
                )
                at.add_row(
                    str(idx_a),
                    app["name"][:22],
                    app["device_name"][:30],
                    share_str,
                )
            console.print(at)
            console.print()

            app_choice = Prompt.ask("  App number", default="0").strip()
            if app_choice.isdigit() and int(app_choice) < len(apps):
                chosen = apps[int(app_choice)]
                args.app_loopback_idx = chosen["loopback_idx"]
                args.app_display_name = chosen["name"]
                args.app_pid          = chosen["pid"]
                args.loopback         = False
                args.input_device     = None
            else:
                console.print("  [yellow]Invalid choice. Falling back to default mic.[/yellow]")
                args.loopback     = False
                args.input_device = None

    elif in_choice.isdigit():
        idx = int(in_choice)
        d = devices[idx] if idx < len(devices) else {}
        has_input = d.get("max_input_channels", 0) > 0
        if has_input:
            args.loopback = False
            args.input_device = idx
        else:
            args.loopback = True
            args.input_device = idx
            console.print("  [dim]Output-only device -- loopback capture enabled.[/dim]")
    else:
        args.loopback = False
        args.input_device = None

    # ── Output ────────────────────────────────────────────────────────────────
    console.print()
    console.rule("  Audio Output", style="dim")
    console.print()

    t2 = _output_table()
    for i, d in outputs:
        api  = apis[d["hostapi"]]["name"][:10]
        flag = "[cyan](default)[/cyan]" if i == default_out else ""
        t2.add_row(str(i), d["name"][:44], api, str(d["max_output_channels"]), flag)
    console.print(t2)
    console.print()

    out_choice = Prompt.ask(
        "  Output device (number, or Enter for system default)",
        default="",
    ).strip()
    args.output_device = int(out_choice) if out_choice.isdigit() else None


def _wizard_proximity(console, args) -> None:
    """Interactively configure near/far/curve/panning. Mutates args."""
    from rich.prompt import Prompt

    console.print()
    console.rule("  Proximity Settings", style="dim")
    console.print()
    console.print(
        "  These control how audio fades with distance. "
        "Press Enter to keep the default."
    )
    console.print()

    def _ask_float(label: str, default: float) -> float:
        raw = Prompt.ask(f"  {label}", default=str(default)).strip()
        try:
            return float(raw)
        except ValueError:
            return default

    args.near  = _ask_float("Near distance — full volume within (m)   ", args.near)
    args.far   = _ask_float("Far  distance — silent beyond      (m)   ", args.far)
    args.curve = _ask_float("Volume curve  — exponent (2.0 = inv sq)  ", args.curve)

    pan_str = Prompt.ask(
        "  Stereo panning (L/R based on bearing)",
        choices=["on", "off"],
        default="off" if args.no_panning else "on",
    )
    args.no_panning = (pan_str == "off")


# ── Room selection TUI ────────────────────────────────────────────────────────

async def _pick_room(
    reader: asyncio.StreamReader,
    writer: asyncio.StreamWriter,
    console,
) -> str:
    import random

    from rich.prompt import Prompt
    from rich.table import Table

    await _send(writer, C2H_LIST, b"")
    try:
        msg_type, data = await asyncio.wait_for(_recv(reader), timeout=5.0)
    except asyncio.TimeoutError:
        return Prompt.ask("  Room code (4 digits)", default="1234").strip()[:4] or "1234"

    if msg_type != H2C_ROOM_LIST or not data:
        return Prompt.ask("  Room code (4 digits)", default="1234").strip()[:4] or "1234"

    n = data[0]
    offset = 1
    rooms: list[tuple[str, int]] = []
    for _ in range(n):
        if offset + 5 > len(data):
            break
        code = data[offset: offset + 4].decode("ascii", errors="replace")
        n_players = data[offset + 4]
        offset += 5
        rooms.append((code, n_players))

    if rooms:
        t = Table(show_header=True, header_style="bold", box=None, padding=(0, 2))
        t.add_column("Room Code", width=12)
        t.add_column("Players",   width=8, justify="right")
        for code, n_players in rooms:
            t.add_row(code, str(n_players))
        console.print()
        console.print("  Active rooms:")
        console.print(t)
    else:
        console.print()
        console.print("  No active rooms -- you will be the first.")

    console.print()
    answer = Prompt.ask(
        "  Room code (4 digits, or Enter to create new)",
        default="",
    ).strip()

    if not answer:
        used = {code for code, _ in rooms}
        for _ in range(200):
            candidate = f"{random.randint(1000, 9999)}"
            if candidate not in used:
                return candidate
        return f"{random.randint(1000, 9999)}"

    return answer[:4].ljust(4, "0")


# ── Entry point ───────────────────────────────────────────────────────────────

async def run_client(args) -> None:
    from rich.console import Console
    from rich.prompt import Prompt

    console = Console()

    console.print()
    console.print("  HorizonProx POC -- Client Mode")
    console.print("  ================================")
    console.print()

    # ── Step 1: identity & hub ────────────────────────────────────────────────
    username: str = (getattr(args, "username", None) or "").strip()[:32]
    if not username:
        username = Prompt.ask("  Username").strip()[:32] or "Player"

    hub_addr: str = (getattr(args, "hub", None) or "").strip()
    if not hub_addr:
        hub_addr = Prompt.ask("  Hub server", default="localhost:9200").strip()

    if ":" in hub_addr:
        host, port_str = hub_addr.rsplit(":", 1)
        try:
            port = int(port_str)
        except ValueError:
            console.print(f"  [red]Invalid hub address: {hub_addr!r}[/]")
            return
    else:
        host, port = hub_addr, 9200

    # ── Step 2: audio devices ─────────────────────────────────────────────────
    # Only show wizard if not fully specified on the command line
    if not (getattr(args, "input_device", None) or getattr(args, "loopback", False)
            or getattr(args, "output_device", None)):
        _wizard_devices(console, args)

    # ── Step 3: proximity params ──────────────────────────────────────────────
    _wizard_proximity(console, args)

    # ── Step 4: summary before connecting ────────────────────────────────────
    console.print()
    console.rule("  Ready", style="green dim")
    console.print()
    console.print(f"  Username   : [bold]{username}[/bold]")
    console.print(f"  Hub        : {hub_addr}")
    console.print(f"  Telemetry  : 127.0.0.1:{args.telemetry_port}")
    console.print(
        f"  Proximity  : near={args.near} m  far={args.far} m"
        f"  curve={args.curve}  panning={'off' if args.no_panning else 'on'}"
    )
    console.print()

    # self_pos: [x, z, yaw, speed]  -- all four sent as STATE to peers
    self_pos: list[float] = [0.0, 0.0, 0.0, 0.0]
    telem_ok: list[bool] = [False]

    def on_state(s: CarState) -> None:
        self_pos[0] = s.x
        self_pos[1] = s.z
        self_pos[2] = s.yaw
        self_pos[3] = float(s.speed)
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
    app_loopback_idx  = getattr(args, "app_loopback_idx",  None)
    app_display_name  = getattr(args, "app_display_name",  None)
    app_pid           = getattr(args, "app_pid",           None)
    if app_loopback_idx is not None:
        engine.start_pair_app(
            pid=app_pid,
            loopback_idx=app_loopback_idx,
            display_name=app_display_name or "app",
            output_device=getattr(args, "output_device", None),
        )
    else:
        engine.start_pair(
            input_device=getattr(args, "input_device", None),
            output_device=getattr(args, "output_device", None),
            loopback=getattr(args, "loopback", False),
        )
    console.print(f"  Audio in  : {engine.input_label}")
    console.print(f"  Audio out : {engine.output_label}")

    peers: dict[int, PeerState] = {}
    self_id: int = 0

    try:
        console.print()
        console.print(f"  Connecting to {host}:{port}...")
        try:
            reader, writer = await asyncio.open_connection(host, port)
        except ConnectionRefusedError:
            console.print(
                f"  [red]Connection refused -- is the hub running at {host}:{port}?[/]"
            )
            return

        # Room selection (sends LIST, shows rooms, prompts)
        room_code = await _pick_room(reader, writer, console)

        # Send HELLO: 4B code + username
        hello_data = (
            room_code.encode("ascii")[:4].ljust(4, b"0")
            + username.encode("utf-8")[:32]
        )
        await _send(writer, C2H_HELLO, hello_data)

        # Receive WELCOME (or ERROR)
        try:
            msg_type, data = await asyncio.wait_for(_recv(reader), timeout=10.0)
        except asyncio.TimeoutError:
            console.print("  [red]Timed out waiting for WELCOME.[/]")
            writer.close()
            return

        if msg_type == H2C_ERROR:
            console.print(
                f"  [red]Hub error: {data.decode('utf-8', errors='replace')}[/]"
            )
            writer.close()
            return

        if msg_type != H2C_WELCOME or len(data) < 6:
            console.print("  [red]Unexpected response from hub.[/]")
            writer.close()
            return

        self_id = data[0]
        joined_code = data[1:5].decode("ascii", errors="replace")
        n_peers = data[5]
        offset = 6
        for _ in range(n_peers):
            if offset + 2 > len(data):
                break
            pid = data[offset]
            name_len = data[offset + 1]
            offset += 2
            name = data[offset: offset + name_len].decode("utf-8", errors="replace")
            offset += name_len
            peer_audio = engine.add_peer(f"peer_{pid}")
            peers[pid] = PeerState(id=pid, username=name, audio=peer_audio)

        console.print()
        console.print(
            f"  [green]Joined room [bold cyan]{joined_code}[/]![/]  "
            f"You are [bold]{username}[/bold] (id={self_id}), "
            f"{n_peers} peer(s) already here."
        )
        console.print()

        args._hub_addr = hub_addr

        await _client_session(
            reader, writer,
            username, joined_code, self_id,
            engine, peers,
            self_pos, telem_ok,
            args,
        )

    finally:
        engine.stop()
        await telem.stop()
        console.print("  Done.")
