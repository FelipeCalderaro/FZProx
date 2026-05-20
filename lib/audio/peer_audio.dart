import 'dart:collection';
import 'dart:typed_data';

import '../protocol/protocol.dart';

// ── Comb-filter reverb constants ──────────────────────────────────────────────
// Delay line = 30 ms @ 48 kHz = 1440 samples.
const int    _kDelayLen  = 1440;
// Maximum feedback (tail length). Actual feedback = _kFeedbackMax * _reverbMix.
const double _kFeedbackMax = 0.55;
// How quickly the reverb mix fades when Doppler returns to unity.
const double _kDecayAlpha  = 0.05; // EMA decay towards 0

/// Thread-safe (via Dart single-threaded event loop) ring buffer for one peer's
/// decoded audio frames. Holds up to [kMaxBufferFrames] (12) frames = ~240 ms.
///
/// Also owns a per-peer comb-filter reverb tail driven by the Doppler factor:
///   factor > 1.2  →  fast approach  →  reverb fades in
///   factor < 0.8  →  fast recession  →  reverb fades in
///   factor ≈ 1.0  →  no relative motion → reverb decays to 0
class PeerAudio {
  final _buf   = Queue<Int16List>();
  double gainL = 0.0;
  double gainR = 0.0;

  // ── Reverb state ─────────────────────────────────────────────────────────
  final _delay   = Float32List(_kDelayLen); // circular delay line
  int    _dWrite = 0;                        // write head
  double _reverbMix = 0.0;                  // current EMA mix (0 → 1)

  void put(Int16List frame) {
    if (_buf.length >= kMaxBufferFrames) _buf.removeFirst();
    _buf.addLast(frame);
  }

  /// Returns the next frame, or null if buffer is empty (underrun).
  Int16List? get() => _buf.isEmpty ? null : _buf.removeFirst();

  /// Current buffer fill level in milliseconds.
  int get bufferMs =>
      (_buf.length * kFrameSamples * 1000 / kSampleRate).round();

  void setGains(double l, double r) {
    gainL = l;
    gainR = r;
  }

  /// Updated by the gain loop (SessionBloc) so the mix loop always has the
  /// latest factor without needing an extra parameter on every [processFrame] call.
  double dopplerFactor = 1.0;

  // ── Reverb processing ─────────────────────────────────────────────────────

  /// Update the reverb mix target based on the current Doppler factor and
  /// return the processed (wet+dry) frame as a Float64List of [kFrameSamples]
  /// normalised samples (–1 … +1), already scaled by [gainL] for the left
  /// channel.  The caller must apply [gainR] separately for stereo.
  ///
  /// [rawFrame] is the Int16List from the peer buffer.
  /// [dopplerFactor] drives how strong the reverb tail is.
  ({Float64List mono}) processFrame(Int16List rawFrame, double dopplerFactor) {
    // Target mix: deviation from unity → reverb; unity → silence
    final deviation = (dopplerFactor - 1.0).abs();
    final target    = (deviation > 0.1) ? ((deviation - 0.1) / 0.9).clamp(0.0, 0.85) : 0.0;
    // EMA toward target
    _reverbMix = _kDecayAlpha * target + (1.0 - _kDecayAlpha) * _reverbMix;

    final feedback = _kFeedbackMax * _reverbMix;
    final wet      = _reverbMix * 0.4;   // wet blend (capped so it never drowns dry)
    final dry      = 1.0 - wet * 0.5;

    final out = Float64List(kFrameSamples);
    for (var i = 0; i < kFrameSamples; i++) {
      final inputSample = rawFrame[i] / 32768.0;

      // Read from delay
      final readIdx    = (_dWrite - _kDelayLen + _kDelayLen) % _kDelayLen;
      final delaySample = _delay[readIdx];

      // Write to delay: mix input + feedback
      _delay[_dWrite] = (inputSample + delaySample * feedback).clamp(-1.0, 1.0).toDouble();
      _dWrite = (_dWrite + 1) % _kDelayLen;

      out[i] = inputSample * dry + delaySample * wet;
    }
    return (mono: out);
  }

  void clear() {
    _buf.clear();
    _delay.fillRange(0, _kDelayLen, 0.0);
    _dWrite    = 0;
    _reverbMix = 0.0;
  }
}
