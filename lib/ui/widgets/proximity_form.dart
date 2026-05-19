import 'package:flutter/material.dart';

import '../../models/proximity_params.dart';
import '../theme.dart';

/// Editable proximity parameters card — used in both setup and session screens.
class ProximityForm extends StatefulWidget {
  final ProximityParams initial;
  final ValueChanged<ProximityParams> onChanged;

  const ProximityForm({
    super.key,
    required this.initial,
    required this.onChanged,
  });

  @override
  State<ProximityForm> createState() => _ProximityFormState();
}

class _ProximityFormState extends State<ProximityForm> {
  late double _near;
  late double _far;
  late double _curve;
  late bool   _panning;

  @override
  void initState() {
    super.initState();
    _near    = widget.initial.near;
    _far     = widget.initial.far;
    _curve   = widget.initial.curve;
    _panning = widget.initial.panning;
  }

  void _emit() => widget.onChanged(ProximityParams(
      near: _near, far: _far, curve: _curve, panning: _panning));

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SliderRow(
          label:   'Near radius',
          unit:    'm',
          value:   _near,
          min:     1,
          max:     50,
          onChanged: (v) { setState(() => _near = v.roundToDouble()); _emit(); },
        ),
        const SizedBox(height: 12),
        _SliderRow(
          label:   'Far radius',
          unit:    'm',
          value:   _far,
          min:     20,
          max:     500,
          onChanged: (v) { setState(() => _far = v.roundToDouble()); _emit(); },
        ),
        const SizedBox(height: 12),
        _SliderRow(
          label:   'Curve (exponent)',
          value:   _curve,
          min:     0.5,
          max:     4.0,
          divisions: 7,
          onChanged: (v) { setState(() => _curve = v); _emit(); },
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Stereo panning', style: tt.bodyLarge),
            Switch(
              value:     _panning,
              onChanged: (v) { setState(() => _panning = v); _emit(); },
            ),
          ],
        ),
      ],
    );
  }
}

class _SliderRow extends StatelessWidget {
  final String label;
  final String unit;
  final double value;
  final double min;
  final double max;
  final int?   divisions;
  final ValueChanged<double> onChanged;

  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.unit      = '',
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: tt.bodyMedium),
            Text(
              '${value.toStringAsFixed(value == value.roundToDouble() ? 0 : 1)}$unit',
              style: tt.labelLarge?.copyWith(color: kColorPrimary),
            ),
          ],
        ),
        Slider(
          value:     value,
          min:       min,
          max:       max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
