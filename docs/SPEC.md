# HorizonProx POC — Complete Technical Specification

**Purpose:** This document captures every design decision, protocol detail, algorithm, and
bug fix from the Python POC so the system can be reimplemented faithfully as a Flutter
desktop application (Windows-first; hub must also be portable).

---

## Table of Contents

1. [System Overview](#1-system-overview)
2. [Architecture](#2-architecture)
3. [Wire Protocol](#3-wire-protocol)
4. [Hub](#4-hub)
5. [Client](#5-client)
6. [Telemetry — Forza Data Out](#6-telemetry--forza-data-out)
7. [Audio Subsystem](#7-audio-subsystem)
8. [Per-Process Audio Capture (Windows)](#8-per-process-audio-capture-windows)
9. [Proximity Math](#9-proximity-math)
10. [Doppler Effect](#10-doppler-effect)
11. [Bugs Fixed During Development](#11-bugs-fixed-during-development)
12. [Flutter Implementation Notes](#12-flutter-implementation-notes)

---

## 1. System Overview

HorizonProx is a proximity voice / audio chat overlay for Forza Horizon. Players drive
in-game while their audio (mic, loopback, or a specific app like Spotify) is transmitted
to a central relay (the **hub**). Every client applies distance-based volume attenuation,
stereo panning, and Doppler pitch-shift **locally** using its own Forza telemetry. The
hub is a dumb relay — it never processes audio.

Key design decisions:
- **All DSP is client-side.** The hub sees raw PCM bytes; it never interprets them.
- **No positional audio codec.** Audio is 960-sample mono int16 PCM frames (20 ms @ 48 kHz).
- **Stateless rooms.** A room is created on first join and deleted when the last player leaves.
- **Per-process audio capture** (Windows 10 2004+). Users can route a specific app
  (Spotify, game, etc.) into the proximity pipeline without a virtual cable.

---

## 2. Architecture

```
┌──────────────────────────────────────────────────────────┐
│                         CLIENT                           │
│                                                          │
│  Forza UDP  ──►  TelemetryReceiver  ──►  self_pos[]     │
│                                                          │
│  AudioCapture ──► captured deque ──► Sender ──► TCP     │
│  (mic / loopback / per-process WASAPI)                   │
│                                                          │
│  TCP ──► Receiver ──► per-peer PCM ──► Doppler ──►      │
│                                      GainMixer ──► out  │
│                                                          │
│  GainUpdate loop (60 Hz):                                │
│    distance → gain → EMA smooth → stereo_gains(L, R)    │
└──────────────────────────────────────────────────────────┘
               │                         ▲
               │  TCP (big-endian frames) │
               ▼                         │
┌──────────────────────────────────────────────────────────┐
│                          HUB                             │
│                                                          │
│  asyncio.start_server (TCP 0.0.0.0:9200 default)        │
│  Per-client coroutine: pre-join phase → relay loop       │
│  _Room: dict[player_id → _Player]                        │
│  _room_broadcast(): fan-out to all room members          │
└──────────────────────────────────────────────────────────┘
```

---

## 3. Wire Protocol

All messages share a 3-byte header followed by a variable-length payload.

### 3.1 Framing

```
[1 byte: msg_type] [2 bytes: payload_len, big-endian] [payload_len bytes: payload]
```

Python: `struct.Struct(">BH")` — total overhead is 3 bytes per message.

### 3.2 Client → Hub (C2H)

| Code | Name    | Payload layout                                        | Notes                                |
|------|---------|-------------------------------------------------------|--------------------------------------|
| 0x01 | LIST    | *(empty)*                                             | Request current room list            |
| 0x02 | HELLO   | `[4B ASCII room-code] [1–32B UTF-8 username]`         | Join or create a room                |
| 0x03 | STATE   | `struct "<ffff"` → x, z, yaw, speed (m/s) = 16 bytes | Player's world position              |
| 0x04 | AUDIO   | 1920 bytes of int16 mono PCM @ 48 kHz                 | One 20 ms audio frame                |

### 3.3 Hub → Client (H2C)

| Code | Name         | Payload layout                                                              | Notes                               |
|------|--------------|-----------------------------------------------------------------------------|-------------------------------------|
| 0x10 | ROOM_LIST    | `n(u8) + [code(4B ASCII) + n_players(u8)] × n`                             | Response to LIST                    |
| 0x11 | WELCOME      | `self_id(u8) + code(4B) + n_peers(u8) + [id(u8)+name_len(u8)+name] × n`   | Sent after successful HELLO         |
| 0x12 | PEER_JOINED  | `id(u8) + name_len(u8) + name_bytes`                                        | New player arrived in room          |
| 0x13 | PEER_LEFT    | `id(u8)`                                                                    | Player disconnected                 |
| 0x14 | PEER_STATE   | `id(u8) + struct "<ffff"` x,z,yaw,speed = 17 bytes                         | Another player's position update    |
| 0x15 | PEER_AUDIO   | `id(u8) + 1920 bytes PCM`  = 1921 bytes total                               | Another player's audio frame        |
| 0x16 | ERROR        | UTF-8 error message                                                         | Fatal — client should disconnect    |

### 3.4 Timing

- **STATE** is sent roughly every 4 audio frames (~80 ms / ~12.5 Hz).
- **AUDIO** is sent every time a 960-sample frame is captured (~50 fps / 20 ms intervals).
- The hub relays AUDIO and STATE immediately (no buffering, no reordering).

### 3.5 Audio frame dimensions

| Constant        | Value  | Meaning                       |
|-----------------|--------|-------------------------------|
| `SAMPLE_RATE`   | 48000  | Hz                            |
| `FRAME_SAMPLES` | 960    | samples per frame (20 ms)     |
| `PCM_BYTES`     | 1920   | bytes per frame (int16 × 960) |

---

## 4. Hub

### 4.1 Connection lifecycle

```
Client connects
    └─► pre-join phase (30 s timeout)
        ├─ 0x01 LIST  → respond with ROOM_LIST (can repeat)
        └─ 0x02 HELLO → validate → enter relay loop
                         ├─ room full (≥8) → 0x16 ERROR, close
                         └─ OK → alloc player_id → send WELCOME
                                 → broadcast PEER_JOINED to room
                                 → enter main relay loop
                                     ├─ 0x03 STATE → update pos, broadcast PEER_STATE
                                     ├─ 0x04 AUDIO → broadcast PEER_AUDIO
                                     └─ 0x01 LIST  → respond with ROOM_LIST
Client disconnects (EOF / reset)
    └─► deregister → broadcast PEER_LEFT → delete room if empty
```

### 4.2 Player ID allocation

- IDs are integers `1–254` (0 and 255 are reserved).
- Allocated with a rotating counter; guaranteed unique across all rooms.
- ID 0 is never assigned — used as a sentinel.

### 4.3 Room management

- `_rooms: dict[str, _Room]` — keyed by 4-character ASCII room code.
- Room is created automatically when the first player sends a matching HELLO.
- Room is deleted when the last player leaves.
- Max 8 players per room (configurable via `_MAX_PLAYERS_PER_ROOM = 8`).

### 4.4 Broadcast

`_room_broadcast(room, msg_type, data, exclude_id)` — async fan-out. Sends to every
player in the room except `exclude_id`. Per-player write errors are silently swallowed
(the player's own handler coroutine will clean up on the next read failure).

### 4.5 Hub entry point

```python
asyncio.start_server(hub.handle_client, "0.0.0.0", args.port)
# Default port: 9200
```

The hub never reads Forza telemetry. It has no concept of proximity or audio processing.

---

## 5. Client

### 5.1 Startup wizard (CLI / TUI)

The client runs an interactive terminal wizard before connecting:

1. **Identity** — username (prompted if not passed via `--username`) and hub address
   (prompted if not passed via `--hub HOST:PORT`, default `localhost:9200`).

2. **Audio Input** (device wizard) — presented as a table:
   - Row **A** (default, press Enter): App capture — scans running audio sessions and lets
     the user pick a specific program.
   - Numbered rows: sounddevice device list. If the chosen device is output-only, loopback
     capture is automatically enabled.

3. **App selection** (if A was chosen):
   - Calls `_build_app_list()` to enumerate active Windows audio sessions via
     `IAudioSessionManager2`.
   - Displays app name, device name, and "sharing" (how many other apps share that device).
   - User picks by number; default is 0 (first app).
   - Isolation strategy: per-process WASAPI capture (preferred); device loopback fallback.

4. **Audio Output** — sounddevice output device list; Enter = system default.

5. **Proximity parameters** — prompted with defaults:
   - `near` (m) — full-volume radius (default 10 m for client mode)
   - `far`  (m) — silence radius     (default 80 m for client mode)
   - `curve`    — exponent (default 2.0 = inverse-square)
   - `panning`  — on/off (default on)

6. **Summary** printed; audio engine and telemetry started; TCP connection opened.

### 5.2 Room selection

After TCP connection, before HELLO:

1. Client sends `LIST (0x01)`.
2. Hub responds with `ROOM_LIST (0x10)`.
3. If rooms exist, they are shown with player counts.
4. User types a 4-digit code to join an existing room, or presses Enter to get a
   randomly generated code (avoids collisions with existing rooms).

### 5.3 Join handshake

```
Client ──► HELLO [room_code(4B) + username(UTF-8, ≤32B)]
Hub    ──► WELCOME [self_id(1B) + code(4B) + n_peers(1B) + peer_list]
           OR ERROR (room full, etc.)
```

The WELCOME payload contains the current peer list so the client can pre-populate
its peer map before streaming starts.

### 5.4 Session (post-join): three concurrent tasks

```
asyncio.gather(sender, receiver, gain_and_tui)
```

Any task completing (network drop, Ctrl+C) cancels the others and exits.

#### Sender

```
loop every ~5 ms:
    frame = engine.pop_capture()
    if frame:
        send AUDIO(0x04, frame.tobytes())
        pos_counter++
        if pos_counter >= 4:
            send STATE(0x03, pack("<ffff", x, z, yaw, speed))
```

#### Receiver

Handles all incoming H2C messages:

| Message     | Action                                                                               |
|-------------|--------------------------------------------------------------------------------------|
| PEER_AUDIO  | Compute Doppler factor from latest peer position → `apply_doppler(pcm, df)` → enqueue to `PeerAudio` buffer |
| PEER_STATE  | Update `peers[id].pos`                                                               |
| PEER_JOINED | Create `PeerState`, call `engine.add_peer()`                                         |
| PEER_LEFT   | Call `engine.remove_peer()`, delete from `peers`                                     |

#### Gain + TUI loop (60 Hz)

For each peer every iteration:
1. `d = xz_distance(self_x, self_z, peer_x, peer_z)`
2. `raw_gain = gain_for_distance(d, near, far, curve)`
3. `raw_pan  = pan_for_bearing(peer_x-self_x, peer_z-self_z, self_yaw)` (or 0 if panning off)
4. `(sg, sp) = smooth.update(raw_gain, raw_pan)`  ← EMA smoothing
5. `(gain_L, gain_R) = stereo_gains(sg, sp)`
6. `peer.audio.set_gains(gain_L, gain_R)`

TUI panel is refreshed every 6 ticks (~10 Hz) using Rich Live.

### 5.5 TUI panel columns

| Column  | Content                                           |
|---------|---------------------------------------------------|
| Player  | username (truncated to 18 chars)                  |
| Dist    | XZ distance in metres                             |
| Volume  | ASCII bar + numeric gain [0.00–1.00]              |
| Pan     | signed pan value [-1.00 to +1.00]                 |
| Doppler | pitch multiplier (1.000 = no shift)               |
| Buf     | playback buffer depth in ms                       |

Peers sorted by distance (nearest first).

### 5.6 PeerAudio ring buffer

Each peer has a `PeerAudio` object:
- `_buf: deque(maxlen=12)` — holds up to 12 frames = 240 ms.
- `gain_l`, `gain_r` — set by the gain loop; read by the audio mixer callback.
- `put(frame)` / `get() → frame | None` — thread-safe via GIL + atomic deque ops.
- `buffer_ms` — current fill level in ms (shown in TUI).

### 5.7 Audio mixer callback

Runs on the sounddevice PortAudio thread (real-time, no blocking):

```python
def _out_cb(outdata, frames, time, status):
    left  = zeros(frames)
    right = zeros(frames)
    for peer in peers.values():
        frame = peer.get()
        if frame:
            s = frame / 32768.0
            left  += s * peer.gain_l
            right += s * peer.gain_r
    clip(left,  -1, 1)
    clip(right, -1, 1)
    outdata[:,0] = (left  * 32767).astype(int16)
    outdata[:,1] = (right * 32767).astype(int16)
```

---

## 6. Telemetry — Forza Data Out

### 6.1 Packet format

Forza Horizon 6 (FH6) uses a 324-byte UDP packet, little-endian throughout.

```
Offset  Size  Type     Field
------  ----  -------  -----
0       4     int32    IsRaceOn  (0 = in menus, 1 = in race/freeroam)
4       4     uint32   TimestampMS
56      4     float32  Yaw       (radians; sin(yaw)=X dir, cos(yaw)=Z dir)
60      4     float32  Pitch
64      4     float32  Roll
244     4     float32  PositionX (metres, world space)
248     4     float32  PositionY (metres, vertical)
252     4     float32  PositionZ (metres, world space)
256     4     float32  Speed     (m/s)
```

**FH6 vs FH5 difference:** FH6 inserted 3 new int32 fields at offsets 232–243, shifting
the Car Dash block (position, speed) by +12 bytes. The Sled block (yaw/pitch/roll)
was not moved.

### 6.2 Parser

```python
def parse_packet(buf: bytes) -> CarState | None:
    if len(buf) != 324:
        return None
    x, y, z  = unpack_from("<fff", buf, 244)
    speed,    = unpack_from("<f",   buf, 256)
    yaw,      = unpack_from("<f",   buf, 56)
    pitch,    = unpack_from("<f",   buf, 60)
    roll,     = unpack_from("<f",   buf, 64)
    is_race,  = unpack_from("<i",   buf, 0)
    ts_ms,    = unpack_from("<I",   buf, 4)
    return CarState(x, y, z, yaw, pitch, roll, speed, bool(is_race), ts_ms)
```

### 6.3 EMA smoothing

Position and orientation are smoothed with α = 0.3:

```
smoothed = 0.3 * new + 0.7 * previous
```

Applied independently to x, y, z, yaw, pitch, roll, speed.

### 6.4 Stale detection

If no packet arrives for 500 ms, `on_stale()` is called and the client TUI shows
"origin (no Forza telemetry)". The player remains at their last known position.

### 6.5 Transport

UDP, `asyncio.DatagramProtocol`, listening on `127.0.0.1:<port>` (default 9988).
Forza must have **Data Out** enabled: Settings → HUD and gameplay → Data Out → IP
`127.0.0.1`, Port `9988`, format "Car Dash".

### 6.6 Coordinate system

- **X** — world East/West
- **Y** — vertical (ignored for proximity audio; we use XZ plane only)
- **Z** — world North/South
- **Yaw** — heading in radians; `sin(yaw)` = X component, `cos(yaw)` = Z component

---

## 7. Audio Subsystem

### 7.1 Constants

```
SAMPLE_RATE     = 48000   Hz
FRAME_SAMPLES   = 960     samples  (20 ms)
PCM_BYTES       = 1920    bytes
MAX_BUFFER_FRAMES = 12    (~240 ms)
```

### 7.2 Capture modes

| Mode                  | Class                 | Backend          | Notes                                   |
|-----------------------|-----------------------|------------------|-----------------------------------------|
| Microphone / line-in  | sounddevice InputStream | PortAudio/WASAPI | Default input; any enumerated device    |
| System loopback       | `_LoopbackCapture`    | soundcard (WASAPI loopback) | Captures all audio on an output device |
| App capture (isolated)| `_WASAPIProcessCapture` | WASAPI ActivateAudioInterfaceAsync | Per-process, Windows 10 2004+ only     |
| App capture (fallback)| `_AppCapture`         | pyaudiowpatch WASAPI loopback | Device-level; used when isolated fails |

### 7.3 `_LoopbackCapture`

Uses the `soundcard` library which exposes WASAPI loopback via
`sc.get_microphone(id=spk.id, include_loopback=True)`. Captures whatever plays on
a given output device (speakers, headphones). All apps on that device bleed through.

Processing: float32 stereo → average channels → int16 mono.

### 7.4 `_AppCapture` (device loopback fallback)

Uses `pyaudiowpatch` (patched PortAudio with loopback support). Selects the output
endpoint with the fewest co-tenants via `IAudioSessionManager2` enumeration.
Resamples if native rate ≠ 48000 Hz using linear interpolation.

### 7.5 App list enumeration (`_build_app_list`)

1. Enumerate output endpoints via `IMMDeviceEnumerator.EnumAudioEndpoints(eRender, 1)`.
2. For each endpoint, open `IAudioSessionManager2`, enumerate sessions, get PID via
   `IAudioSessionControl2.GetProcessId()`.
3. Get exe name via `psutil.Process(pid).name()`.
4. Match endpoint to `pyaudiowpatch` loopback device by position (same order).
5. For each PID, keep only the endpoint with the fewest co-tenants (`shared_with` count).
6. Return list sorted by app name.

Each entry: `{pid, exe, name, loopback_idx, device_name, shared_with}`.

### 7.6 AudioEngine lifecycle

```
AudioEngine()
    .start_pair_app(pid, loopback_idx, display_name, output_device)
        → starts _WASAPIProcessCapture or _AppCapture (fallback)
        → starts OutputStream for playback
    .pop_capture() → next int16 mono frame or None
    .add_peer(id) → PeerAudio
    .remove_peer(id)
    .stop()
```

### 7.7 Output stream

`sounddevice.OutputStream`, stereo int16 @ 48 kHz, `blocksize=960`, `latency="low"`.
The `_out_cb` mixer runs on the PortAudio thread and mixes all active peers.

---

## 8. Per-Process Audio Capture (Windows)

### 8.1 Overview

`_WASAPIProcessCapture` captures audio from a single process (and its child tree)
using `ActivateAudioInterfaceAsync` with `AUDIOCLIENT_ACTIVATION_TYPE_PROCESS_LOOPBACK`.
This is the same API Discord uses for "Share Application Audio". Available on Windows 10
version 2004 (build 19041) and later.

### 8.2 Availability check

```python
@staticmethod
def is_available() -> bool:
    if sys.getwindowsversion().build < 19041:
        return False
    return hasattr(ctypes.WinDLL("mmdevapi"), "ActivateAudioInterfaceAsync")
```

### 8.3 COM threading

The capture thread initialises COM as **Multi-Threaded Apartment (MTA)**:

```python
ole32 = ctypes.WinDLL("ole32")
ole32.CoInitializeEx(None, 0)   # 0 = COINIT_MULTITHREADED
# ... all work ...
ole32.CoUninitialize()
```

Do NOT use `RoInitialize` — this is a Win32 API, not a WinRT API.

### 8.4 AUDIOCLIENT_ACTIVATION_PARAMS struct

12 bytes, little-endian:

```
Offset  Size  Field                 Value
------  ----  --------------------  -----
0       4     ActivationType        1 (AUDIOCLIENT_ACTIVATION_TYPE_PROCESS_LOOPBACK)
4       4     TargetProcessId       PID of the target process
8       4     ProcessLoopbackMode   0 (PROCESS_LOOPBACK_MODE_INCLUDE_TARGET_PROCESS_TREE)
```

`ProcessLoopbackMode = 0` captures the target PID **and all child processes** — critical
for Electron apps (Spotify, Discord) that play audio from renderer/GPU child processes.

### 8.5 PROPVARIANT encoding

The params struct is wrapped in a `PROPVARIANT` with `vt = VT_BLOB (65)`.

64-bit Windows PROPVARIANT memory layout (24 bytes total):

```
Offset  Size  Field       Value
------  ----  ----------  -----
0       2     vt          65 (VT_BLOB)
2       2     wReserved1  0
4       2     wReserved2  0
6       2     wReserved3  0
8       4     cbSize      12 (sizeof _ActivationParams)
12      4     [padding]   (natural alignment for 8-byte pointer)
16      8     pBlobData   pointer to _ActivationParams
```

In ctypes, this alignment is automatic — do NOT use `_pack_ = 1`.

### 8.6 COM interfaces required

All defined locally inside `_run()` using `comtypes.IUnknown` subclasses:

**`IAudioClient`** `{1CB9AD4C-DBFA-4C32-B178-C2F568A703B2}`  
vtable (in declaration order): Initialize, GetBufferSize, GetStreamLatency,
GetCurrentPadding, IsFormatSupported, GetMixFormat, GetDevicePeriod, Start, Stop,
Reset, SetEventHandle, GetService.

**`IAudioCaptureClient`** `{C8ADBD64-E71E-48A0-A4DE-185C395CD317}`  
vtable: GetBuffer, ReleaseBuffer, GetNextPacketSize.

**`IActivateAudioInterfaceAsyncOperation`** `{72A22D78-CDE4-431D-B8CC-843A71199B6D}`  
vtable: GetActivateResult → (HRESULT activateResult, IUnknown** activatedInterface).

**`IActivateAudioInterfaceCompletionHandler`** `{41D949AB-9862-444A-80F6-C261334DA5EB}`  
vtable: ActivateCompleted(IActivateAudioInterfaceAsyncOperation*).

**`IAgileObject`** `{94EA2B94-E9CC-49E0-C0FF-EE64CA8F5B90}`  
Marker interface — no methods beyond IUnknown. **Must be implemented by the completion
handler** or `ActivateAudioInterfaceAsync` returns `E_ILLEGAL_METHOD_CALL (0x8000000E)`
before even starting the async operation.

### 8.7 Activation call

```python
fn = ctypes.WinDLL("mmdevapi").ActivateAudioInterfaceAsync
fn.restype  = ctypes.c_long
fn.argtypes = [c_wchar_p, POINTER(GUID), c_void_p, c_void_p, POINTER(c_void_p)]

hr = fn(
    "VAD\\Process_Loopback",   # virtual audio device path
    byref(IAudioClient._iid_),
    byref(propvar),             # PROPVARIANT* with the activation params
    cast(handler_iface, c_void_p),  # IActivateAudioInterfaceCompletionHandler*
    byref(async_op_raw),        # out: IActivateAudioInterfaceAsyncOperation*
)
```

### 8.8 Completion handler (Python COM object)

```python
class _Handler(comtypes.COMObject):
    _com_interfaces_ = [IActivateAudioInterfaceCompletionHandler, IAgileObject]

    def IActivateAudioInterfaceCompletionHandler_ActivateCompleted(self, op):
        try:
            result_hr, iunk = op.GetActivateResult()
            _result["hr"] = result_hr
            if result_hr == 0:
                _result["client"] = iunk.QueryInterface(IAudioClient)
        except Exception as exc:
            _result["error"] = str(exc)
        finally:
            _done.set()
        return 0  # S_OK
```

`GetActivateResult()` is called **inside the callback** to acquire a strong reference
to `IAudioClient` before the callback returns — avoids lifetime issues.

The main thread waits: `_done.wait(timeout=5.0)`.

### 8.9 Audio format — CRITICAL

The process loopback `IAudioClient` does **not** implement `GetMixFormat()` — it returns
`E_NOTIMPL (0x80004001)`. Calling it is a fatal error.

**Always hardcode the format:**

```
wFormatTag      = 1        WAVE_FORMAT_PCM
nChannels       = 2        stereo
nSamplesPerSec  = 44100    Hz
wBitsPerSample  = 16       signed PCM
nBlockAlign     = 4        (2 channels × 2 bytes)
nAvgBytesPerSec = 176400   (44100 × 4)
cbSize          = 0
```

Source: Microsoft's official ApplicationLoopback sample (`LoopbackCapture.cpp`).

Do **not** combine `AUDCLNT_STREAMFLAGS_EVENTCALLBACK` with
`AUDCLNT_STREAMFLAGS_LOOPBACK` — event-driven loopback never fires. Use timer-driven
polling (`GetNextPacketSize` in a sleep loop).

### 8.10 Initialize call

```python
AUDCLNT_STREAMFLAGS_LOOPBACK = 0x00020000

audio_client.Initialize(
    0,                      # AUDCLNT_SHAREMODE_SHARED
    AUDCLNT_STREAMFLAGS_LOOPBACK,
    10_000_000,             # hnsBufferDuration: 1 s in 100-ns units
    0,                      # hnsPeriodicity: 0 for shared mode
    byref(fmt),             # WAVEFORMATEX*
    None,                   # AudioSessionGuid: NULL
)
```

### 8.11 Capture loop

```python
audio_client.Start()
while not stop:
    n = capture.GetNextPacketSize()
    while n > 0:
        data_ptr, n_frames, flags, _, _ = capture.GetBuffer()
        if n_frames > 0 and not (flags & AUDCLNT_BUFFERFLAGS_SILENT):
            raw = read_bytes(data_ptr, n_frames * bytes_per_frame)
            arr = frombuffer(raw, int16).astype(float32) / 32768.0
            arr = stereo_to_mono(arr)
            arr = resample_if_needed(arr, 44100, 48000)
            append_to_captured_deque(arr)
        capture.ReleaseBuffer(n_frames)
        n = capture.GetNextPacketSize()
    sleep(0.005)
audio_client.Stop()
```

`AUDCLNT_BUFFERFLAGS_SILENT = 0x02` — skip silent frames (no signal from process).

### 8.12 Fallback chain

```
start_pair_app(pid, loopback_idx, display_name):
    if pid is not None and _WASAPIProcessCapture.is_available():
        try _WASAPIProcessCapture(pid, ...)
        wait 350 ms
        if cap.error:
            print fallback warning to stderr
            use _AppCapture(loopback_idx, ...)
        else:
            label = "{name} [app -- isolated]"
    else:
        use _AppCapture(loopback_idx, ...)
        label = "{name} [app -- device loopback]"
```

---

## 9. Proximity Math

### 9.1 Distance

XZ plane only (Y = vertical, ignored):

```python
d = sqrt((x1-x2)² + (z1-z2)²)
```

### 9.2 Volume attenuation

Piecewise power curve:

```
d ≤ near          → gain = 1.0
near < d < far    → gain = ((far - d) / (far - near)) ^ curve
d ≥ far           → gain = 0.0
```

Default parameters (client mode): near = 10 m, far = 80 m, curve = 2.0 (inverse-square).

### 9.3 Stereo panning

Bearing of the peer relative to the listener's forward direction:

```python
bearing = atan2(peer_x - self_x, peer_z - self_z) - self_yaw
pan = clamp(sin(bearing), -1.0, 1.0)
# pan = -1.0 → full left, +1.0 → full right
```

### 9.4 Equal-power stereo split

```python
p = (pan + 1.0) * π / 4.0
gain_L = gain * cos(p)
gain_R = gain * sin(p)
```

### 9.5 EMA smoothing

Prevents audible clicks when position data is jittery or briefly stale:

```
gain_smooth = 0.3 * gain_raw + 0.7 * gain_prev   (α_gain = 0.3)
pan_smooth  = 0.15 * pan_raw + 0.85 * pan_prev   (α_pan  = 0.15)
```

Updated at 60 Hz in the `gain_and_tui` loop. On first update, the smoothed value is
set directly (no ramp from zero).

---

## 10. Doppler Effect

### 10.1 Formula

Classic moving-source, stationary-listener model:

```
f_perceived / f_source = v_sound / (v_sound - v_source_toward_listener)
```

Where:
- `v_sound = 343.0 m/s` (air at ~20°C)
- `v_source_toward_listener` = radial component of peer's velocity toward self

### 10.2 Computation

```python
dx, dz = self_x - peer_x, self_z - peer_z
dist = sqrt(dx² + dz²)
if dist < 1.0 or peer_speed < 0.5:
    return 1.0  # no shift

# Unit vector from peer toward self
nx, nz = dx/dist, dz/dist

# Peer velocity in world space (yaw convention: sin=X, cos=Z)
vx = peer_speed * sin(peer_yaw)
vz = peer_speed * cos(peer_yaw)

v_toward = vx*nx + vz*nz
denom = v_sound - v_toward
if abs(denom) < 10.0:
    denom = copysign(10.0, denom)   # guard against transonic edge case

factor = clamp(v_sound / denom, 0.7, 1.5)
```

Clamped to [0.7, 1.5] — outside this range the effect becomes unnatural.

### 10.3 Application to audio frames

Linear interpolation pitch-shift (no look-ahead buffer):

```python
def apply_doppler(frame: int16[960], factor: float) -> int16[960]:
    if abs(factor - 1.0) < 0.004:
        return frame   # skip for negligible shifts
    x_in = arange(960) * factor
    clip(x_in, 0, 959)
    return interp(x_in, arange(960), frame.astype(float64)).astype(int16)
```

`factor > 1.0` (approaching) → reads ahead faster → compressed → higher pitch.  
`factor < 1.0` (receding)   → reads slower → stretched → lower pitch.

Applied in the receiver task immediately after receiving `PEER_AUDIO`, before enqueuing
to the peer's ring buffer.

---

## 11. Bugs Fixed During Development

### Bug 1 — `E_ILLEGAL_METHOD_CALL` from `ActivateAudioInterfaceAsync`

**Symptom:** `ActivateAudioInterfaceAsync` returned `0x8000000E` synchronously;
activation never started.

**Root cause:** `ActivateAudioInterfaceAsync` calls `QueryInterface(IID_IAgileObject)`
on the completion handler before launching the async operation. If the handler returns
`E_NOINTERFACE`, the function bails with `E_ILLEGAL_METHOD_CALL`.

**Fix:** Add `IAgileObject {94EA2B94-E9CC-49E0-C0FF-EE64CA8F5B90}` (a no-method marker
interface) to the completion handler's `_com_interfaces_` list. comtypes `COMObject`
then responds `S_OK` to `QueryInterface(IID_IAgileObject)`.

---

### Bug 2 — `GetMixFormat` returns `E_NOTIMPL`

**Symptom:** Activation succeeded (after Bug 1 fix), but capture immediately failed
with `COMError: 0x80004001`.

**Root cause:** The `IAudioClient` returned for process loopback is an internal
`CMixerClient` that does not implement `GetMixFormat()`, `IsFormatSupported()`,
`IAudioClient2`, or `IAudioClient3`. Calling any of these methods returns `E_NOTIMPL`.
This is confirmed in Microsoft's own documentation for the API.

**Fix:** Remove the `GetMixFormat()` call entirely. Hardcode the audio format as
16-bit signed PCM, 2 channels, 44100 Hz — matching Microsoft's official
`ApplicationLoopback` C++ sample.

---

### Bug 3 — Wrong `ActivateCompleted` parameter type

**Symptom:** Potential crash or wrong object type received in the completion callback.

**Root cause:** The `ActivateCompleted` COMMETHOD was accidentally declared with a bare
`IActivateAudioInterfaceAsyncOperation` parameter instead of
`POINTER(IActivateAudioInterfaceAsyncOperation)`. In comtypes, the correct declaration
for a `["in"]` COM interface pointer received by a `COMObject` callback is the LP
(pointer) type.

**Fix:** Use `(["in"], ctypes.POINTER(IActivateAudioInterfaceAsyncOperation), "op")`.

---

### Bug 4 — `IAudioClient` imported from pycaw

**Symptom:** Method call signature mismatches when using pycaw's `IAudioClient` with
the process loopback path.

**Root cause:** pycaw's `IAudioClient` vtable definition is designed for normal device
activation and assumes `GetMixFormat` works. Using it for process loopback mixed up
the calling conventions.

**Fix:** Define `IAudioClient` entirely locally inside `_WASAPIProcessCapture._run()`.
The vtable order must exactly match the COM ABI: Initialize, GetBufferSize,
GetStreamLatency, GetCurrentPadding, IsFormatSupported, GetMixFormat, GetDevicePeriod,
Start, Stop, Reset, SetEventHandle, GetService.

---

### Bug 5 — `GetActivateResult` called after event wait (lifetime issue)

**Symptom:** Race condition — `activate_op` held in a list box might be stale or
released by Windows after the callback returned.

**Root cause:** The original code stored the raw `activate_operation` pointer in a list
and called `GetActivateResult()` on the main thread after `_done.wait()`. COM does not
guarantee the object remains alive after the callback returns.

**Fix:** Call `GetActivateResult()` and `QueryInterface(IAudioClient)` inside the
callback itself, storing the `IAudioClient` interface (which holds its own reference)
in the result dict.

---

### Bug 6 — `AUDCLNT_STREAMFLAGS_EVENTCALLBACK` with loopback

**Symptom:** No audio captured despite activation and initialisation succeeding.

**Root cause:** `AUDCLNT_STREAMFLAGS_EVENTCALLBACK | AUDCLNT_STREAMFLAGS_LOOPBACK`
is an unsupported combination — the event never fires.

**Fix:** Use only `AUDCLNT_STREAMFLAGS_LOOPBACK`. Poll for packets using
`GetNextPacketSize()` in a `sleep(0.005)` loop.

---

## 12. Flutter Implementation Notes

### 12.1 Hub

The hub is pure TCP async I/O. Flutter can implement it with `dart:io`
`ServerSocket` / `Socket`. No platform-specific code needed. The hub is
suitable for deployment on any OS (Windows, macOS, Linux).

Key classes to port:
- `Hub` → `HorizonProxHub`
- `_Player` → `Player`
- `_Room` → `Room`
- `_send` / `_recv` → use `ByteData` with big-endian header encoding

### 12.2 Wire framing in Dart

```dart
// Send
final header = ByteData(3)
  ..setUint8(0, msgType)
  ..setUint16(1, payload.length, Endian.big);
socket.add(header.buffer.asUint8List());
socket.add(payload);

// Recv
// Read 3-byte header, then readExactly(payloadLen)
```

### 12.3 Per-process audio capture

The `_WASAPIProcessCapture` path requires a Windows-native implementation.
In Flutter, use FFI (`dart:ffi`) to call `ActivateAudioInterfaceAsync` from
`mmdevapi.dll` following the exact implementation in Section 8.

**Critical requirements for the Flutter FFI implementation:**
1. The completion handler COM object **must** implement `IAgileObject`.
2. **Do not call `GetMixFormat()`** — hardcode the format (Section 8.9).
3. Use `COINIT_MULTITHREADED` (not `RoInitialize`) on the capture thread.
4. Process loopback requires `AUDIOCLIENT_ACTIVATION_TYPE_PROCESS_LOOPBACK = 1`.
5. Use `ProcessLoopbackMode = 0` to include child processes (required for Electron apps).

### 12.4 Telemetry

Parse incoming UDP datagrams on `127.0.0.1:9988`. Packet is 324 bytes. All fields
are little-endian. Offsets for FH6 are in Section 6.1.

Apply EMA smoothing (α=0.3) to x, y, z, yaw before using in proximity math.

Stale detection: if no packet for 500 ms, freeze at last known position and update
UI to show "No telemetry".

### 12.5 Audio PCM pipeline

The audio pipeline operates on frames of exactly 960 int16 mono samples (20 ms at
48 kHz). Every captured frame is sent as a 1920-byte `C2H_AUDIO` message. Every
received `H2C_PEER_AUDIO` is 1921 bytes (1B peer ID + 1920B PCM).

Playback is stereo: left/right gain applied per peer, mixed additively, clipped to
[-1.0, 1.0], converted to int16.

### 12.6 Proximity math

Pure arithmetic — no library needed. Implement the five functions from Section 9:
`xz_distance`, `gain_for_distance`, `pan_for_bearing`, `stereo_gains`, and the EMA
`SmoothGain` updater. Update gains at ~60 Hz on the UI/game loop thread.

### 12.7 Doppler

Apply to each received audio frame before enqueuing for playback. The formula and
linear-interpolation pitch-shift are in Section 10. Skip if `|factor - 1.0| < 0.004`.

### 12.8 Audio session enumeration (app list)

Requires Windows COM: `IMMDeviceEnumerator` → `EnumAudioEndpoints(eRender, 1)` →
`IAudioSessionManager2` → `IAudioSessionControl2.GetProcessId()`. Cross-reference
with `OpenProcess` / `QueryFullProcessImageName` for exe name (replaces psutil).
Match endpoints to WASAPI loopback devices by index position.
