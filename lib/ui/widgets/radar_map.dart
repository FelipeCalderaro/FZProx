import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/session/session_bloc.dart';
import '../../models/peer_model.dart';
import '../../models/proximity_params.dart';
import '../theme.dart';

/// Circular radar that plots all peers relative to self.
///
/// • Self is always at the centre, pointing up (north = forward).
/// • The view rotates with [selfYaw] so forward is always up.
/// • Near-radius ring is drawn as a dimly lit circle.
/// • Peer dots are colour-coded: green = in range, grey = silent/muted.
/// • Speed vector stub shows own heading as a short line from centre.
class RadarMap extends StatelessWidget {
  /// Physical size of the radar widget (it's always square).
  final double size;

  const RadarMap({super.key, this.size = 220});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state is! SessionActive) {
          return _shell(size, const _RadarPainter.empty());
        }
        return _shell(
          size,
          _RadarPainter(
            peers:      state.peers,
            selfX:      state.selfX,
            selfZ:      state.selfZ,
            selfYaw:    state.selfYaw,
            selfSpeed:  state.selfSpeed,
            proximity:  state.proximity,
            telemetryOn: state.telemetryActive,
          ),
        );
      },
    );
  }

  Widget _shell(double size, _RadarPainter painter) {
    return Container(
      width:  size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kColorCard,
        border: Border.all(color: kColorBorder, width: 1.5),
      ),
      child: ClipOval(
        child: CustomPaint(
          painter: painter,
          size: Size(size, size),
        ),
      ),
    );
  }
}

// ── Painter ───────────────────────────────────────────────────────────────────

class _RadarPainter extends CustomPainter {
  final Map<int, PeerModel> peers;
  final double selfX;
  final double selfZ;
  final double selfYaw;
  final double selfSpeed;
  final ProximityParams proximity;
  final bool telemetryOn;

  const _RadarPainter({
    required this.peers,
    required this.selfX,
    required this.selfZ,
    required this.selfYaw,
    required this.selfSpeed,
    required this.proximity,
    required this.telemetryOn,
  });

  const _RadarPainter.empty()
      : peers       = const {},
        selfX       = 0,
        selfZ       = 0,
        selfYaw     = 0,
        selfSpeed   = 0,
        proximity   = const ProximityParams(),
        telemetryOn = false;

  // World-unit radius shown on the radar; auto-scales to far distance.
  double get _worldRadius => proximity.far * 1.1;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width  / 2;
    final cy = size.height / 2;
    final r  = min(cx, cy);

    // ── Background grid ───────────────────────────────────────────────────
    _drawGrid(canvas, cx, cy, r);

    // ── Near & far range rings ────────────────────────────────────────────
    _drawRing(canvas, cx, cy, r, proximity.near  / _worldRadius,
        kColorSuccess.withAlpha(30), kColorSuccess.withAlpha(60));
    _drawRing(canvas, cx, cy, r, proximity.far   / _worldRadius,
        Colors.transparent, kColorBorder.withAlpha(120));

    // ── Cardinal labels ───────────────────────────────────────────────────
    if (telemetryOn) _drawCardinals(canvas, cx, cy, r);

    // ── Self heading stub ─────────────────────────────────────────────────
    _drawSelf(canvas, cx, cy, r);

    // ── Peers ─────────────────────────────────────────────────────────────
    for (final peer in peers.values) {
      _drawPeer(canvas, cx, cy, r, peer);
    }

    // ── No-telemetry overlay ─────────────────────────────────────────────
    if (!telemetryOn) _drawNoTelemetry(canvas, cx, cy, r);
  }

  void _drawGrid(Canvas canvas, double cx, double cy, double r) {
    final paint = Paint()
      ..color       = kColorBorder.withAlpha(40)
      ..style       = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Cross hairs
    canvas.drawLine(Offset(cx, cy - r), Offset(cx, cy + r), paint);
    canvas.drawLine(Offset(cx - r, cy), Offset(cx + r, cy), paint);

    // Mid ring
    canvas.drawCircle(Offset(cx, cy), r * 0.5, paint);
  }

  void _drawRing(Canvas canvas, double cx, double cy, double r,
      double fraction, Color fill, Color stroke) {
    final rr = r * fraction.clamp(0.0, 1.0);
    if (rr < 1) return;
    final fillPaint = Paint()..color = fill..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color       = stroke
      ..style       = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(Offset(cx, cy), rr, fillPaint);
    canvas.drawCircle(Offset(cx, cy), rr, strokePaint);
  }

  void _drawCardinals(Canvas canvas, double cx, double cy, double r) {
    final style = TextStyle(
      color:    kColorTextMuted.withAlpha(140),
      fontSize: 9,
      fontWeight: FontWeight.w600,
    );
    final labels = ['F', 'R', 'B', 'L'];
    final angles = [0.0, pi / 2, pi, -pi / 2]; // forward/right/back/left
    for (var i = 0; i < 4; i++) {
      final a  = angles[i];
      final dx = sin(a);
      final dz = -cos(a);
      final px = cx + dx * (r - 10);
      final py = cy + dz * (r - 10);
      final tp = TextPainter(
        text:            TextSpan(text: labels[i], style: style),
        textDirection:   TextDirection.ltr,
        textAlign:       TextAlign.center,
      )..layout();
      tp.paint(canvas, Offset(px - tp.width / 2, py - tp.height / 2));
    }
  }

  void _drawSelf(Canvas canvas, double cx, double cy, double r) {
    // Orange dot at centre
    final dotPaint = Paint()
      ..color = kColorPrimary
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), 5, dotPaint);

    // Heading line (length scales with speed, min 10 px)
    final lineLen  = (selfSpeed / _worldRadius * r * 3).clamp(10.0, r * 0.35);
    const headingOffset = 0.0; // self heading is always "up" (we rotate world)
    final ex = cx + sin(headingOffset) * lineLen;
    final ey = cy - cos(headingOffset) * lineLen;
    canvas.drawLine(
      Offset(cx, cy),
      Offset(ex, ey),
      Paint()
        ..color       = kColorPrimary.withAlpha(180)
        ..strokeWidth = 2
        ..strokeCap   = StrokeCap.round,
    );
  }

  void _drawPeer(Canvas canvas, double cx, double cy, double r, PeerModel peer) {
    // World-space delta, then rotate by -selfYaw so self always faces up
    final dx =  peer.x - selfX;
    final dz =  peer.z - selfZ;

    final cosY =  cos(-selfYaw);
    final sinY =  sin(-selfYaw);
    final rx   =  dx * cosY - dz * sinY;
    final rz   =  dx * sinY + dz * cosY;

    // Map to screen: Z is depth (forward = up = -Y in screen space)
    final screenX = cx + (rx / _worldRadius) * r;
    final screenY = cy - (rz / _worldRadius) * r;

    // Clamp to circle edge with a small blip
    final dist    = sqrt(pow(screenX - cx, 2) + pow(screenY - cy, 2));
    final clamped = dist > r - 6
        ? Offset(
            cx + (screenX - cx) / dist * (r - 6),
            cy + (screenY - cy) / dist * (r - 6),
          )
        : Offset(screenX, screenY);

    final inRange  = peer.rawGain > 0.01 && !peer.muted;
    final dotColor = peer.muted
        ? kColorError.withAlpha(160)
        : inRange
            ? Color.lerp(kColorSecondary, kColorSuccess, peer.rawGain)!
            : kColorTextMuted.withAlpha(120);

    // Outer glow when in range
    if (inRange) {
      canvas.drawCircle(
        clamped,
        9,
        Paint()
          ..color       = dotColor.withAlpha(40)
          ..style       = PaintingStyle.fill,
      );
    }

    // Dot
    canvas.drawCircle(
      clamped,
      5,
      Paint()..color = dotColor..style = PaintingStyle.fill,
    );

    // Name label
    final style = TextStyle(
      color:    inRange ? kColorText : kColorTextMuted.withAlpha(160),
      fontSize: 9,
      fontWeight: FontWeight.w600,
    );
    final label = peer.name.length > 8 ? '${peer.name.substring(0, 7)}…' : peer.name;
    final tp = TextPainter(
      text:          TextSpan(text: label, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, clamped.translate(7, -tp.height / 2));
  }

  void _drawNoTelemetry(Canvas canvas, double cx, double cy, double r) {
    final tp = TextPainter(
      text: TextSpan(
        text:  'No Telemetry',
        style: TextStyle(
          color:      kColorTextMuted.withAlpha(140),
          fontSize:   11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, cy + 18));
  }

  @override
  bool shouldRepaint(_RadarPainter old) =>
      old.selfX     != selfX     ||
      old.selfZ     != selfZ     ||
      old.selfYaw   != selfYaw   ||
      old.selfSpeed != selfSpeed ||
      old.peers     != peers     ||
      old.telemetryOn != telemetryOn;
}
