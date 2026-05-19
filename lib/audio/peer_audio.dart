import 'dart:collection';
import 'dart:typed_data';

import '../protocol/protocol.dart';

/// Thread-safe (via Dart single-threaded event loop) ring buffer for one peer's
/// decoded audio frames. Holds up to [kMaxBufferFrames] (12) frames = ~240 ms.
class PeerAudio {
  final _buf   = Queue<Int16List>();
  double gainL = 0.0;
  double gainR = 0.0;

  void put(Int16List frame) {
    if (_buf.length >= kMaxBufferFrames) _buf.removeFirst(); // drop oldest
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

  void clear() => _buf.clear();
}
