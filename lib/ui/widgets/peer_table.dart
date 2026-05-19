import 'package:flutter/material.dart';

import '../../models/peer_model.dart';
import '../theme.dart';
import 'volume_bar.dart';

/// Live peer table: Player | Dist | Volume | Pan | Doppler | Buf
/// Sorted nearest-first.
class PeerTable extends StatelessWidget {
  final Map<int, PeerModel> peers;

  const PeerTable({super.key, required this.peers});

  @override
  Widget build(BuildContext context) {
    if (peers.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.people_outline, size: 48, color: kColorTextMuted),
            const SizedBox(height: 12),
            Text('No peers in room yet',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: kColorTextMuted)),
          ],
        ),
      );
    }

    final sorted = peers.values.toList()
      ..sort((a, b) => a.distanceM.compareTo(b.distanceM));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(),
        const Divider(height: 1),
        ...sorted.map((p) => _PeerRow(peer: p)),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .labelLarge
        ?.copyWith(color: kColorTextMuted);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('Player',  style: style)),
          SizedBox(width: 64, child: Text('Dist',    style: style, textAlign: TextAlign.right)),
          SizedBox(width: 108, child: Text('Volume', style: style, textAlign: TextAlign.center)),
          SizedBox(width: 72,  child: Text('Pan',    style: style, textAlign: TextAlign.center)),
          SizedBox(width: 72,  child: Text('Doppler',style: style, textAlign: TextAlign.center)),
          SizedBox(width: 56,  child: Text('Buf',    style: style, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}

class _PeerRow extends StatelessWidget {
  final PeerModel peer;
  const _PeerRow({required this.peer});

  @override
  Widget build(BuildContext context) {
    final tt    = Theme.of(context).textTheme;
    // rawGain is the proximity gain before the stereo/equal-power split,
    // so it correctly reads 1.0 (100%) when inside the near radius.
    final gain  = peer.rawGain.clamp(0.0, 1.0);
    final mono  = '${(gain * 100).toStringAsFixed(0)}%'.padLeft(4);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: kColorBorder.withAlpha(80))),
      ),
      child: Row(
        children: [
          // Player name
          Expanded(
            flex: 3,
            child: Row(children: [
              _StatusDot(active: peer.distanceM > 0),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  peer.name.length > 18
                      ? '${peer.name.substring(0, 17)}…'
                      : peer.name,
                  style: tt.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
          ),
          // Distance
          SizedBox(
            width: 64,
            child: Text(
              '${peer.distanceM.toStringAsFixed(1)} m',
              style: tt.bodyMedium
                  ?.copyWith(fontFamily: 'monospace', color: kColorText),
              textAlign: TextAlign.right,
            ),
          ),
          // Volume bar + %
          SizedBox(
            width: 108,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VolumeBar(value: gain, width: 60),
                const SizedBox(width: 6),
                Text(mono,
                    style: tt.bodyMedium?.copyWith(
                        fontFamily: 'monospace', color: kColorText),
                    textAlign: TextAlign.right),
              ],
            ),
          ),
          // Pan
          SizedBox(
            width: 72,
            child: Center(child: PanIndicator(pan: peer.pan)),
          ),
          // Doppler
          SizedBox(
            width: 72,
            child: Text(
              peer.dopplerFactor.toStringAsFixed(3),
              style: tt.bodyMedium?.copyWith(
                fontFamily: 'monospace',
                color: _dopplerColor(peer.dopplerFactor),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Buffer
          SizedBox(
            width: 56,
            child: Text(
              '${peer.bufferMs} ms',
              style: tt.bodyMedium
                  ?.copyWith(fontFamily: 'monospace', color: kColorTextMuted),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Color _dopplerColor(double f) {
    if (f > 1.05) return kColorError;    // approaching fast
    if (f < 0.95) return kColorSecondary; // receding fast
    return kColorTextMuted;
  }
}

class _StatusDot extends StatelessWidget {
  final bool active;
  const _StatusDot({required this.active});

  @override
  Widget build(BuildContext context) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? kColorSuccess : kColorTextMuted,
        ),
      );
}
