// fzprox_audio.dll — WASAPI capture + playback engine
// Exposes a simple C API for use via Dart FFI.
//
// Supports:
//   • Microphone capture     (shared-mode IAudioCaptureClient)
//   • System loopback        (AUDCLNT_STREAMFLAGS_LOOPBACK)
//   • Per-process loopback   (ActivateAudioInterfaceAsync, Win10 2004+)
//   • Stereo render          (IAudioRenderClient)
//
// All audio is normalised to mono int16 @ 48 kHz on the capture path and
// stereo int16 @ 48 kHz on the render path before/after WASAPI interaction.

#define NOMINMAX
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <mmdeviceapi.h>
#include <audioclient.h>
#include <audiopolicy.h>
#include <functiondiscoverykeys_devpkey.h>
#include <avrt.h>
#include <psapi.h>
#include <objbase.h>
#include <propvarutil.h>
#include <wrl/client.h>

#include <cstdint>
#include <cstring>
#include <cmath>
#include <string>
#include <vector>
#include <deque>
#include <thread>
#include <mutex>
#include <atomic>
#include <sstream>
#include <algorithm>

#pragma comment(lib, "mmdevapi.lib")
#pragma comment(lib, "avrt.lib")
#pragma comment(lib, "ole32.lib")
#pragma comment(lib, "psapi.lib")
#pragma comment(lib, "propsys.lib")

using Microsoft::WRL::ComPtr;

#define FZPROX_AUDIO_EXPORTS
#include "audio_engine.h"

// ── Process-loopback structs (Windows 10 2004 / SDK 10.0.19041+) ─────────────
// Defined here so we don't require the newer SDK headers.

#ifndef AUDIOCLIENT_ACTIVATION_TYPE_PROCESS_LOOPBACK
typedef enum {
    AUDIOCLIENT_ACTIVATION_TYPE_DEFAULT        = 0,
    AUDIOCLIENT_ACTIVATION_TYPE_PROCESS_LOOPBACK = 1,
} AUDIOCLIENT_ACTIVATION_TYPE;

typedef enum {
    PROCESS_LOOPBACK_MODE_INCLUDE_TARGET_PROCESS_TREE = 0,
    PROCESS_LOOPBACK_MODE_EXCLUDE_TARGET_PROCESS_TREE = 1,
} PROCESS_LOOPBACK_MODE;

typedef struct {
    DWORD                TargetProcessId;
    PROCESS_LOOPBACK_MODE ProcessLoopbackMode;
} AUDIOCLIENT_PROCESS_LOOPBACK_PARAMS;

typedef struct {
    AUDIOCLIENT_ACTIVATION_TYPE ActivationType;
    union { AUDIOCLIENT_PROCESS_LOOPBACK_PARAMS ProcessLoopbackParams; };
} AUDIOCLIENT_ACTIVATION_PARAMS;

// Device string accepted by ActivateAudioInterfaceAsync for process loopback
#define VIRTUAL_AUDIO_DEVICE_PROCESS_LOOPBACK L"VAD\\Process_Loopback"
#endif

// ── Constants ─────────────────────────────────────────────────────────────────

static const int kSampleRate    = 48000;
static const int kFrameSamples  = 960;       // 20 ms @ 48 kHz
static const int kMaxQueueLen   = 24;        // ~480 ms capture buffer headroom
static const int kMaxRenderLen  = 24;

// ── Error string ──────────────────────────────────────────────────────────────

static char g_lastError[512] = {};

static void SetError(const char* msg) {
    strncpy_s(g_lastError, sizeof(g_lastError), msg, _TRUNCATE);
}

// ── COM initialisation ────────────────────────────────────────────────────────

static void EnsureCom() {
    static thread_local bool inited = false;
    if (!inited) {
        CoInitializeEx(nullptr, COINIT_MULTITHREADED);
        inited = true;
    }
}

// ── Cached device lists (populated by fzp_list_*) ────────────────────────────

struct DevEntry { std::wstring id; std::wstring name; };

static std::vector<DevEntry> g_inputDevices;
static std::vector<DevEntry> g_outputDevices;
static std::mutex            g_devMtx;

// ── Format helpers ────────────────────────────────────────────────────────────

static bool IsFloat(const WAVEFORMATEX* fmt) {
    if (fmt->wFormatTag == WAVE_FORMAT_IEEE_FLOAT) return true;
    if (fmt->wFormatTag == WAVE_FORMAT_EXTENSIBLE) {
        const auto* ex = reinterpret_cast<const WAVEFORMATEXTENSIBLE*>(fmt);
        return ex->SubFormat == KSDATAFORMAT_SUBTYPE_IEEE_FLOAT;
    }
    return false;
}

static int16_t ClampI16(float f) {
    f = f < -1.f ? -1.f : (f > 1.f ? 1.f : f);
    return static_cast<int16_t>(f * 32767.f);
}

// Convert raw WASAPI capture buffer → mono int16 @ device sample rate.
static void ToMonoI16(const BYTE* src, const WAVEFORMATEX* fmt,
                      UINT32 frames, int16_t* dst) {
    const int ch = fmt->nChannels;
    if (IsFloat(fmt)) {
        const float* s = reinterpret_cast<const float*>(src);
        for (UINT32 i = 0; i < frames; ++i) {
            float sum = 0.f;
            for (int c = 0; c < ch; ++c) sum += s[i * ch + c];
            dst[i] = ClampI16(sum / ch);
        }
    } else {
        const int16_t* s = reinterpret_cast<const int16_t*>(src);
        if (ch == 1) {
            memcpy(dst, s, frames * sizeof(int16_t));
        } else {
            for (UINT32 i = 0; i < frames; ++i) {
                int32_t sum = 0;
                for (int c = 0; c < ch; ++c) sum += s[i * ch + c];
                dst[i] = static_cast<int16_t>(sum / ch);
            }
        }
    }
}

// Linear resample mono int16 from srcRate → 48 kHz.
static std::vector<int16_t> Resample(const int16_t* src, int n, int srcRate) {
    if (srcRate == kSampleRate) return std::vector<int16_t>(src, src + n);
    double ratio   = static_cast<double>(kSampleRate) / srcRate;
    int    dstN    = static_cast<int>(n * ratio + 0.5);
    std::vector<int16_t> out(dstN);
    for (int i = 0; i < dstN; ++i) {
        double si  = i / ratio;
        int    lo  = static_cast<int>(si);
        int    hi  = lo + 1 < n ? lo + 1 : lo;
        double f   = si - lo;
        out[i] = static_cast<int16_t>(src[lo] * (1.0 - f) + src[hi] * f);
    }
    return out;
}

// ── Shared thread-safe ring buffer ────────────────────────────────────────────

template<int MaxLen>
struct FrameQueue {
    std::mutex                       mtx;
    std::deque<std::vector<int16_t>> q;

    void push(const int16_t* data, int n) {
        std::vector<int16_t> v(data, data + n);
        std::lock_guard<std::mutex> lk(mtx);
        if (static_cast<int>(q.size()) >= MaxLen) q.pop_front();
        q.push_back(std::move(v));
    }

    bool pop(int16_t* dst, int n) {
        std::lock_guard<std::mutex> lk(mtx);
        if (q.empty()) return false;
        auto& f = q.front();
        int c = static_cast<int>(std::min(f.size(), static_cast<size_t>(n)));
        memcpy(dst, f.data(), c * sizeof(int16_t));
        if (n > c) memset(dst + c, 0, (n - c) * sizeof(int16_t));
        q.pop_front();
        return true;
    }

    bool popAny(std::vector<int16_t>& out) {
        std::lock_guard<std::mutex> lk(mtx);
        if (q.empty()) return false;
        out = std::move(q.front());
        q.pop_front();
        return true;
    }

    void clear() {
        std::lock_guard<std::mutex> lk(mtx);
        q.clear();
    }
};

// ── Capture context ───────────────────────────────────────────────────────────

struct CaptureCtx {
    ComPtr<IAudioClient>        client;
    ComPtr<IAudioCaptureClient> capturer;
    WAVEFORMATEX*               fmt     = nullptr;
    HANDLE                      event   = nullptr;
    std::thread                 thread;
    std::atomic<bool>           running { false };
    FrameQueue<kMaxQueueLen>    queue;

    void stop() {
        running = false;
        if (thread.joinable()) thread.join();
        if (fmt)   { CoTaskMemFree(fmt); fmt = nullptr; }
        if (event) { CloseHandle(event); event = nullptr; }
        capturer.Reset();
        client.Reset();
        queue.clear();
    }
};

// ── Render context ────────────────────────────────────────────────────────────

struct RenderCtx {
    ComPtr<IAudioClient>       client;
    ComPtr<IAudioRenderClient> renderer;
    WAVEFORMATEX*              fmt     = nullptr;
    HANDLE                     event   = nullptr;
    std::thread                thread;
    std::atomic<bool>          running { false };
    FrameQueue<kMaxRenderLen>  queue;

    void stop() {
        running = false;
        if (thread.joinable()) thread.join();
        if (fmt)   { CoTaskMemFree(fmt); fmt = nullptr; }
        if (event) { CloseHandle(event); event = nullptr; }
        renderer.Reset();
        client.Reset();
        queue.clear();
    }
};

static CaptureCtx g_cap;
static RenderCtx  g_rnd;

// ── Capture thread ────────────────────────────────────────────────────────────

static void CaptureThread() {
    CoInitializeEx(nullptr, COINIT_MULTITHREADED);

    DWORD taskIdx = 0;
    HANDLE avTask = AvSetMmThreadCharacteristicsW(L"Pro Audio", &taskIdx);

    const WAVEFORMATEX* fmt      = g_cap.fmt;
    const int           devRate  = static_cast<int>(fmt->nSamplesPerSec);

    g_cap.client->Start();

    std::vector<int16_t> accum;
    accum.reserve(kFrameSamples * 4);

    while (g_cap.running) {
        if (g_cap.event) {
            if (WaitForSingleObject(g_cap.event, 200) != WAIT_OBJECT_0) continue;
        } else {
            Sleep(5); // Timer-driven polling for Process Loopback
        }

        UINT32 packetLength = 0;
        while (SUCCEEDED(g_cap.capturer->GetNextPacketSize(&packetLength)) && packetLength > 0) {
            BYTE*  data   = nullptr;
            UINT32 frames = 0;
            DWORD  flags  = 0;

            if (FAILED(g_cap.capturer->GetBuffer(&data, &frames, &flags, nullptr, nullptr))) break;
            
            std::vector<int16_t> mono(frames);
            if (flags & AUDCLNT_BUFFERFLAGS_SILENT) {
                memset(mono.data(), 0, frames * sizeof(int16_t));
            } else {
                ToMonoI16(data, fmt, frames, mono.data());
            }
            g_cap.capturer->ReleaseBuffer(frames);

            auto resampled = Resample(mono.data(), static_cast<int>(frames), devRate);
            for (auto s : resampled) accum.push_back(s);

            while (static_cast<int>(accum.size()) >= kFrameSamples) {
                g_cap.queue.push(accum.data(), kFrameSamples);
                accum.erase(accum.begin(), accum.begin() + kFrameSamples);
            }
        }
    }

    g_cap.client->Stop();
    if (avTask) AvRevertMmThreadCharacteristics(avTask);
    CoUninitialize();
}

// ── Render thread ─────────────────────────────────────────────────────────────

static void RenderThread() {
    CoInitializeEx(nullptr, COINIT_MULTITHREADED);

    DWORD taskIdx = 0;
    HANDLE avTask = AvSetMmThreadCharacteristicsW(L"Pro Audio", &taskIdx);

    const WAVEFORMATEX* fmt      = g_rnd.fmt;
    const int           devCh    = fmt->nChannels;
    const bool          devFloat = IsFloat(fmt);

    UINT32 bufSize = 0;
    g_rnd.client->GetBufferSize(&bufSize);
    g_rnd.client->Start();

    std::vector<int16_t> pending; // interleaved stereo int16 @ 48 kHz

    while (g_rnd.running) {
        if (WaitForSingleObject(g_rnd.event, 200) != WAIT_OBJECT_0) continue;

        UINT32 padding   = 0;
        g_rnd.client->GetCurrentPadding(&padding);
        UINT32 available = bufSize - padding;
        if (available == 0) continue;

        // Refill pending from queue when depleted
        if (pending.empty()) {
            if (!g_rnd.queue.popAny(pending)) {
                // Silence
                BYTE* buf = nullptr;
                if (SUCCEEDED(g_rnd.renderer->GetBuffer(available, &buf))) {
                    memset(buf, 0, available * fmt->nBlockAlign);
                    g_rnd.renderer->ReleaseBuffer(available, 0);
                }
                continue;
            }
        }

        // pending[i] = { L0,R0, L1,R1, … } (stereo interleaved)
        UINT32 srcFrames    = static_cast<UINT32>(pending.size() / 2);
        UINT32 framesToWrite = std::min(available, srcFrames);

        BYTE* buf = nullptr;
        if (SUCCEEDED(g_rnd.renderer->GetBuffer(framesToWrite, &buf))) {
            const int16_t* src = pending.data();
            if (devFloat) {
                float* dst = reinterpret_cast<float*>(buf);
                for (UINT32 i = 0; i < framesToWrite; ++i) {
                    for (int c = 0; c < devCh && c < 2; ++c)
                        dst[i * devCh + c] = src[i * 2 + c] / 32768.f;
                    for (int c = 2; c < devCh; ++c)
                        dst[i * devCh + c] = 0.f;
                }
            } else {
                int16_t* dst = reinterpret_cast<int16_t*>(buf);
                for (UINT32 i = 0; i < framesToWrite; ++i) {
                    for (int c = 0; c < devCh && c < 2; ++c)
                        dst[i * devCh + c] = src[i * 2 + c];
                    for (int c = 2; c < devCh; ++c)
                        dst[i * devCh + c] = 0;
                }
            }
            g_rnd.renderer->ReleaseBuffer(framesToWrite, 0);
        }

        // Consume written frames from pending
        int used = static_cast<int>(framesToWrite) * 2;
        if (used < static_cast<int>(pending.size()))
            pending.erase(pending.begin(), pending.begin() + used);
        else
            pending.clear();
    }

    g_rnd.client->Stop();
    if (avTask) AvRevertMmThreadCharacteristics(avTask);
    CoUninitialize();
}

// ── WASAPI helpers ────────────────────────────────────────────────────────────

static ComPtr<IMMDeviceEnumerator> MakeEnumerator() {
    ComPtr<IMMDeviceEnumerator> e;
    CoCreateInstance(__uuidof(MMDeviceEnumerator), nullptr, CLSCTX_ALL,
                     IID_PPV_ARGS(&e));
    return e;
}

static std::wstring DeviceName(IMMDevice* dev) {
    ComPtr<IPropertyStore> ps;
    if (FAILED(dev->OpenPropertyStore(STGM_READ, &ps))) return L"Unknown";
    PROPVARIANT pv; PropVariantInit(&pv);
    ps->GetValue(PKEY_Device_FriendlyName, &pv);
    std::wstring n = (pv.vt == VT_LPWSTR && pv.pwszVal) ? pv.pwszVal : L"Unknown";
    PropVariantClear(&pv);
    return n;
}

static std::wstring DeviceId(IMMDevice* dev) {
    LPWSTR id = nullptr;
    dev->GetId(&id);
    std::wstring s = id ? id : L"";
    CoTaskMemFree(id);
    return s;
}

enum class CaptureMode {
    Mic,
    Loopback,
    Process
};

// Initialise a shared-mode IAudioClient.
// For Process Loopback, event-driven capture and GetMixFormat are unsupported.
static HRESULT InitAudioClient(IAudioClient* client, CaptureMode mode,
                                WAVEFORMATEX** outFmt, HANDLE* outEvent) {
    WAVEFORMATEX* mixFmt = nullptr;

    if (mode == CaptureMode::Process) {
        // VIRTUAL_AUDIO_DEVICE_PROCESS_LOOPBACK does not support GetMixFormat.
        // Hardcode to 16-bit PCM, 44100 Hz, Stereo.
        mixFmt = (WAVEFORMATEX*)CoTaskMemAlloc(sizeof(WAVEFORMATEX));
        if (!mixFmt) return E_OUTOFMEMORY;
        mixFmt->wFormatTag      = WAVE_FORMAT_PCM;
        mixFmt->nChannels       = 2;
        mixFmt->nSamplesPerSec  = 44100;
        mixFmt->wBitsPerSample  = 16;
        mixFmt->nBlockAlign     = (mixFmt->nChannels * mixFmt->wBitsPerSample) / 8;
        mixFmt->nAvgBytesPerSec = mixFmt->nSamplesPerSec * mixFmt->nBlockAlign;
        mixFmt->cbSize          = 0;
    } else {
        HRESULT hr = client->GetMixFormat(&mixFmt);
        if (FAILED(hr)) return hr;
    }

    DWORD flags = 0;
    if (mode == CaptureMode::Process) {
        flags = AUDCLNT_STREAMFLAGS_LOOPBACK; // No event callback for process!
    } else if (mode == CaptureMode::Loopback) {
        flags = AUDCLNT_STREAMFLAGS_EVENTCALLBACK | AUDCLNT_STREAMFLAGS_LOOPBACK;
    } else {
        flags = AUDCLNT_STREAMFLAGS_EVENTCALLBACK;
    }

    // 200 ms buffer (2000000 hns)
    HRESULT hr = client->Initialize(AUDCLNT_SHAREMODE_SHARED, flags,
                                    2000000, 0, mixFmt, nullptr);
    if (FAILED(hr)) { CoTaskMemFree(mixFmt); return hr; }

    HANDLE ev = nullptr;
    if (mode != CaptureMode::Process) {
        ev = CreateEventW(nullptr, FALSE, FALSE, nullptr);
        if (!ev) { CoTaskMemFree(mixFmt); return E_OUTOFMEMORY; }
        hr = client->SetEventHandle(ev);
        if (FAILED(hr)) { CoTaskMemFree(mixFmt); CloseHandle(ev); return hr; }
    }

    *outFmt   = mixFmt;
    *outEvent = ev;
    return S_OK;
}

// Get the n-th device from an IMMDeviceCollection.
static ComPtr<IMMDevice> GetDeviceByIndex(EDataFlow flow, int idx) {
    auto e = MakeEnumerator();
    if (!e) return nullptr;

    ComPtr<IMMDeviceCollection> col;
    if (FAILED(e->EnumAudioEndpoints(flow, DEVICE_STATE_ACTIVE, &col))) return nullptr;

    UINT count = 0;
    col->GetCount(&count);
    if (idx < 0 || static_cast<UINT>(idx) >= count) return nullptr;

    ComPtr<IMMDevice> dev;
    col->Item(static_cast<UINT>(idx), &dev);
    return dev;
}

// ── Async activation handler (per-process loopback) ──────────────────────────

class CompletionHandler
    : public IActivateAudioInterfaceCompletionHandler,
      public IAgileObject
{
public:
    HANDLE               m_event;
    HRESULT              m_result = E_FAIL;
    ComPtr<IAudioClient> m_client;

    CompletionHandler() : m_event(CreateEventW(nullptr, TRUE, FALSE, nullptr)) {}
    ~CompletionHandler() { if (m_event) CloseHandle(m_event); }

    HRESULT STDMETHODCALLTYPE ActivateCompleted(
        IActivateAudioInterfaceAsyncOperation* op) override
    {
        HRESULT hr = E_FAIL;
        ComPtr<IUnknown> unk;
        op->GetActivateResult(&hr, &unk);
        if (SUCCEEDED(hr) && unk) unk.As(&m_client);
        m_result = hr;
        SetEvent(m_event);
        return S_OK;
    }

    HRESULT STDMETHODCALLTYPE QueryInterface(REFIID riid, void** ppv) override {
        if (riid == IID_IUnknown ||
            riid == __uuidof(IActivateAudioInterfaceCompletionHandler)) {
            *ppv = static_cast<IActivateAudioInterfaceCompletionHandler*>(this);
            AddRef(); return S_OK;
        }
        if (riid == __uuidof(IAgileObject)) {
            *ppv = static_cast<IAgileObject*>(this);
            AddRef(); return S_OK;
        }
        *ppv = nullptr; return E_NOINTERFACE;
    }
    ULONG STDMETHODCALLTYPE AddRef()  override { return InterlockedIncrement(&m_ref); }
    ULONG STDMETHODCALLTYPE Release() override {
        ULONG r = InterlockedDecrement(&m_ref);
        if (r == 0) delete this;
        return r;
    }
private:
    LONG m_ref = 1;
};

// ── JSON helpers ──────────────────────────────────────────────────────────────

static std::string WToUtf8(const std::wstring& ws) {
    if (ws.empty()) return {};
    int n = WideCharToMultiByte(CP_UTF8, 0, ws.c_str(), -1,
                                nullptr, 0, nullptr, nullptr);
    std::string s(n - 1, '\0');
    WideCharToMultiByte(CP_UTF8, 0, ws.c_str(), -1, &s[0], n,
                        nullptr, nullptr);
    return s;
}

static std::string JsonStr(const std::string& s) {
    std::string out;
    out.reserve(s.size() + 8);
    out += '"';
    for (char c : s) {
        if      (c == '"')  out += "\\\"";
        else if (c == '\\') out += "\\\\";
        else if (c == '\n') out += "\\n";
        else if (c == '\r') out += "\\r";
        else                out += c;
    }
    out += '"';
    return out;
}

// ── Exported C functions ──────────────────────────────────────────────────────

extern "C" {

char* fzp_last_error() { return g_lastError; }

void fzp_free_string(char* s) { delete[] s; }

// ── Enumeration ───────────────────────────────────────────────────────────────

static char* EnumerateEndpoints(EDataFlow flow, std::vector<DevEntry>& cache) {
    EnsureCom();
    auto enumerator = MakeEnumerator();
    if (!enumerator) {
        SetError("Failed to create IMMDeviceEnumerator");
        auto* r = new char[3]; strcpy_s(r, 3, "[]"); return r;
    }

    ComPtr<IMMDeviceCollection> col;
    if (FAILED(enumerator->EnumAudioEndpoints(flow, DEVICE_STATE_ACTIVE, &col))) {
        auto* r = new char[3]; strcpy_s(r, 3, "[]"); return r;
    }

    UINT count = 0;
    col->GetCount(&count);

    std::lock_guard<std::mutex> lk(g_devMtx);
    cache.clear();
    cache.reserve(count);

    std::ostringstream ss;
    ss << '[';
    for (UINT i = 0; i < count; ++i) {
        ComPtr<IMMDevice> dev;
        if (FAILED(col->Item(i, &dev))) continue;

        DevEntry e;
        e.id   = DeviceId(dev.Get());
        e.name = DeviceName(dev.Get());
        cache.push_back(e);

        if (i > 0) ss << ',';
        ss << "{\"name\":" << JsonStr(WToUtf8(e.name)) << '}';
    }
    ss << ']';

    std::string json = ss.str();
    char* out = new char[json.size() + 1];
    memcpy(out, json.c_str(), json.size() + 1);
    return out;
}

char* fzp_list_input_devices()  { return EnumerateEndpoints(eCapture, g_inputDevices);  }
char* fzp_list_output_devices() { return EnumerateEndpoints(eRender,  g_outputDevices); }

char* fzp_list_audio_sessions() {
    EnsureCom();
    auto enumerator = MakeEnumerator();
    if (!enumerator) {
        auto* r = new char[3]; strcpy_s(r, 3, "[]"); return r;
    }

    // Enumerate output devices first so we can supply a loopback_idx
    std::vector<DevEntry> renderers;
    {
        ComPtr<IMMDeviceCollection> col;
        if (SUCCEEDED(enumerator->EnumAudioEndpoints(eRender, DEVICE_STATE_ACTIVE, &col))) {
            UINT n = 0; col->GetCount(&n);
            renderers.reserve(n);
            for (UINT i = 0; i < n; ++i) {
                ComPtr<IMMDevice> dev;
                if (FAILED(col->Item(i, &dev))) continue;
                DevEntry e; e.id = DeviceId(dev.Get()); e.name = DeviceName(dev.Get());
                renderers.push_back(e);
            }
        }
    }

    std::ostringstream ss;
    ss << '[';
    bool first = true;

    for (int ri = 0; ri < static_cast<int>(renderers.size()); ++ri) {
        ComPtr<IMMDevice> dev;
        if (FAILED(enumerator->GetDevice(renderers[ri].id.c_str(), &dev))) continue;

        ComPtr<IAudioSessionManager2> mgr;
        if (FAILED(dev->Activate(__uuidof(IAudioSessionManager2), CLSCTX_ALL,
                                  nullptr, reinterpret_cast<void**>(mgr.GetAddressOf()))))
            continue;

        ComPtr<IAudioSessionEnumerator> senum;
        if (FAILED(mgr->GetSessionEnumerator(&senum))) continue;

        int count = 0;
        senum->GetCount(&count);

        for (int si = 0; si < count; ++si) {
            ComPtr<IAudioSessionControl> ctrl;
            if (FAILED(senum->GetSession(si, &ctrl))) continue;

            ComPtr<IAudioSessionControl2> ctrl2;
            if (FAILED(ctrl.As(&ctrl2))) continue;

            DWORD pid = 0;
            ctrl2->GetProcessId(&pid);
            if (pid == 0) continue; // system session

            // Get process executable name
            char exeBuf[MAX_PATH] = {};
            HANDLE proc = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE, pid);
            if (proc) {
                DWORD sz = MAX_PATH;
                QueryFullProcessImageNameA(proc, 0, exeBuf, &sz);
                CloseHandle(proc);
                // Strip path, keep filename
                const char* slash = strrchr(exeBuf, '\\');
                if (slash) memmove(exeBuf, slash + 1, strlen(slash));
            }

            LPWSTR dispW = nullptr;
            ctrl->GetDisplayName(&dispW);
            std::string disp = (dispW && dispW[0]) ? WToUtf8(dispW) : exeBuf;
            if (dispW) CoTaskMemFree(dispW);

            if (!first) ss << ',';
            first = false;

            ss << "{\"pid\":" << pid
               << ",\"exe\":" << JsonStr(exeBuf)
               << ",\"name\":" << JsonStr(disp)
               << ",\"loopback_idx\":" << ri
               << ",\"device_name\":" << JsonStr(WToUtf8(renderers[ri].name))
               << ",\"shared_with\":1}";
        }
    }

    ss << ']';
    std::string json = ss.str();
    char* out = new char[json.size() + 1];
    memcpy(out, json.c_str(), json.size() + 1);
    return out;
}

// ── Capture ───────────────────────────────────────────────────────────────────

static bool StartCapture(ComPtr<IAudioClient> client, CaptureMode mode) {
    g_cap.stop();

    WAVEFORMATEX* fmt   = nullptr;
    HANDLE        event = nullptr;
    HRESULT hr = InitAudioClient(client.Get(), mode, &fmt, &event);
    if (FAILED(hr)) { SetError("IAudioClient::Initialize failed"); return false; }

    ComPtr<IAudioCaptureClient> capturer;
    hr = client->GetService(IID_PPV_ARGS(&capturer));
    if (FAILED(hr)) {
        CoTaskMemFree(fmt); CloseHandle(event);
        SetError("GetService(IAudioCaptureClient) failed");
        return false;
    }

    g_cap.client   = std::move(client);
    g_cap.capturer = std::move(capturer);
    g_cap.fmt      = fmt;
    g_cap.event    = event;
    g_cap.running  = true;
    g_cap.thread   = std::thread(CaptureThread);
    return true;
}

bool fzp_start_mic_capture(int32_t deviceIndex) {
    EnsureCom();
    ComPtr<IMMDevice> dev = GetDeviceByIndex(eCapture, deviceIndex);
    if (!dev) { SetError("Capture device index out of range"); return false; }

    ComPtr<IAudioClient> client;
    if (FAILED(dev->Activate(__uuidof(IAudioClient), CLSCTX_ALL,
                              nullptr, reinterpret_cast<void**>(client.GetAddressOf())))) {
        SetError("Failed to activate capture device"); return false;
    }
    return StartCapture(std::move(client), CaptureMode::Mic);
}

bool fzp_start_loopback_capture(int32_t deviceIndex) {
    EnsureCom();
    ComPtr<IMMDevice> dev = GetDeviceByIndex(eRender, deviceIndex);
    if (!dev) { SetError("Render device index out of range"); return false; }

    ComPtr<IAudioClient> client;
    if (FAILED(dev->Activate(__uuidof(IAudioClient), CLSCTX_ALL,
                              nullptr, reinterpret_cast<void**>(client.GetAddressOf())))) {
        SetError("Failed to activate render device for loopback"); return false;
    }
    return StartCapture(std::move(client), CaptureMode::Loopback);
}

bool fzp_start_process_capture(uint32_t pid) {
    EnsureCom();

    AUDIOCLIENT_ACTIVATION_PARAMS params = {};
    params.ActivationType = AUDIOCLIENT_ACTIVATION_TYPE_PROCESS_LOOPBACK;
    params.ProcessLoopbackParams.TargetProcessId  = pid;
    params.ProcessLoopbackParams.ProcessLoopbackMode =
        PROCESS_LOOPBACK_MODE_INCLUDE_TARGET_PROCESS_TREE;

    PROPVARIANT pv;
    PropVariantInit(&pv);
    pv.vt              = VT_BLOB;
    pv.blob.cbSize     = sizeof(params);
    pv.blob.pBlobData  = reinterpret_cast<BYTE*>(&params);

    auto* handler = new CompletionHandler();
    ComPtr<IActivateAudioInterfaceAsyncOperation> asyncOp;

    HRESULT hr = ActivateAudioInterfaceAsync(
        VIRTUAL_AUDIO_DEVICE_PROCESS_LOOPBACK,
        __uuidof(IAudioClient),
        &pv, handler, &asyncOp);

    if (FAILED(hr)) {
        handler->Release();
        SetError("ActivateAudioInterfaceAsync failed — requires Windows 10 2004+");
        return false;
    }

    WaitForSingleObject(handler->m_event, 8000);
    hr = handler->m_result;
    ComPtr<IAudioClient> client = handler->m_client;
    handler->Release();

    if (FAILED(hr) || !client) {
        SetError("Process loopback activation failed");
        return false;
    }
    return StartCapture(std::move(client), CaptureMode::Process);
}

bool fzp_read_capture_frame(int16_t* buf) {
    return g_cap.queue.pop(buf, kFrameSamples);
}

void fzp_stop_capture() {
    g_cap.stop();
}

// ── Playback ──────────────────────────────────────────────────────────────────

bool fzp_start_playback(int32_t deviceIndex) {
    EnsureCom();
    g_rnd.stop();

    ComPtr<IMMDevice> dev;
    if (deviceIndex < 0) {
        auto e = MakeEnumerator();
        if (!e || FAILED(e->GetDefaultAudioEndpoint(eRender, eConsole, &dev))) {
            SetError("No default output device"); return false;
        }
    } else {
        dev = GetDeviceByIndex(eRender, deviceIndex);
        if (!dev) { SetError("Output device index out of range"); return false; }
    }

    ComPtr<IAudioClient> client;
    if (FAILED(dev->Activate(__uuidof(IAudioClient), CLSCTX_ALL,
                              nullptr, reinterpret_cast<void**>(client.GetAddressOf())))) {
        SetError("Failed to activate output device"); return false;
    }

    WAVEFORMATEX* fmt   = nullptr;
    HANDLE        event = nullptr;
    if (FAILED(InitAudioClient(client.Get(), CaptureMode::Mic, &fmt, &event))) {
        SetError("IAudioClient::Initialize (render) failed"); return false;
    }

    ComPtr<IAudioRenderClient> renderer;
    if (FAILED(client->GetService(IID_PPV_ARGS(&renderer)))) {
        CoTaskMemFree(fmt); CloseHandle(event);
        SetError("GetService(IAudioRenderClient) failed"); return false;
    }

    g_rnd.client   = std::move(client);
    g_rnd.renderer = std::move(renderer);
    g_rnd.fmt      = fmt;
    g_rnd.event    = event;
    g_rnd.running  = true;
    g_rnd.thread   = std::thread(RenderThread);
    return true;
}

void fzp_write_playback_frame(const int16_t* left, const int16_t* right) {
    // Interleave L+R into a single stereo frame and push to render queue.
    static_assert(sizeof(int16_t) == 2, "");
    int16_t buf[kFrameSamples * 2];
    for (int i = 0; i < kFrameSamples; ++i) {
        buf[i * 2]     = left[i];
        buf[i * 2 + 1] = right[i];
    }
    g_rnd.queue.push(buf, kFrameSamples * 2);
}

void fzp_stop_playback() {
    g_rnd.stop();
}

} // extern "C"

// ── DLL entry point ───────────────────────────────────────────────────────────

BOOL WINAPI DllMain(HINSTANCE, DWORD reason, LPVOID) {
    switch (reason) {
        case DLL_PROCESS_DETACH:
            g_cap.stop();
            g_rnd.stop();
            break;
    }
    return TRUE;
}
