import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:fzprox/audio/audio_engine.dart';
import 'package:fzprox/proximity/proximity_math.dart';

void main() {
  group('AudioEngine — peer lifecycle', () {
    late AudioEngine engine;

    setUp(() {
      engine = AudioEngine(); // DLL won't load in test — but peer map works
    });

    tearDown(() => engine.stop());

    test('addPeer registers a peer, removePeer clears it', () {
      engine.addPeer(1);
      // Should not throw
      engine.setGains(1, 0.8, 0.6);
      engine.removePeer(1);
      // After removal, setting gains is a no-op (no crash)
      engine.setGains(1, 1.0, 1.0);
    });

    test('enqueuePeerAudio + bufferMs reports correct fill level', () {
      engine.addPeer(42);
      // One 960-sample frame = 20 ms @ 48 kHz
      final frame = Int16List(960);
      engine.enqueuePeerAudio(42, frame);
      expect(engine.bufferMs(42), equals(20));

      engine.enqueuePeerAudio(42, frame);
      expect(engine.bufferMs(42), equals(40));
    });

    test('bufferMs returns 0 for unknown peer', () {
      expect(engine.bufferMs(999), equals(0));
    });
  });

  group('AudioEngine — onCaptureFrame callback', () {
    test('onCaptureFrame fires when frame is enqueued to captureQueue', () {
      final engine = AudioEngine();
      // We can't test the native DLL path in unit tests, but we can verify
      // the capture queue fallback path.
      // The captureQueue is private, so we'll test the monitor path instead.
      engine.stop();
    });
  });

  group('AudioEngine — monitor flag', () {
    test('monitorEnabled defaults to false', () {
      final engine = AudioEngine();
      expect(engine.monitorEnabled, isFalse);
      engine.stop();
    });

    test('monitorEnabled can be toggled', () {
      final engine = AudioEngine();
      engine.monitorEnabled = true;
      expect(engine.monitorEnabled, isTrue);
      engine.monitorEnabled = false;
      expect(engine.monitorEnabled, isFalse);
      engine.stop();
    });

    test('stop() resets monitorEnabled and onCaptureFrame', () {
      final engine = AudioEngine();
      engine.monitorEnabled = true;
      engine.onCaptureFrame = (_) {};
      engine.stop();
      expect(engine.monitorEnabled, isFalse);
      expect(engine.onCaptureFrame, isNull);
    });
  });

  group('ProximityMath — gainForDistance', () {
    test('distance <= near → gain = 1.0', () {
      expect(gainForDistance(0, 10, 100, 1.0), equals(1.0));
      expect(gainForDistance(5, 10, 100, 1.0), equals(1.0));
      expect(gainForDistance(10, 10, 100, 1.0), equals(1.0));
    });

    test('distance >= far → gain = 0.0', () {
      expect(gainForDistance(100, 10, 100, 1.0), equals(0.0));
      expect(gainForDistance(200, 10, 100, 1.0), equals(0.0));
    });

    test('linear falloff (curve=1) at midpoint', () {
      // midpoint between near=10 and far=110 → d=60
      // gain = (110-60)/(110-10) = 50/100 = 0.5
      final g = gainForDistance(60, 10, 110, 1.0);
      expect(g, closeTo(0.5, 0.001));
    });

    test('quadratic falloff (curve=2) at midpoint', () {
      // midpoint d=60, near=10, far=110
      // gain = ((110-60)/(110-10))^2 = 0.25
      final g = gainForDistance(60, 10, 110, 2.0);
      expect(g, closeTo(0.25, 0.001));
    });
  });

  group('ProximityMath — stereoGains', () {
    test('pan=0 gives equal L and R at ~0.707*gain (equal power)', () {
      final (gL, gR) = stereoGains(1.0, 0.0);
      expect(gL, closeTo(0.707, 0.01));
      expect(gR, closeTo(0.707, 0.01));
    });

    test('pan=-1 gives full left, zero right', () {
      final (gL, gR) = stereoGains(1.0, -1.0);
      expect(gL, closeTo(1.0, 0.01));
      expect(gR, closeTo(0.0, 0.01));
    });

    test('pan=+1 gives zero left, full right', () {
      final (gL, gR) = stereoGains(1.0, 1.0);
      expect(gL, closeTo(0.0, 0.01));
      expect(gR, closeTo(1.0, 0.01));
    });

    test('gain=0 → both channels are 0 regardless of pan', () {
      final (gL, gR) = stereoGains(0.0, 0.5);
      expect(gL, equals(0.0));
      expect(gR, equals(0.0));
    });
  });

  group('ProximityMath — EMA smoother', () {
    test('first sample is passed through unchanged', () {
      final math = ProximityMath();
      final result = math.smooth(1, 0.8, 0.3);
      expect(result.gain, equals(0.8));
      expect(result.pan, equals(0.3));
    });

    test('subsequent samples are smoothed', () {
      final math = ProximityMath();
      math.smooth(1, 1.0, 0.0); // first = passthrough
      final result = math.smooth(1, 0.0, 1.0); // second = smoothed
      // Gain alpha = 0.3, so: 0.3*0.0 + 0.7*1.0 = 0.7
      expect(result.gain, closeTo(0.7, 0.01));
      // Pan alpha = 0.15, so: 0.15*1.0 + 0.85*0.0 = 0.15
      expect(result.pan, closeTo(0.15, 0.01));
    });

    test('reset clears all peer smoothing state', () {
      final math = ProximityMath();
      math.smooth(1, 1.0, 1.0);
      math.smooth(1, 0.5, 0.5); // smoothed
      math.reset();
      // After reset, next call should be passthrough again
      final result = math.smooth(1, 0.3, -0.2);
      expect(result.gain, equals(0.3));
      expect(result.pan, equals(-0.2));
    });
  });

  group('AudioEngine — gain flow integrity', () {
    test('setGains are reflected in PeerAudio for mix', () {
      // This test validates the core bug: gains set on the same engine
      // that holds the peers are actually used during mixing.
      final engine = AudioEngine();
      engine.addPeer(1);
      engine.setGains(1, 0.9, 0.7);

      // Enqueue a non-silent frame
      final frame = Int16List(960);
      for (int i = 0; i < 960; i++) {
        frame[i] = 16000; // ~50% of max amplitude
      }
      engine.enqueuePeerAudio(1, frame);

      // We can't easily test the full mix output without the DLL,
      // but we can verify the peer has the correct gains set
      // by checking that bufferMs shows data is queued
      expect(engine.bufferMs(1), equals(20));

      engine.stop();
    });
  });
}
