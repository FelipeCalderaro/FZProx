import 'package:flutter/material.dart';
import '../theme.dart';

/// Compact ASCII-style horizontal volume bar.
/// [value] must be in [0.0, 1.0].
class VolumeBar extends StatelessWidget {
  final double value;
  final double width;
  final double height;

  const VolumeBar({
    super.key,
    required this.value,
    this.width  = 80,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: value.clamp(0.0, 1.0),
          backgroundColor:    kColorBorder,
          valueColor: AlwaysStoppedAnimation<Color>(_barColor(value)),
          minHeight: height,
        ),
      ),
    );
  }

  Color _barColor(double v) {
    if (v > 0.75) return kColorSuccess;
    if (v > 0.35) return kColorPrimary;
    return kColorSecondary;
  }
}

/// Pan indicator: a small dot that slides left/right on a track.
/// [pan] ∈ [-1, +1]
class PanIndicator extends StatelessWidget {
  final double pan;
  final double width;

  const PanIndicator({super.key, required this.pan, this.width = 60});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 14,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 2,
            decoration: BoxDecoration(
              color:        kColorBorder,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          Align(
            alignment: Alignment(pan.clamp(-1.0, 1.0), 0),
            child: Container(
              width: 8, height: 8,
              decoration: const BoxDecoration(
                color: kColorSecondary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
