import 'dart:typed_data';

import '../audio/audio_engine.dart';
import '../blocs/session/session_bloc.dart';

/// Unique fake peer-id used for the local test virtual peer.
const int kTestPeerId = 9999;

/// Injects a stationary virtual peer at a user-chosen (X, Z) position so
/// that the full proximity pipeline (distance attenuation, panning, Doppler)
/// can be validated without a second real player.
///
/// **Audio delivery:**  Instead of competing with the sender loop via
/// [AudioEngine.popCapture], the controller registers an [AudioEngine.onCaptureFrame]
/// tap that fires with a copy of each captured frame immediately after the
/// sender loop pops it.  Those copies are enqueued into the test peer's
/// buffer — so the peer's audio is always in sync with what is sent to the
/// network, with zero race conditions.
class LocalTestController {
  final SessionBloc  _sessionBloc;
  final AudioEngine  _audio;

  bool _running = false;

  double _x = 0;
  double _z = 0;

  bool get isRunning => _running;

  LocalTestController({
    required SessionBloc  sessionBloc,
    required AudioEngine  audio,
  })  : _sessionBloc = sessionBloc,
        _audio       = audio;

  /// Starts the virtual peer at [x], [z].
  void start(double x, double z) {
    if (_running) stop();

    _x = x;
    _z = z;
    _running = true;

    // Register peer in both SessionBloc and AudioEngine
    _audio.addPeer(kTestPeerId);
    _sessionBloc.add(const SessionEvent.peerAdded(
      id:   kTestPeerId,
      name: '[TEST]',
    ));

    // Send initial position immediately so the gain loop starts right away
    _sessionBloc.add(SessionEvent.peerPositionUpdated(
      id: kTestPeerId, x: _x, z: _z, yaw: 0, speed: 0,
    ));

    // Tap into the capture stream: every frame the sender pops also feeds
    // the test peer's buffer (no racing, no duplicate pop).
    _audio.onCaptureFrame = _onFrame;
  }

  void _onFrame(Int16List frame) {
    if (!_running) return;
    // Update position each time we receive audio so the gain loop always
    // has fresh coordinates without needing a separate position timer.
    _sessionBloc.add(SessionEvent.peerPositionUpdated(
      id: kTestPeerId, x: _x, z: _z, yaw: 0, speed: 0,
    ));
    _audio.enqueuePeerAudio(kTestPeerId, Int16List.fromList(frame));
  }

  /// Updates the virtual peer's position in real-time.
  void updatePosition(double x, double z) {
    _x = x;
    _z = z;
    if (_running) {
      _sessionBloc.add(SessionEvent.peerPositionUpdated(
        id: kTestPeerId, x: _x, z: _z, yaw: 0, speed: 0,
      ));
    }
  }

  /// Tears down the virtual peer.
  void stop() {
    if (!_running) return;
    _running = false;

    _audio.onCaptureFrame = null;
    _sessionBloc.add(const SessionEvent.peerRemoved(id: kTestPeerId));
    _audio.removePeer(kTestPeerId);
  }

  void dispose() => stop();
}
