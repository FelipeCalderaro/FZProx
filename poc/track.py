"""
Telemetry tracker — monitor and log raw Forza UDP packets in real-time.

  uv run python -m poc track                           # live display only
  uv run python -m poc track --log telemetry           # + write telemetry.csv / telemetry_first.hex

Key diagnostic features:
  - Accepts packets of ANY size (not just 324), so you can see if FH6 sends
    a different-length packet than the FH5 spec assumed.
  - Logs every packet's raw data as float32 / int32 at EVERY 4-byte offset.
    Open the CSV in Excel, filter to rows where speed > 0, and look at which
    columns change — those are where position data actually lives in FH6.
  - Writes a full hex+float dump of the first packet to a .hex file.
  - Live display shows which fields have changed since tracking started.

FH6 inserted 3 new int32 fields at 232-243, shifting the Car Dash block +12 bytes.
Position is at 244/248/252, speed at 256, yaw/pitch/roll at 56/60/64 (sled block).
"""
from __future__ import annotations

import asyncio
import csv
import math
import struct
import time
from collections import deque
from datetime import datetime, timezone
from pathlib import Path


# ── Raw UDP receiver (any packet size) ───────────────────────────────────────

class _RawProtocol(asyncio.DatagramProtocol):
    def __init__(self, on_packet) -> None:
        self._on_packet = on_packet

    def connection_made(self, transport) -> None:
        pass

    def datagram_received(self, data: bytes, _addr) -> None:
        self._on_packet(data)

    def error_received(self, exc: Exception) -> None:
        pass


# ── Packet logger (CSV + hex dump) ───────────────────────────────────────────

class PacketLog:
    """
    Writes two files per run (when --log is given):

      PREFIX.csv        — one row per packet.  Columns:
                            wall_iso, mono_s, pkt_num, pkt_size,
                            parsed_* (fields from our known offsets),
                            off_NNN  (float32 at every 4-byte offset in the packet).
                          Filter in Excel on speed > 0 and look for columns that
                          change — those are the real position fields in FH6.

      PREFIX_pkt0.hex   — annotated hex + float dump of the very first packet.
      PREFIX_pktN.hex   — same for every packet that has a NEW length (captures
                          format variants if the game sends multiple sizes).
    """

    # FH6 offsets. Sled block (0-231) unchanged from FH5. Car Dash block shifted +12
    # bytes because FH6 added 3 new int32 fields at 232-243. Yaw/Pitch/Roll are in
    # the sled block at 56/60/64 (same in both FH5 and FH6).
    _KNOWN = {
        "is_race_on": ("<i",  0),
        "ts_ms":      ("<I",  4),
        "yaw":        ("<f",  56),
        "pitch":      ("<f",  60),
        "roll":       ("<f",  64),
        "x":          ("<f",  244),
        "y":          ("<f",  248),
        "z":          ("<f",  252),
        "speed":      ("<f",  256),
        "power_w":    ("<f",  260),
        "torque_nm":  ("<f",  264),
    }

    def __init__(self, prefix: str) -> None:
        self._prefix = prefix
        self._csv_path = Path(f"{prefix}.csv")
        self._csv_f = self._csv_path.open("w", newline="", encoding="utf-8")
        self._writer: csv.DictWriter | None = None
        self._pkt_count = 0
        self._seen_sizes: set[int] = set()
        self._t0 = time.monotonic()

    def write(self, data: bytes) -> None:
        now_wall = datetime.now(timezone.utc).isoformat()
        now_mono = time.monotonic() - self._t0
        self._pkt_count += 1
        n = len(data)

        # Build row dict
        row: dict = {
            "wall_iso":  now_wall,
            "mono_s":    f"{now_mono:.4f}",
            "pkt_num":   self._pkt_count,
            "pkt_size":  n,
        }

        # Known parsed fields (best-effort — silently 0 if packet too short)
        for name, (fmt, off) in self._KNOWN.items():
            size = struct.calcsize(fmt)
            if off + size <= n:
                (val,) = struct.unpack_from(fmt, data, off)
                row[f"parsed_{name}"] = f"{val:.6g}"
            else:
                row[f"parsed_{name}"] = ""

        # All 4-byte offsets as float32 and int32
        for off in range(0, n - 3, 4):
            (fval,) = struct.unpack_from("<f", data, off)
            (ival,) = struct.unpack_from("<i", data, off)
            row[f"f{off:03d}"] = f"{fval:.6g}"
            row[f"i{off:03d}"] = str(ival)

        # Write CSV header on first packet
        if self._writer is None:
            self._writer = csv.DictWriter(self._csv_f, fieldnames=list(row.keys()))
            self._writer.writeheader()
        self._writer.writerow(row)
        self._csv_f.flush()

        # Hex dump for first packet and any new size
        if self._pkt_count == 1 or n not in self._seen_sizes:
            label = "pkt0" if self._pkt_count == 1 else f"pkt{self._pkt_count}_size{n}"
            self._write_hex_dump(data, label)
            self._seen_sizes.add(n)

    def close(self) -> None:
        self._csv_f.close()

    def _write_hex_dump(self, data: bytes, label: str) -> None:
        path = Path(f"{self._prefix}_{label}.hex")
        lines: list[str] = [
            f"# Packet hex dump — {label}  size={len(data)} bytes",
            f"# Captured: {datetime.now(timezone.utc).isoformat()}",
            "#",
            "# offset  hex (bytes grouped by 4)               as float32          as int32",
            "# ──────  ──────────────────────────────────────  ──────────────────  ──────────",
        ]
        for off in range(0, len(data), 4):
            chunk = data[off: off + 4]
            if len(chunk) < 4:
                hex_str = " ".join(f"{b:02x}" for b in chunk)
                lines.append(f"  {off:04x}   {hex_str}")
                continue
            hex_str = " ".join(f"{b:02x}" for b in chunk)
            (fval,) = struct.unpack_from("<f", chunk)
            (ival,) = struct.unpack_from("<i", chunk)
            # Mark offsets that match our spec assumptions
            note = ""
            for name, (_, spec_off) in self._KNOWN.items():
                if spec_off == off:
                    note = f"  ← {name}"
                    break
            lines.append(f"  {off:04x}   {hex_str}   {fval:>18.6g}  {ival:>10}{note}")
        path.write_text("\n".join(lines) + "\n", encoding="utf-8")


# ── Per-field change tracker ──────────────────────────────────────────────────

class _FieldTracker:
    """Tracks min/max of a float value across packets to detect whether it changes."""

    def __init__(self) -> None:
        self.mn: float = math.inf
        self.mx: float = -math.inf
        self.last: float = 0.0

    def update(self, v: float) -> None:
        if v < self.mn:
            self.mn = v
        if v > self.mx:
            self.mx = v
        self.last = v

    @property
    def spread(self) -> float:
        return self.mx - self.mn if self.mn != math.inf else 0.0

    @property
    def changed(self) -> bool:
        return self.spread > 0.001


# ── Stats accumulator ─────────────────────────────────────────────────────────

class _Stats:
    def __init__(self) -> None:
        self.count: int = 0
        self.total_dist: float = 0.0
        self.stale: bool = True
        self._times: deque[float] = deque(maxlen=120)
        self.sizes: dict[int, int] = {}   # size → count
        self.last_raw: bytes | None = None
        self.prev_raw: bytes | None = None

        # Per-field trackers for known offsets
        self.fields: dict[str, _FieldTracker] = {
            name: _FieldTracker() for name in PacketLog._KNOWN
        }

    def update(self, data: bytes) -> None:
        self._times.append(time.monotonic())
        n = len(data)
        self.sizes[n] = self.sizes.get(n, 0) + 1
        self.prev_raw = self.last_raw
        self.last_raw = data
        self.count += 1
        self.stale = False

        for name, (fmt, off) in PacketLog._KNOWN.items():
            size = struct.calcsize(fmt)
            if off + size <= n:
                (val,) = struct.unpack_from(fmt, data, off)
                self.fields[name].update(float(val))

        # Accumulate XZ distance using FH6 position offsets (244=X, 252=Z)
        if self.prev_raw and len(self.prev_raw) >= 256:
            (px,) = struct.unpack_from("<f", self.prev_raw, 244)
            (pz,) = struct.unpack_from("<f", self.prev_raw, 252)
            (cx,) = struct.unpack_from("<f", data, 244)
            (cz,) = struct.unpack_from("<f", data, 252)
            self.total_dist += math.sqrt((cx - px) ** 2 + (cz - pz) ** 2)

    def mark_stale(self) -> None:
        self.stale = True

    @property
    def rate_hz(self) -> float:
        if len(self._times) < 2:
            return 0.0
        span = self._times[-1] - self._times[0]
        return (len(self._times) - 1) / span if span > 0 else 0.0

    def get_parsed(self, _name: str, fmt: str, off: int) -> float | None:
        if self.last_raw and off + struct.calcsize(fmt) <= len(self.last_raw):
            (v,) = struct.unpack_from(fmt, self.last_raw, off)
            return float(v)
        return None


# ── Entry point ───────────────────────────────────────────────────────────────

async def run_track(args) -> None:
    stats = _Stats()
    log: PacketLog | None = None

    if getattr(args, "log", None):
        prefix = args.log
        log = PacketLog(prefix)
        print(f"  Logging to: {prefix}.csv  |  {prefix}_pkt0.hex  (and more on size change)")

    def on_packet(data: bytes) -> None:
        stats.update(data)
        if log:
            log.write(data)

    # Raw UDP receiver — accepts ANY packet size
    loop = asyncio.get_running_loop()
    transport, _ = await loop.create_datagram_endpoint(
        lambda: _RawProtocol(on_packet),
        local_addr=("127.0.0.1", args.telemetry_port),
    )

    print(f"  Listening on 127.0.0.1:{args.telemetry_port}  — Ctrl+C to quit")
    if not getattr(args, "log", None):
        print("  Tip: add --log telemetry to save a full CSV + hex dump for offset analysis")
    print()

    try:
        try:
            from rich.live import Live
            from rich.table import Table
            from rich.text import Text
            await _rich_loop(stats, args, Live, Table, Text)
        except ImportError:
            await _plain_loop(stats, args)
    finally:
        transport.close()
        if log:
            log.close()
            print(f"\n  Log saved → {args.log}.csv")


# ── Rich live display ─────────────────────────────────────────────────────────

async def _rich_loop(stats: _Stats, args, Live, Table, Text) -> None:
    def _render() -> Table:
        rate = stats.rate_hz
        sizes_str = "  |  ".join(f"{sz}B ×{cnt}" for sz, cnt in sorted(stats.sizes.items()))

        if stats.stale or stats.last_raw is None:
            status = Text("○  WAITING / STALE", style="bold red")
            size_txt = Text("—", style="dim")
        else:
            status = Text(f"●  LIVE   {rate:.1f} Hz", style="bold green")
            main_size = max(stats.sizes, key=stats.sizes.get)
            size_color = "green" if main_size == 324 else "yellow"
            size_txt = Text(sizes_str, style=size_color)

        # Packet size warning
        if stats.sizes and max(stats.sizes) != 324:
            size_warn = Text(
                "  ⚠  Expected 324 B — FH6 may use a different format. Check the .hex file.",
                style="bold yellow",
            )
        else:
            size_warn = Text("", style="dim")

        t = Table(
            title=f"  Forza Telemetry  —  127.0.0.1:{args.telemetry_port}",
            show_header=True,
            header_style="bold dim",
            border_style="dim blue",
            padding=(0, 1),
        )
        t.add_column("Field",         style="bold cyan",  width=18, no_wrap=True)
        t.add_column("Value",         style="white",       width=28, no_wrap=True)
        t.add_column("Min … Max (since start)", style="dim", width=22, no_wrap=True)
        t.add_column("Changed?",      style="dim",         width=10, no_wrap=True)

        t.add_row("Status",       status,    "",          "")
        t.add_row("Packet size",  size_txt,  size_warn,   "")
        t.add_row("Packets rx",   str(stats.count), f"dist tracked: {stats.total_dist:.1f} m", "")
        t.add_row("", "", "", "")

        def _row(label: str, key: str, unit: str = "", extra: str = "") -> None:
            ft = stats.fields[key]
            val = ft.last
            changed = ft.changed
            if key == "yaw":
                extra = f"  ({math.degrees(val):+.1f}°)"
            val_str = f"{val:+.4f} {unit}{extra}"
            spread_str = f"{ft.mn:.4g} … {ft.mx:.4g}" if ft.mn != math.inf else "—"
            chg_txt = Text("YES ✓", style="bold green") if changed else Text("no", style="dim red")
            t.add_row(label, val_str, spread_str, chg_txt)

        t.add_row("[bold]POSITION[/bold]", "", "", "")
        _row("  X  (off 244)", "x", "m")
        _row("  Y  (off 248)", "y", "m  (vertical)")
        _row("  Z  (off 252)", "z", "m")
        t.add_row("", "", "", "")
        t.add_row("[bold]MOTION[/bold]", "", "", "")
        _row("  Speed (off 256)", "speed", "m/s")
        _row("  Yaw   (off  56)", "yaw",   "rad")
        _row("  Pitch (off  60)", "pitch", "rad")
        _row("  Roll  (off  64)", "roll",  "rad")
        t.add_row("", "", "", "")
        t.add_row("[bold]FLAGS[/bold]", "", "", "")
        is_race = int(stats.fields["is_race_on"].last)
        t.add_row(
            "  IsRaceOn (off 0)",
            Text("Yes", style="green") if is_race else Text("No", style="dim"),
            f"ts_ms: {int(stats.fields['ts_ms'].last)}", "",
        )

        # Copyable peer-pos hint — shown whenever we have a valid position
        x_val = stats.fields["x"].last
        z_val = stats.fields["z"].last
        if stats.fields["x"].changed or (x_val != 0.0 and z_val != 0.0):
            t.add_row("", "", "", "")
            t.add_row(
                Text("  ── Use as peer-pos ──", style="dim"),
                Text(
                    f"--peer-x {x_val:.0f} --peer-z {z_val:.0f}",
                    style="bold white",
                ),
                Text("(copy this, then Ctrl+C)", style="dim"),
                "",
            )

        if not stats.fields["x"].changed and stats.fields["speed"].changed:
            t.add_row("", "", "", "")
            t.add_row(
                Text("⚠  DIAGNOSIS", style="bold yellow"),
                Text(
                    "Speed changes but X/Y/Z don't.\n"
                    "Check Forza Data Out is enabled and the port matches.",
                    style="yellow",
                ),
                "", "",
            )

        return t

    try:
        with Live(_render(), refresh_per_second=10, screen=False) as live:
            while True:
                await asyncio.sleep(0.1)
                live.update(_render())
    except KeyboardInterrupt:
        pass


# ── Plain fallback ────────────────────────────────────────────────────────────

async def _plain_loop(stats: _Stats, _args) -> None:
    import sys
    print(f"  {'STATUS':<8} {'SIZE':>5} {'PKTS':>6}  {'X':>10} {'Y':>10} {'Z':>10}  "
          f"{'SPEED':>8} {'YAW°':>7}  {'HZ':>5}  CHANGED")
    print("  " + "─" * 95)
    try:
        while True:
            await asyncio.sleep(0.1)
            if stats.last_raw is None:
                sys.stdout.write("\r  [waiting for packets…]")
                sys.stdout.flush()
                continue
            main_size = max(stats.sizes, key=stats.sizes.get)
            f = stats.fields
            x_chg = "X" if f["x"].changed else "."
            y_chg = "Y" if f["y"].changed else "."
            z_chg = "Z" if f["z"].changed else "."
            s_chg = "S" if f["speed"].changed else "."
            sys.stdout.write(
                f"\r  {'STALE' if stats.stale else 'LIVE ':<8} {main_size:>5} {stats.count:>6}"
                f"  {f['x'].last:>+10.3f} {f['y'].last:>+10.3f} {f['z'].last:>+10.3f}"
                f"  {f['speed'].last:>8.2f}  {math.degrees(f['yaw'].last):>+7.1f}"
                f"  {stats.rate_hz:>5.1f}  {x_chg}{y_chg}{z_chg}{s_chg}  "
            )
            sys.stdout.flush()
    except KeyboardInterrupt:
        print()
