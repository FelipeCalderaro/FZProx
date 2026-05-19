#pragma once
#include <cstdint>

#ifdef FZPROX_AUDIO_EXPORTS
#  define FZP_API __declspec(dllexport)
#else
#  define FZP_API __declspec(dllimport)
#endif

extern "C" {

// ── Device / session enumeration ──────────────────────────────────────────────
// All three return a heap-allocated UTF-8 JSON string.
// The caller MUST pass it back to fzp_free_string when done.
FZP_API char* fzp_list_input_devices();
FZP_API char* fzp_list_output_devices();
FZP_API char* fzp_list_audio_sessions();
FZP_API void  fzp_free_string(char* s);

// Returns a pointer to a static buffer — do NOT pass to fzp_free_string.
FZP_API char* fzp_last_error();

// ── Capture ───────────────────────────────────────────────────────────────────
// device_index indexes into the list returned by fzp_list_input_devices.
// Returns true on success.  Only one capture source may be active at a time.
FZP_API bool fzp_start_mic_capture(int32_t device_index);

// device_index indexes into the list returned by fzp_list_output_devices.
FZP_API bool fzp_start_loopback_capture(int32_t device_index);

// Capture audio from the process with the given PID (Windows 10 2004+).
FZP_API bool fzp_start_process_capture(uint32_t pid);

// Reads one 960-sample (20 ms @ 48 kHz) mono int16 frame into buf.
// Returns false when the internal ring buffer is empty.
FZP_API bool fzp_read_capture_frame(int16_t* buf);

FZP_API void fzp_stop_capture();

// ── Playback ──────────────────────────────────────────────────────────────────
// device_index indexes into fzp_list_output_devices; pass -1 for the system
// default output device.
FZP_API bool fzp_start_playback(int32_t device_index);

// Enqueues one stereo frame (960 samples per channel, int16).
FZP_API void fzp_write_playback_frame(const int16_t* left, const int16_t* right);

FZP_API void fzp_stop_playback();

} // extern "C"
