"""
HorizonProx POC — Hub (room relay).

Stateless relay server. Clients create/join rooms by 4-digit code and stream
position+speed+audio; the hub only forwards data. All DSP (gain, pan, Doppler)
happens client-side.

Wire protocol (big-endian framing):
  [1B type] [2B payload_len] [payload]

C2H (client -> hub):
  0x01  LIST    empty payload -- request current room list
  0x02  HELLO   4B room-code (ASCII digits) + 1-32B UTF-8 username
  0x03  STATE   struct "<ffff"  x, z, yaw, speed (m/s)   -- 16 bytes
  0x04  AUDIO   1920 bytes int16 mono PCM

H2C (hub -> client):
  0x10  ROOM_LIST   n(u8) + [code(4B) + n_players(u8)] * n
  0x11  WELCOME     self_id(u8) + code(4B) + n_peers(u8) + [id(u8)+name_len(u8)+name]*n
  0x12  PEER_JOINED id(u8) + name_len(u8) + name_bytes
  0x13  PEER_LEFT   id(u8)
  0x14  PEER_STATE  id(u8) + struct "<ffff" x,z,yaw,speed  (17 bytes total)
  0x15  PEER_AUDIO  id(u8) + 1920 bytes PCM               (1921 bytes total)
  0x16  ERROR       UTF-8 message
"""
from __future__ import annotations

import asyncio
import logging
import struct
from dataclasses import dataclass, field

# ── Protocol constants ────────────────────────────────────────────────────────

C2H_LIST  = 0x01
C2H_HELLO = 0x02
C2H_STATE = 0x03
C2H_AUDIO = 0x04

H2C_ROOM_LIST   = 0x10
H2C_WELCOME     = 0x11
H2C_PEER_JOINED = 0x12
H2C_PEER_LEFT   = 0x13
H2C_PEER_STATE  = 0x14
H2C_PEER_AUDIO  = 0x15
H2C_ERROR       = 0x16

_HEADER       = struct.Struct(">BH")
_STATE_STRUCT = struct.Struct("<ffff")   # x, z, yaw, speed

_MAX_PLAYERS_PER_ROOM = 8

logger = logging.getLogger(__name__)


# ── Wire helpers (also imported by client.py) ─────────────────────────────────

async def _send(writer: asyncio.StreamWriter, msg_type: int, data: bytes) -> None:
    writer.write(_HEADER.pack(msg_type, len(data)) + data)
    await writer.drain()


async def _recv(reader: asyncio.StreamReader) -> tuple[int, bytes]:
    header = await reader.readexactly(_HEADER.size)
    msg_type, length = _HEADER.unpack(header)
    payload = await reader.readexactly(length)
    return msg_type, payload


# ── Data model ────────────────────────────────────────────────────────────────

@dataclass
class _Player:
    id: int
    username: str
    writer: asyncio.StreamWriter
    room_code: str = ""
    pos: list[float] = field(default_factory=lambda: [0.0, 0.0, 0.0, 0.0])

    def encode_name(self) -> bytes:
        name_bytes = self.username.encode("utf-8")[:32]
        return bytes([self.id, len(name_bytes)]) + name_bytes


@dataclass
class _Room:
    code: str
    players: dict[int, _Player] = field(default_factory=dict)


# ── Hub ───────────────────────────────────────────────────────────────────────

class Hub:
    def __init__(self) -> None:
        self._rooms: dict[str, _Room] = {}
        self._next_id: int = 1

    # ── helpers ───────────────────────────────────────────────────────────────

    def _alloc_id(self) -> int:
        for _ in range(254):
            candidate = self._next_id
            self._next_id = (self._next_id % 254) + 1
            in_use = any(candidate in r.players for r in self._rooms.values())
            if not in_use:
                return candidate
        raise RuntimeError("No available player IDs (server full)")

    def _room_list_payload(self) -> bytes:
        rooms = list(self._rooms.values())
        body = bytes([min(len(rooms), 255)])
        for r in rooms:
            body += r.code.encode("ascii") + bytes([min(len(r.players), 255)])
        return body

    async def _room_broadcast(
        self,
        room: _Room,
        msg_type: int,
        data: bytes,
        exclude_id: int,
    ) -> None:
        for pid, player in list(room.players.items()):
            if pid == exclude_id:
                continue
            try:
                await _send(player.writer, msg_type, data)
            except Exception:
                pass  # player's own handler will clean up

    # ── client handler ────────────────────────────────────────────────────────

    async def handle_client(
        self,
        reader: asyncio.StreamReader,
        writer: asyncio.StreamWriter,
    ) -> None:
        addr = writer.get_extra_info("peername", ("?", 0))
        player: _Player | None = None

        try:
            # Pre-join phase: accept any number of LIST requests, then HELLO
            while True:
                try:
                    msg_type, data = await asyncio.wait_for(
                        _recv(reader), timeout=30.0
                    )
                except asyncio.TimeoutError:
                    logger.warning("%s:%s timed out before HELLO", *addr)
                    return

                if msg_type == C2H_LIST:
                    await _send(writer, H2C_ROOM_LIST, self._room_list_payload())
                    continue

                if msg_type == C2H_HELLO:
                    break

                await _send(writer, H2C_ERROR, b"Send LIST or HELLO first")
                return

            # Parse HELLO
            if len(data) < 5:
                await _send(writer, H2C_ERROR, b"HELLO too short (need 4B code + name)")
                return

            code = data[:4].decode("ascii", errors="replace").strip()
            username = data[4:36].decode("utf-8", errors="replace").strip()
            if not username:
                username = f"player_{addr[1]}"

            # Create or join room
            if code not in self._rooms:
                self._rooms[code] = _Room(code=code)
                logger.info("Room %s created by %s from %s:%s", code, username, *addr)

            room = self._rooms[code]

            if len(room.players) >= _MAX_PLAYERS_PER_ROOM:
                await _send(
                    writer, H2C_ERROR,
                    f"Room {code} is full (max {_MAX_PLAYERS_PER_ROOM})".encode(),
                )
                return

            pid = self._alloc_id()
            player = _Player(id=pid, username=username, writer=writer, room_code=code)

            # Send WELCOME: self_id + code(4B) + n_peers + [encode_name]*n
            welcome = bytes([pid]) + code.encode("ascii") + bytes([len(room.players)])
            for existing in room.players.values():
                welcome += existing.encode_name()
            await _send(writer, H2C_WELCOME, welcome)

            # Announce to existing room members
            await self._room_broadcast(
                room, H2C_PEER_JOINED, player.encode_name(), exclude_id=pid
            )

            # Register
            room.players[pid] = player
            logger.info(
                "Player joined: %s (id=%d) room=%s from %s:%s  [%d in room]",
                username, pid, code, *addr, len(room.players),
            )

            # Main relay loop
            while True:
                try:
                    msg_type, data = await _recv(reader)
                except (asyncio.IncompleteReadError, ConnectionResetError, EOFError):
                    break

                if msg_type == C2H_STATE and len(data) >= 16:
                    player.pos = list(_STATE_STRUCT.unpack_from(data))
                    await self._room_broadcast(
                        room, H2C_PEER_STATE,
                        bytes([pid]) + data[:16],
                        exclude_id=pid,
                    )

                elif msg_type == C2H_AUDIO:
                    await self._room_broadcast(
                        room, H2C_PEER_AUDIO,
                        bytes([pid]) + data,
                        exclude_id=pid,
                    )

                elif msg_type == C2H_LIST:
                    await _send(writer, H2C_ROOM_LIST, self._room_list_payload())

        except Exception as exc:
            logger.error("Unexpected error for %s:%s: %s", *addr, exc)

        finally:
            if player is not None:
                code = player.room_code
                room = self._rooms.get(code)
                if room is not None and player.id in room.players:
                    del room.players[player.id]
                    logger.info(
                        "Player left: %s (id=%d) room=%s  [%d in room]",
                        player.username, player.id, code, len(room.players),
                    )
                    await self._room_broadcast(
                        room, H2C_PEER_LEFT,
                        bytes([player.id]),
                        exclude_id=player.id,
                    )
                    if not room.players:
                        del self._rooms[code]
                        logger.info("Room %s deleted (empty)", code)
            try:
                writer.close()
                await writer.wait_closed()
            except Exception:
                pass


# ── Entry point ───────────────────────────────────────────────────────────────

async def run_hub(args) -> None:
    import sys
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")

    hub = Hub()
    server = await asyncio.start_server(
        hub.handle_client,
        "0.0.0.0",
        args.port,
    )
    print()
    print("  HorizonProx POC -- Hub Server")
    print("  ==============================")
    print()
    print(f"  Listening on TCP 0.0.0.0:{args.port}")
    print(f"  Players connect with:  --hub <your-IP>:{args.port}")
    print()
    print("  Rooms created on first join, deleted when empty.")
    print(f"  Max {_MAX_PLAYERS_PER_ROOM} players per room.")
    print()
    print("  Waiting for connections...  (Ctrl+C to stop)")
    print()
    async with server:
        await server.serve_forever()
