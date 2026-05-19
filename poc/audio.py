"""
Audio engine for the POC.

Uses sounddevice (PortAudio) for mic capture and playback.
Uses soundcard for WASAPI loopback capture (captures whatever is playing on an
output device — Spotify, game audio, Discord, etc.).

All real-time work runs in background threads; we share data via collections.deque
(GIL + atomic deque ops make this safe without explicit locking for the fast path).

Input source options (controlled by start_solo / start_pair):
  default           — microphone (default input device)
  --input-device N  — any mic/line-in by index (sounddevice index from 'poc devices')
  --loopback        — capture system audio from the default output device
  --loopback --input-device N  — capture from specific output device N

Two operating modes:
  start_solo()  — mic: full-duplex sd.Stream (lowest latency).
                  loopback: _LoopbackCapture thread + OutputStream.
  start_pair()  — always separate InputStream + OutputStream.
"""
from __future__ import annotations

import collections
import sys
import threading

import numpy as np
import sounddevice as sd

SAMPLE_RATE = 48000
FRAME_SAMPLES = 960    # 20 ms @ 48 kHz
PCM_BYTES = FRAME_SAMPLES * 2
MAX_BUFFER_FRAMES = 12  # ~240 ms max buffered audio per peer


def _resolve_device(device: int | str | None) -> int | str | None:
    if device is None:
        return None
    try:
        return int(device)
    except (ValueError, TypeError):
        return str(device)


# ── Loopback capture via soundcard ───────────────────────────────────────────

class _LoopbackCapture:
    """
    Captures system audio (loopback) via the soundcard library in a daemon thread.

    soundcard uses WASAPI under the hood on Windows and exposes loopback for any
    output device without needing WasapiSettings or virtual cables.

    device: sounddevice output device index or name (from 'poc devices').
            None = system default output.
    """

    def __init__(
        self,
        device: int | str | None,
        captured: collections.deque,
    ) -> None:
        self._device = device
        self._captured = captured
        self._stop = threading.Event()
        self._thread: threading.Thread | None = None
        self.device_name: str = "(resolving…)"
        self.error: str | None = None

    def start(self) -> None:
        self._stop.clear()
        self._thread = threading.Thread(target=self._run, daemon=True, name="loopback")
        self._thread.start()

    def stop(self) -> None:
        self._stop.set()

    def _resolve_speaker(self):
        try:
            import soundcard as sc
        except ImportError:
            raise RuntimeError(
                "Loopback capture requires the 'soundcard' package.\n"
                "Install it:  uv add soundcard"
            )

        speakers = sc.all_speakers()

        if self._device is None:
            return sc.default_speaker(), sc

        # int → look up sounddevice name, then match to soundcard speaker by name prefix
        if isinstance(self._device, int):
            try:
                sd_name = sd.query_devices(self._device)["name"]
                for spk in speakers:
                    if spk.name[:20] == sd_name[:20]:
                        return spk, sc
            except Exception:
                pass

        # str → substring match
        if isinstance(self._device, str):
            needle = self._device.lower()
            for spk in speakers:
                if needle in spk.name.lower():
                    return spk, sc

        return sc.default_speaker(), sc

    def _run(self) -> None:
        try:
            spk, sc = self._resolve_speaker()
            self.device_name = spk.name
            mic = sc.get_microphone(id=spk.id, include_loopback=True)
            with mic.recorder(
                samplerate=SAMPLE_RATE,
                channels=2,
                blocksize=FRAME_SAMPLES,
            ) as rec:
                while not self._stop.is_set():
                    data = rec.record(numframes=FRAME_SAMPLES)
                    # float32 stereo (-1..1) → int16 mono
                    combined = data.sum(axis=1) / 2.0
                    np.clip(combined, -1.0, 1.0, out=combined)
                    self._captured.append((combined * 32767).astype(np.int16))
        except Exception as exc:
            self.error = str(exc)
            print(f"\n  [loopback] {exc}", file=sys.stderr)


# ── Per-app audio capture ─────────────────────────────────────────────────────

def _build_app_list() -> list[dict]:
    """
    Map running processes to their best-isolation output endpoint.

    Strategy: enumerate every output endpoint, list which PIDs have sessions
    on it, match each endpoint to a pyaudiowpatch loopback device by position
    (both APIs return endpoints in the same order), then for each PID pick the
    endpoint with the fewest co-tenants.

    Returns list of dicts:
      pid, exe, name, loopback_idx, device_name, shared_with (int, other PIDs)
    """
    try:
        import pyaudiowpatch as pyaudio
        import psutil
        from pycaw.pycaw import (
            IMMDeviceEnumerator, EDataFlow,
            IAudioSessionManager2, IAudioSessionControl2,
        )
        import comtypes, comtypes.client

        # Pyaudiowpatch loopback devices (device-level), ordered same as endpoints
        p = pyaudio.PyAudio()
        loopback_devs = list(p.get_loopback_device_info_generator())
        p.terminate()

        # Enumerate output endpoints in the same order
        enumerator = comtypes.client.CreateObject(
            "{BCDE0395-E52F-467C-8E3D-C4579291692E}",
            clsctx=comtypes.CLSCTX_ALL,
            interface=IMMDeviceEnumerator,
        )
        collection = enumerator.EnumAudioEndpoints(EDataFlow.eRender.value, 1)
        count = collection.GetCount()

        # pid -> best entry so far
        best: dict[int, dict] = {}

        for i in range(min(count, len(loopback_devs))):
            dev = collection.Item(i)
            lb  = loopback_devs[i]
            pids_here: list[tuple[int, str]] = []

            try:
                mgr  = dev.Activate(IAudioSessionManager2._iid_, comtypes.CLSCTX_ALL, None)
                mgr2 = mgr.QueryInterface(IAudioSessionManager2)
                enum2 = mgr2.GetSessionEnumerator()
                for j in range(enum2.GetCount()):
                    ctl  = enum2.GetSession(j)
                    ctl2 = ctl.QueryInterface(IAudioSessionControl2)
                    pid  = ctl2.GetProcessId()
                    if pid == 0:
                        continue
                    try:
                        exe = psutil.Process(pid).name()
                    except Exception:
                        continue
                    pids_here.append((pid, exe))
            except Exception:
                continue

            n_others = len(pids_here) - 1  # exclude self
            dev_name = lb["name"].replace(" [Loopback]", "").strip()

            for pid, exe in pids_here:
                if pid not in best or n_others < best[pid]["shared_with"]:
                    best[pid] = {
                        "pid":         pid,
                        "exe":         exe,
                        "name":        exe.replace(".exe", "").replace(".EXE", ""),
                        "loopback_idx": int(lb["index"]),
                        "device_name": dev_name,
                        "shared_with": n_others,
                    }

        return sorted(best.values(), key=lambda x: x["name"].lower())

    except Exception:
        return []


class _AppCapture:
    """
    Captures the output of a specific Windows audio endpoint via pyaudiowpatch
    WASAPI loopback.  Used when the user selects a running application as the
    audio source; we pick the endpoint with the fewest co-tenants for maximum
    isolation (without a virtual cable this is the best we can do).
    """

    def __init__(
        self,
        loopback_idx: int,
        display_name: str,
        captured: collections.deque,
    ) -> None:
        self._loopback_idx = loopback_idx
        self._captured     = captured
        self._stop         = threading.Event()
        self._thread: threading.Thread | None = None
        self.device_name: str = display_name
        self.error: str | None = None

    def start(self) -> None:
        self._stop.clear()
        self._thread = threading.Thread(
            target=self._run, daemon=True, name="app-capture"
        )
        self._thread.start()

    def stop(self) -> None:
        self._stop.set()

    def _run(self) -> None:
        try:
            import pyaudiowpatch as pyaudio
            p   = pyaudio.PyAudio()
            dev = p.get_device_info_by_index(self._loopback_idx)

            native_rate   = int(dev["defaultSampleRate"])
            channels      = min(2, max(1, int(dev["maxInputChannels"])))
            # Number of native frames that correspond to 20 ms of audio at SAMPLE_RATE
            native_frames = max(1, int(FRAME_SAMPLES * native_rate / SAMPLE_RATE))

            stream = p.open(
                format=pyaudio.paInt16,
                channels=channels,
                rate=native_rate,
                input=True,
                frames_per_buffer=native_frames,
                input_device_index=self._loopback_idx,
            )
            try:
                while not self._stop.is_set():
                    raw   = stream.read(native_frames, exception_on_overflow=False)
                    frame = np.frombuffer(raw, dtype=np.int16).copy()

                    if channels == 2:
                        frame = frame.reshape(-1, 2).mean(axis=1).astype(np.int16)

                    if native_rate != SAMPLE_RATE and len(frame) > 1:
                        x     = np.linspace(0, len(frame) - 1, FRAME_SAMPLES)
                        frame = np.interp(
                            x, np.arange(len(frame)), frame.astype(np.float64)
                        ).astype(np.int16)

                    self._captured.append(frame)
            finally:
                stream.stop_stream()
                stream.close()
                p.terminate()

        except Exception as exc:
            self.error = str(exc)
            print(f"\n  [app-capture] {exc}", file=sys.stderr)


class _WASAPIProcessCapture:
    """
    Per-process audio capture via WASAPI ActivateAudioInterfaceAsync with
    AUDIOCLIENT_ACTIVATION_TYPE_PROCESS_LOOPBACK.

    Captures only the target process's audio — true isolation, exactly like
    Discord's application audio sharing.  Available on Windows 10 2004+
    (build 19041+).  Falls back gracefully if unavailable.
    """

    @staticmethod
    def is_available() -> bool:
        try:
            import ctypes, sys
            if sys.getwindowsversion().build < 19041:
                return False
            return hasattr(ctypes.WinDLL("mmdevapi"), "ActivateAudioInterfaceAsync")
        except Exception:
            return False

    def __init__(self, pid: int, display_name: str, captured: collections.deque) -> None:
        self._pid          = pid
        self._display_name = display_name
        self._captured     = captured
        self._stop         = threading.Event()
        self._thread: threading.Thread | None = None
        self.device_name   = display_name
        self.error: str | None = None

    def start(self) -> None:
        self._stop.clear()
        self._thread = threading.Thread(
            target=self._run, daemon=True, name="wasapi-proc-capture"
        )
        self._thread.start()

    def stop(self) -> None:
        self._stop.set()

    def _run(self) -> None:
        import time
        import ctypes
        import comtypes

        _ole32 = ctypes.WinDLL("ole32")
        _ole32.CoInitializeEx(None, 0)  # COINIT_MULTITHREADED

        try:
            # ── WAVEFORMATEX ──────────────────────────────────────────────────
            # Process loopback IAudioClient does NOT implement GetMixFormat()
            # (returns E_NOTIMPL). Hardcode PCM 16-bit stereo 44100 Hz per the
            # official Microsoft ApplicationLoopback sample.

            class WAVEFORMATEX(ctypes.Structure):
                _fields_ = [
                    ("wFormatTag",      ctypes.c_uint16),
                    ("nChannels",       ctypes.c_uint16),
                    ("nSamplesPerSec",  ctypes.c_uint32),
                    ("nAvgBytesPerSec", ctypes.c_uint32),
                    ("nBlockAlign",     ctypes.c_uint16),
                    ("wBitsPerSample",  ctypes.c_uint16),
                    ("cbSize",          ctypes.c_uint16),
                ]

            # ── COM interface definitions ─────────────────────────────────────
            # Define IAudioClient locally — pycaw's version calls GetMixFormat
            # which is unsupported on the process loopback client.

            class IAudioClient(comtypes.IUnknown):
                _iid_ = comtypes.GUID("{1CB9AD4C-DBFA-4C32-B178-C2F568A703B2}")
                _methods_ = [
                    comtypes.COMMETHOD([], comtypes.HRESULT, "Initialize",
                        (["in"], ctypes.c_uint32, "ShareMode"),
                        (["in"], ctypes.c_uint32, "StreamFlags"),
                        (["in"], ctypes.c_int64,  "hnsBufferDuration"),
                        (["in"], ctypes.c_int64,  "hnsPeriodicity"),
                        (["in"], ctypes.c_void_p, "pFormat"),
                        (["in"], ctypes.c_void_p, "AudioSessionGuid"),
                    ),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "GetBufferSize",
                        (["out"], ctypes.POINTER(ctypes.c_uint32), "pNumBufferFrames")),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "GetStreamLatency",
                        (["out"], ctypes.POINTER(ctypes.c_int64), "phnsLatency")),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "GetCurrentPadding",
                        (["out"], ctypes.POINTER(ctypes.c_uint32), "pNumPaddingFrames")),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "IsFormatSupported",
                        (["in"],  ctypes.c_uint32, "ShareMode"),
                        (["in"],  ctypes.c_void_p, "pFormat"),
                        (["out"], ctypes.POINTER(ctypes.c_void_p), "ppClosestMatch")),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "GetMixFormat",
                        (["out"], ctypes.POINTER(ctypes.c_void_p), "ppDeviceFormat")),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "GetDevicePeriod",
                        (["out"], ctypes.POINTER(ctypes.c_int64), "phnsDefaultDevicePeriod"),
                        (["out"], ctypes.POINTER(ctypes.c_int64), "phnsMinimumDevicePeriod")),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "Start"),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "Stop"),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "Reset"),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "SetEventHandle",
                        (["in"], ctypes.c_void_p, "eventHandle")),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "GetService",
                        (["in"],  ctypes.POINTER(comtypes.GUID), "riid"),
                        (["out"], ctypes.POINTER(ctypes.POINTER(comtypes.IUnknown)), "ppv")),
                ]

            class IAudioCaptureClient(comtypes.IUnknown):
                _iid_ = comtypes.GUID("{C8ADBD64-E71E-48A0-A4DE-185C395CD317}")
                _methods_ = [
                    comtypes.COMMETHOD([], comtypes.HRESULT, "GetBuffer",
                        (["out"], ctypes.POINTER(ctypes.POINTER(ctypes.c_byte)), "ppData"),
                        (["out"], ctypes.POINTER(ctypes.c_uint32), "pNumFramesAvailable"),
                        (["out"], ctypes.POINTER(ctypes.c_uint32), "pdwFlags"),
                        (["out"], ctypes.POINTER(ctypes.c_uint64), "pu64DevicePosition"),
                        (["out"], ctypes.POINTER(ctypes.c_uint64), "pu64QPCPosition"),
                    ),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "ReleaseBuffer",
                        (["in"], ctypes.c_uint32, "NumFramesRead")),
                    comtypes.COMMETHOD([], comtypes.HRESULT, "GetNextPacketSize",
                        (["out"], ctypes.POINTER(ctypes.c_uint32), "pNumFramesInNextPacket")),
                ]

            class IActivateAudioInterfaceAsyncOperation(comtypes.IUnknown):
                _iid_ = comtypes.GUID("{72A22D78-CDE4-431D-B8CC-843A71199B6D}")
                _methods_ = [
                    comtypes.COMMETHOD([], comtypes.HRESULT, "GetActivateResult",
                        (["out"], ctypes.POINTER(ctypes.c_long), "activateResult"),
                        (["out"], ctypes.POINTER(ctypes.POINTER(comtypes.IUnknown)), "activatedInterface"),
                    ),
                ]

            class IActivateAudioInterfaceCompletionHandler(comtypes.IUnknown):
                _iid_ = comtypes.GUID("{41D949AB-9862-444A-80F6-C261334DA5EB}")
                _methods_ = [
                    comtypes.COMMETHOD([], comtypes.HRESULT, "ActivateCompleted",
                        (["in"], ctypes.POINTER(IActivateAudioInterfaceAsyncOperation), "activateOperation"),
                    ),
                ]

            # IAgileObject — required marker interface; ActivateAudioInterfaceAsync
            # calls QueryInterface for this before launching the async op.
            # Without it the call returns E_ILLEGAL_METHOD_CALL (0x8000000E).
            class IAgileObject(comtypes.IUnknown):
                _iid_ = comtypes.GUID("{94EA2B94-E9CC-49E0-C0FF-EE64CA8F5B90}")
                _methods_ = []

            # ── Completion handler ────────────────────────────────────────────
            # Call GetActivateResult inside the callback so we hold a strong
            # reference to the IAudioClient before returning S_OK.

            _done   = threading.Event()
            _result: dict = {}

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

            handler = _Handler()

            # ── Activation params ─────────────────────────────────────────────

            class _ActivationParams(ctypes.Structure):
                _fields_ = [
                    ("ActivationType",      ctypes.c_uint32),  # 1 = PROCESS_LOOPBACK
                    ("TargetProcessId",     ctypes.c_uint32),
                    ("ProcessLoopbackMode", ctypes.c_uint32),  # 0 = include child tree
                ]

            class _PropVarBlob(ctypes.Structure):
                # 64-bit PROPVARIANT layout: vt(2)+3×pad(2)+cbSize(4)+[4 align]+ptr(8) = 24 bytes
                _fields_ = [
                    ("vt",        ctypes.c_uint16),
                    ("r1",        ctypes.c_uint16),
                    ("r2",        ctypes.c_uint16),
                    ("r3",        ctypes.c_uint16),
                    ("cbSize",    ctypes.c_uint32),
                    ("pBlobData", ctypes.c_void_p),  # at offset 16 after natural alignment
                ]

            act_params     = _ActivationParams(1, self._pid, 0)
            act_params_ref = ctypes.pointer(act_params)
            propvar        = _PropVarBlob()
            propvar.vt        = 65   # VT_BLOB
            propvar.cbSize    = ctypes.sizeof(act_params)
            propvar.pBlobData = ctypes.cast(act_params_ref, ctypes.c_void_p)

            # ── ActivateAudioInterfaceAsync ───────────────────────────────────

            _activate_fn = ctypes.WinDLL("mmdevapi").ActivateAudioInterfaceAsync
            _activate_fn.restype  = ctypes.c_long
            _activate_fn.argtypes = [
                ctypes.c_wchar_p,
                ctypes.POINTER(comtypes.GUID),
                ctypes.c_void_p,
                ctypes.c_void_p,
                ctypes.POINTER(ctypes.c_void_p),
            ]

            iid_client    = IAudioClient._iid_
            handler_iface = handler.QueryInterface(IActivateAudioInterfaceCompletionHandler)
            async_op_raw  = ctypes.c_void_p(0)

            hr = _activate_fn(
                "VAD\\Process_Loopback",
                ctypes.byref(iid_client),
                ctypes.byref(propvar),
                ctypes.cast(handler_iface, ctypes.c_void_p),
                ctypes.byref(async_op_raw),
            )
            if hr != 0:
                raise OSError(f"ActivateAudioInterfaceAsync hr=0x{hr & 0xFFFFFFFF:08X}")

            if not _done.wait(timeout=5.0):
                raise TimeoutError("Process loopback activation timed out (5 s)")

            if "error" in _result:
                raise RuntimeError(_result["error"])
            if _result.get("hr", -1) != 0:
                raise OSError(f"GetActivateResult hr=0x{_result['hr'] & 0xFFFFFFFF:08X}")

            audio_client = _result["client"]

            # ── Initialize with hardcoded PCM format ──────────────────────────
            # 16-bit signed PCM, stereo, 44100 Hz — matches Microsoft sample.
            # Do NOT call GetMixFormat(): it returns E_NOTIMPL on process loopback.
            # Do NOT combine AUDCLNT_STREAMFLAGS_EVENTCALLBACK with LOOPBACK — broken.

            fmt = WAVEFORMATEX()
            fmt.wFormatTag      = 1        # WAVE_FORMAT_PCM
            fmt.nChannels       = 2
            fmt.nSamplesPerSec  = 44100
            fmt.wBitsPerSample  = 16
            fmt.nBlockAlign     = fmt.nChannels * fmt.wBitsPerSample // 8   # 4
            fmt.nAvgBytesPerSec = fmt.nSamplesPerSec * fmt.nBlockAlign      # 176400
            fmt.cbSize          = 0

            AUDCLNT_STREAMFLAGS_LOOPBACK = 0x00020000

            audio_client.Initialize(
                0,                            # AUDCLNT_SHAREMODE_SHARED
                AUDCLNT_STREAMFLAGS_LOOPBACK,
                10_000_000,                   # 1-second buffer (100-ns units)
                0,
                ctypes.byref(fmt),
                None,
            )

            iid_cap = IAudioCaptureClient._iid_
            capture = audio_client.GetService(
                ctypes.byref(iid_cap)
            ).QueryInterface(IAudioCaptureClient)

            # ── Capture loop ───────────────────────────────────────────────────

            audio_client.Start()

            SILENT          = 0x02   # AUDCLNT_BUFFERFLAGS_SILENT
            bytes_per_frame = (fmt.wBitsPerSample // 8) * fmt.nChannels   # 4
            native_rate     = fmt.nSamplesPerSec                           # 44100
            pending: list[np.ndarray] = []

            while not self._stop.is_set():
                packet_frames = capture.GetNextPacketSize()

                while packet_frames > 0:
                    data_ptr, n_frames, flags, _, _ = capture.GetBuffer()

                    if n_frames > 0 and not (flags & SILENT):
                        n_bytes = n_frames * bytes_per_frame
                        addr    = ctypes.cast(data_ptr, ctypes.c_void_p).value
                        raw     = bytes((ctypes.c_char * n_bytes).from_address(addr))

                        arr = np.frombuffer(raw, dtype=np.int16).astype(np.float32) / 32768.0

                        if fmt.nChannels == 2 and len(arr) % 2 == 0:
                            arr = arr.reshape(-1, 2).mean(axis=1).astype(np.float32)

                        if native_rate != SAMPLE_RATE and len(arr) > 1:
                            tgt = max(1, int(len(arr) * SAMPLE_RATE / native_rate))
                            arr = np.interp(
                                np.linspace(0, len(arr) - 1, tgt),
                                np.arange(len(arr)),
                                arr.astype(np.float64),
                            ).astype(np.float32)

                        pending.append(arr)
                        combined = np.concatenate(pending)
                        while len(combined) >= FRAME_SAMPLES:
                            chunk = np.clip(combined[:FRAME_SAMPLES], -1.0, 1.0)
                            self._captured.append((chunk * 32767).astype(np.int16))
                            combined = combined[FRAME_SAMPLES:]
                        pending = [combined] if len(combined) else []

                    capture.ReleaseBuffer(n_frames)
                    packet_frames = capture.GetNextPacketSize()

                time.sleep(0.005)

            audio_client.Stop()

        except Exception as exc:
            self.error = str(exc)
            print(f"\n  [wasapi-proc] {exc}", file=sys.stderr)
        finally:
            _ole32.CoUninitialize()


# ── PeerAudio ─────────────────────────────────────────────────────────────────

class PeerAudio:
    """Thread-safe PCM ring buffer + stereo gain state for one remote peer."""

    def __init__(self) -> None:
        self._buf: collections.deque[np.ndarray] = collections.deque(maxlen=MAX_BUFFER_FRAMES)
        self._lock = threading.Lock()
        self.gain_l: float = 1.0
        self.gain_r: float = 1.0

    def put(self, frame: np.ndarray) -> None:
        with self._lock:
            self._buf.append(frame)

    def get(self) -> np.ndarray | None:
        with self._lock:
            return self._buf.popleft() if self._buf else None

    def set_gains(self, gain_l: float, gain_r: float) -> None:
        self.gain_l = gain_l
        self.gain_r = gain_r

    @property
    def buffer_ms(self) -> float:
        return len(self._buf) * 20.0


# ── AudioEngine ───────────────────────────────────────────────────────────────

class AudioEngine:
    """
    Manages audio capture and multi-peer stereo playback.

    Capture frames land in self._captured. Call pop_capture() from asyncio to
    drain frames for network send. Each peer has a PeerAudio buffer mixed at
    playback time with its individual (gain_l, gain_r).
    """

    def __init__(self) -> None:
        self._peers: dict[str, PeerAudio] = {}
        self._peers_lock = threading.Lock()
        self._captured: collections.deque[np.ndarray] = collections.deque(maxlen=100)
        self._streams: list = []
        self._loopback: _LoopbackCapture | None = None
        self._app_capture: _AppCapture | None = None
        # Human-readable device labels set by start_*()
        self.input_label: str = "--"
        self.output_label: str = "--"

    # ── Peer management ──────────────────────────────────────────────────────

    def add_peer(self, pid: str) -> PeerAudio:
        p = PeerAudio()
        with self._peers_lock:
            self._peers[pid] = p
        return p

    def remove_peer(self, pid: str) -> None:
        with self._peers_lock:
            self._peers.pop(pid, None)

    def get_peer(self, pid: str) -> PeerAudio | None:
        with self._peers_lock:
            return self._peers.get(pid)

    def pop_capture(self) -> np.ndarray | None:
        try:
            return self._captured.popleft()
        except IndexError:
            return None

    # ── Real-time callbacks ───────────────────────────────────────────────────

    def _capture_mono(self, indata: np.ndarray) -> None:
        """Ingest a captured frame (int16, mono or stereo) into the pipeline."""
        if indata.shape[1] == 1:
            self._captured.append(indata[:, 0].copy())
        else:
            combined = indata.astype(np.int32).sum(axis=1) // indata.shape[1]
            self._captured.append(combined.astype(np.int16))

    def _duplex_cb(self, indata, outdata, frames, _time, _status) -> None:
        self._capture_mono(indata)
        self._mix(outdata, frames)

    def _in_cb(self, indata, _frames, _time, _status) -> None:
        self._capture_mono(indata)

    def _out_cb(self, outdata, _frames, _time, _status) -> None:
        self._mix(outdata, _frames)

    def _mix(self, outdata: np.ndarray, _frames: int) -> None:
        n = outdata.shape[0]
        left = np.zeros(n, dtype=np.float32)
        right = np.zeros(n, dtype=np.float32)
        with self._peers_lock:
            peers = list(self._peers.values())
        for p in peers:
            frame = p.get()
            if frame is not None:
                s = frame.astype(np.float32) / 32768.0
                left += s * p.gain_l
                right += s * p.gain_r
        np.clip(left, -1.0, 1.0, out=left)
        np.clip(right, -1.0, 1.0, out=right)
        outdata[:, 0] = (left * 32767).astype(np.int16)
        outdata[:, 1] = (right * 32767).astype(np.int16)

    # ── Stream builders ───────────────────────────────────────────────────────

    def _open_input(self, device: int | str | None) -> sd.InputStream:
        return sd.InputStream(
            samplerate=SAMPLE_RATE,
            blocksize=FRAME_SAMPLES,
            channels=1,
            dtype="int16",
            device=_resolve_device(device),
            callback=self._in_cb,
            latency="low",
        )

    def _open_output(self, device: int | str | None = None) -> sd.OutputStream:
        return sd.OutputStream(
            samplerate=SAMPLE_RATE,
            blocksize=FRAME_SAMPLES,
            channels=2,
            dtype="int16",
            device=_resolve_device(device),
            callback=self._out_cb,
            latency="low",
        )

    def _device_label(self, device: int | str | None, kind: str) -> str:
        """Return a short human-readable label for a sounddevice device."""
        try:
            idx = _resolve_device(device)
            if idx is None:
                default_idx = sd.default.device[0 if kind == "in" else 1]
                info = sd.query_devices(default_idx)
                return f"{info['name'][:40]} [default]"
            info = sd.query_devices(idx)
            return info["name"][:40]
        except Exception:
            return str(device)

    # ── Public lifecycle ──────────────────────────────────────────────────────

    def start_solo(
        self,
        input_device: int | str | None = None,
        output_device: int | str | None = None,
        loopback: bool = False,
    ) -> None:
        if loopback:
            self._loopback = _LoopbackCapture(
                _resolve_device(input_device), self._captured
            )
            self._loopback.start()
            # Give the thread a moment to resolve the speaker name
            import time; time.sleep(0.15)
            self.input_label = f"{self._loopback.device_name[:40]} [loopback]"
            o = self._open_output(output_device)
            o.start()
            self._streams.append(o)
        else:
            s = sd.Stream(
                samplerate=SAMPLE_RATE,
                blocksize=FRAME_SAMPLES,
                channels=(1, 2),
                dtype="int16",
                device=(
                    _resolve_device(input_device),
                    _resolve_device(output_device),
                ),
                callback=self._duplex_cb,
                latency="low",
            )
            s.start()
            self._streams.append(s)
            self.input_label = self._device_label(input_device, "in")

        self.output_label = self._device_label(output_device, "out")

    def start_pair(
        self,
        input_device: int | str | None = None,
        output_device: int | str | None = None,
        loopback: bool = False,
    ) -> None:
        if loopback:
            self._loopback = _LoopbackCapture(
                _resolve_device(input_device), self._captured
            )
            self._loopback.start()
            import time; time.sleep(0.15)
            self.input_label = f"{self._loopback.device_name[:40]} [loopback]"
        else:
            i = self._open_input(input_device)
            i.start()
            self._streams.append(i)
            self.input_label = self._device_label(input_device, "in")

        o = self._open_output(output_device)
        o.start()
        self._streams.append(o)
        self.output_label = self._device_label(output_device, "out")

    def start_pair_app(
        self,
        pid: int | None,
        loopback_idx: int,
        display_name: str,
        output_device: int | str | None = None,
    ) -> None:
        """Capture audio from a specific app, preferring WinRT per-process isolation."""
        import time
        use_isolated = pid is not None and _WASAPIProcessCapture.is_available()
        if use_isolated:
            cap = _WASAPIProcessCapture(pid, display_name, self._captured)
            cap.start()
            time.sleep(0.35)
            if not cap.error:
                self._app_capture = cap
                self.input_label = f"{display_name[:44]} [app -- isolated]"
            else:
                print(f"\n  [wasapi-proc] isolated capture failed ({cap.error[:60]}), falling back to device loopback", file=sys.stderr)
                use_isolated = False  # fall through

        if not use_isolated:
            cap = _AppCapture(loopback_idx, display_name, self._captured)
            cap.start()
            time.sleep(0.15)
            self._app_capture = cap
            if cap.error:
                self.input_label = f"ERROR: {cap.error[:60]}"
            else:
                self.input_label = f"{display_name[:44]} [app -- device loopback]"
        o = self._open_output(output_device)
        o.start()
        self._streams.append(o)
        self.output_label = self._device_label(output_device, "out")

    def stop(self) -> None:
        if self._loopback:
            self._loopback.stop()
            self._loopback = None
        if self._app_capture:
            self._app_capture.stop()
            self._app_capture = None
        for s in self._streams:
            try:
                s.stop()
                s.close()
            except Exception:
                pass
        self._streams.clear()


# ── Device listing ────────────────────────────────────────────────────────────

def list_devices() -> None:
    """Print all audio devices (sounddevice) and loopback targets (soundcard)."""
    devices = sd.query_devices()
    apis = sd.query_hostapis()
    default_in  = sd.default.device[0]
    default_out = sd.default.device[1]

    col = "{:<4} {:<45} {:<10} {:<6} {:<6}  {}"
    print()
    print("── sounddevice devices (use index with --input-device / --output-device) ──")
    print()
    print(col.format("IDX", "NAME", "API", "IN ch", "OUT ch", "FLAGS"))
    print("─" * 94)
    for i, d in enumerate(devices):
        api_name = apis[d["hostapi"]]["name"]
        flags = []
        if i == default_in:
            flags.append("default-in")
        if i == default_out:
            flags.append("default-out")
        print(col.format(
            i,
            d["name"][:44],
            api_name[:10],
            d["max_input_channels"],
            d["max_output_channels"],
            ", ".join(flags) if flags else "",
        ))

    print()
    print("── loopback targets (use index with --loopback --input-device N) ──")
    print()
    try:
        import soundcard as sc
        speakers = sc.all_speakers()
        default_spk = sc.default_speaker()
        print(f"  {'IDX':<4}  {'NAME':<50}  FLAGS")
        print("  " + "─" * 65)
        for i, spk in enumerate(speakers):
            flag = "[default]" if spk.id == default_spk.id else ""
            print(f"  {i:<4}  {spk.name[:50]:<50}  {flag}")
        print()
        print("  --loopback                     capture from default output speaker")
        print("  --loopback --input-device N    N = sounddevice output device index from table above")
    except ImportError:
        print("  soundcard not installed — run: uv add soundcard")
    print()
