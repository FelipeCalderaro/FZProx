# HorizonProx — Session Notes (2026-05-19)

## What Was Built

Full Flutter Windows desktop app for proximity voice chat in Forza Horizon ("HorizonProx / fzprox").

---

## Architecture

- **Flutter Windows desktop** — primary target
- **BLoC pattern** (`flutter_bloc ^8.1.6`) — all state management with Freezed sealed unions
- **Freezed** — code generation for immutable models and events/states
- **Dart FFI** (`dart:ffi` + `package:ffi`) — bridges to `fzprox_audio.dll`
- **WASAPI** (Windows native) — mic capture, loopback capture, per-process capture, playback
- **Wire protocol** — 3-byte header `[msgType][2B payload len big-endian][payload]`

---

## Key Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | Entry point — just `runApp(const FzproxApp())` |
| `lib/ui/app.dart` | Root widget, BLoC providers, navigator key, hub overlay |
| `lib/ui/screens/home_screen.dart` | Home — hub status-aware buttons, "Connect to My Hub" shortcut |
| `lib/ui/screens/hub_screen.dart` | Hub management + "Connect as Client" button |
| `lib/ui/screens/setup_screen.dart` | 4-step wizard (identity → audio input → audio output → proximity) |
| `lib/ui/screens/room_screen.dart` | Room browser |
| `lib/ui/screens/session_screen.dart` | Active session / peer table |
| `lib/blocs/connection/connection_bloc.dart` | WebSocket connection state machine |
| `lib/blocs/setup/setup_bloc.dart` | Setup wizard state machine |
| `lib/blocs/hub/hub_bloc.dart` | Hub server lifecycle (start/stop/restart/refresh) |
| `lib/blocs/session/session_bloc.dart` | Active voice session |
| `lib/audio/audio_engine.dart` | Dart wrapper over FFI calls |
| `lib/audio/native_audio_ffi.dart` | Raw FFI bindings to `fzprox_audio.dll` |
| `lib/client/client.dart` | `HorizonClient` — TCP/WebSocket hub client |
| `lib/hub/hub_server.dart` | Embedded hub server |
| `windows/native_audio/audio_engine.cpp` | WASAPI implementation (~450 lines) |
| `windows/native_audio/audio_engine.h` | C header — 13 exported functions |
| `windows/native_audio/CMakeLists.txt` | Builds `fzprox_audio.dll` |
| `windows/CMakeLists.txt` | Adds `native_audio` subdirectory + install rule |
| `installer/horizonprox.iss` | Inno Setup script → `HorizonProx-1.0.0-Setup.exe` |

---

## Bugs Fixed This Session

### 1. `onEvent` not a parameter of `HorizonClient`
- **Error**: `lib/blocs/connection/connection_bloc.dart:39:9: Error: No named parameter with the name 'onEvent'`
- **Fix**: Removed `onEvent:` from constructor call. Added `StreamSubscription<HubMessage>? _msgSub` field. Subscribed to `_client!.messages.listen(...)` after connect, routing hub message types to `add()` events. Cancel in `_onDisconnect` and `close()`.

### 2. Navigator crash from `MaterialApp.builder` context
- **Error**: "Navigator operation requested with a context that does not include a Navigator" — `showDialog(context: context)` called from `MaterialApp.builder` callback which sits above the Navigator in the widget tree.
- **Fix**: Added file-level `final _navKey = GlobalKey<NavigatorState>();`, passed as `navigatorKey` to `MaterialApp`. Replaced `showDialog` with `_navKey.currentState!.push(PageRouteBuilder(...))`. The `context` is still used for `context.read<HubBloc>()` (works fine — it's below `MultiBlocProvider`). Dialog uses `ctx` from `pageBuilder` for `Navigator.of(ctx).pop()`.

### 3. Existing peers invisible on room join
- **Root cause**: `parseWelcome()` correctly decoded the pre-existing peer list from the WELCOME packet, but `ConnectionBloc._onWelcomeReceived()` dropped the `peers` field — only `selfId` / `roomCode` / `username` were forwarded to `ConnectionState.inSession`.
- **Fix**: Added `existingPeers` field to `ConnectionInSession` (Freezed), passed `event.peers` through. `SessionScreen._startRunner()` now iterates `connState.existingPeers` and fires `SessionEvent.peerAdded` + `audio.addPeer()` for each pre-existing peer.
- **Files**: `connection_state.dart`, `connection_bloc.dart`, `session_screen.dart`

### 4. No audio heard at all (capture, playback, monitor — all silent)
- **Root cause** (**CRITICAL**): `SessionScreen._startRunner()` created a **new** `AudioEngine()` instance at line 43 and passed it to `SessionRunner`. But `SessionBloc` (created in `app.dart`) already owned a **different** `AudioEngine` instance. `SessionBloc._onGainTick()` called `_audioEngine.setGains()` on its own engine — which had **no peers registered** and whose mix loop was **never started**. Meanwhile `SessionRunner` ran capture+playback+mix on the screen's separate engine, whose peer `gainL`/`gainR` values were always `0.0` (the defaults).  
  **Net effect**: the mix loop multiplied every audio sample by 0 → silence.
- **Fix**: Exposed `SessionBloc.audioEngine` as a public getter. Changed `SessionScreen._startRunner()` to use `sessionBloc.audioEngine` instead of `AudioEngine()`.
- **Files**: `session_bloc.dart` (added `AudioEngine get audioEngine`), `session_screen.dart`
- **Verification**: 19 unit tests written covering peer lifecycle, gain flow, proximity math, and monitor flag. All pass.

### 5. Volume indicator showed ~70% at maximum proximity
- **Root cause**: Peer table UI computed `(gainL + gainR) / 2` for the volume bar. But `stereoGains()` uses equal-power panning: at `pan=0`, both channels are `cos(π/4) ≈ 0.707`, so `(0.707 + 0.707) / 2 = 0.707` ≈ 70%.
- **Fix**: Added `rawGain` field to `PeerModel` — stores the proximity gain *before* the stereo split. `SessionEvent.peerMetricsUpdated` and `SessionBloc._onGainTick` pass `smoothed.gain` through. `PeerTable._PeerRow` now uses `peer.rawGain` for the volume bar.
- **Files**: `peer_model.dart`, `session_event.dart`, `session_bloc.dart`, `peer_table.dart`

---

## Features Added This Session

### Hub + Client simultaneously
- `SetupEvent.started({String? prefilledHost, int? prefilledPort})` — optional prefill parameters
- Hub screen: "Connect as Client" button fires `SetupEvent.started(prefilledHost: 'localhost', prefilledPort: state.port)`
- Home screen: hub-status-aware buttons; "Connect to My Hub" appears when hub is running

### Audio device refresh
- `SetupEvent.devicesRefreshed()` event re-enumerates all three lists (input, output, sessions)
- Refresh button always visible at top of Audio Input step (Step 2), regardless of mode

### Output devices in Loopback mode
- When mode is Loopback, the device picker shows output devices (speakers/headphones) not microphones
- Same `_selectedDevice` field reused; cleared on mode change

### Floating hub indicator
- `_HubOverlay` + `_HubBadge` widgets in `app.dart`
- Pill badge (bottom-right) visible on all screens when hub is running or starting
- Tap → dialog with port, room count, Restart and Stop actions
- Uses `_navKey` to push dialog correctly from above-Navigator context

### Installable .exe (Inno Setup)
- `installer/horizonprox.iss` — x64-only, Windows 10+, lzma2/ultra64 compression
- Unsigned (SmartScreen warning on first run — "More info → Run anyway")

### Local Test Scenario
- **New file**: `lib/client/local_test_controller.dart` — injects a virtual peer (id=9999, name="[TEST]") at a user-specified X/Z position
- Taps into `AudioEngine.onCaptureFrame` callback to loopback captured audio to the virtual peer (no racing with the sender loop)
- Position updates are fired per-frame so the gain loop always has fresh coordinates
- `_LocalTestCard` widget in session screen left panel — collapsible, with X/Z coordinate inputs, Start/Stop toggle
- Coordinates are always editable and update the peer's position in real time

### Monitor Input (Hear Capture Immediately)
- Added `monitorEnabled` flag and `_lastCaptured` buffer to `AudioEngine`
- When enabled, the mix loop adds the most-recent captured frame at unity gain to the output → you hear your mic/loopback/app capture directly through speakers/headphones
- Toggle in the Local Test card UI (checkbox "Monitor Input — Hear your capture source directly")
- Works independently of the local test peer

### Audio capture frame tap callback
- Added `onCaptureFrame` callback to `AudioEngine` — fires with a copy of every captured frame immediately after `popCapture()` returns
- Used by `LocalTestController` to feed audio to the test peer without competing with the sender loop's `popCapture()` calls

### Unit tests
- 19 tests in `test/audio_pipeline_test.dart`
- Covers: peer lifecycle, `bufferMs`, `onCaptureFrame`, `monitorEnabled`, `gainForDistance`, `stereoGains`, EMA smoother, gain flow integrity

### 6. DropdownButton assertion crash in `_AudioSettingsCard`
- **Error**: `AssertionError: There should be exactly one item with [DropdownButton]'s value: AudioDeviceInfo(...)`
- **Root cause**: The `_AudioSettingsCard` starts with empty lists while `_fetchDevices()` runs. The `DropdownButton` tries to match the current `SetupConfig` value (carried over from the setup screen) against the empty list. Since it's not present, it crashes. Even when loaded, if a device is disconnected, it would crash.
- **Fix**: Added dynamic list injection logic that prepends/appends the currently selected `AudioDeviceInfo` or `AudioSessionInfo` to the dropdown items if it's not present in the currently fetched list.

### 7. Process Loopback (App Capture) silence
- **Issue**: Selecting an app for process loopback resulted in absolute silence being captured.
- **Root cause**: The WASAPI `VIRTUAL_AUDIO_DEVICE_PROCESS_LOOPBACK` API has severe quirks not documented in standard WASAPI documentation:
  1. It refuses to expose its audio mix format (`GetMixFormat` returns `E_NOTIMPL`). Our C++ code was attempting to fetch it, failing, and aborting activation.
  2. It does **not** support event-driven callbacks (`AUDCLNT_STREAMFLAGS_EVENTCALLBACK`). Our code was passing this flag, binding an event handle, and waiting for it in the `CaptureThread`. The event never fired, causing the thread to timeout and read silence indefinitely.
- **Fix**: Refactored the `audio_engine.cpp` native pipeline:
  - Introduced a `CaptureMode` enum (`Mic`, `Loopback`, `Process`).
  - For `Process` mode, `GetMixFormat` is completely bypassed. The format is manually hardcoded to `16-bit PCM, 44100 Hz, Stereo` (as required by the API).
  - For `Process` mode, the event flag is omitted. The `CaptureThread` now uses timer-driven polling (`GetNextPacketSize` in a 5ms sleep loop) instead of waiting for an event handle.
- **Important Windows Caveat**: Even with the fix, Windows WASAPI will still provide silence (or no buffers) if the targeted application is not actively outputting audio at the moment of capture.

---

## Build Process

```powershell
# 1. Regenerate Freezed files (run after any model/bloc changes)
dart run build_runner build --delete-conflicting-outputs

# 2. Flutter release build (also compiles fzprox_audio.dll via CMake)
flutter build windows --release

# 3. Package into installer (requires Inno Setup 6 installed)
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" installer\horizonprox.iss
# Output: installer\output\HorizonProx-1.0.0-Setup.exe
```

---

## Known Limitations / Future Work

- **No code signing** — SmartScreen warns on first run; users must click "More info → Run anyway"
- **VC++ Redistributable** — installer does not bundle it; clean PCs may need `vc_redist.x64.exe` separately
- **Forza telemetry** — UDP telemetry receiver is implemented but Forza must have "Data Out" enabled in game settings (port 7776 by default)
- **Process capture (App Capture mode)** — uses `ActivateAudioInterfaceAsync` with `VIRTUAL_AUDIO_DEVICE_PROCESS_LOOPBACK`; requires Windows 10 2004+ and the target app must have active audio. Audio must be playing *before* capture starts. Spotify and some apps may have process-tree complexities — if process capture produces silence, try System Loopback mode as a fallback.
- **Monitor feedback loop** — if the capture source is the same output device as playback (e.g., loopback mode capturing headphones), enabling Monitor will create a feedback loop. Only use Monitor with mic or app capture.

