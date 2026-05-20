import 'package:flutter/material.dart';

import '../../models/peer_model.dart';
import '../theme.dart';
import 'volume_bar.dart';

/// Live peer table: Player | Dist | Volume | Pan | Doppler | Buf | Mute
/// Sorted nearest-first.
class PeerTable extends StatelessWidget {
  final Map<int, PeerModel> peers;
  final void Function(int peerId)?               onMuteToggle;
  final void Function(int peerId, double value)? onVolumeChanged;

  const PeerTable({
    super.key,
    required this.peers,
    this.onMuteToggle,
    this.onVolumeChanged,
  });

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
        ...sorted.map((p) => _PeerRow(
              peer:           p,
              onMuteToggle:   onMuteToggle,
              onVolumeChanged: onVolumeChanged,
            )),
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
          SizedBox(width: 64,  child: Text('Dist',    style: style, textAlign: TextAlign.right)),
          SizedBox(width: 108, child: Text('Volume',  style: style, textAlign: TextAlign.center)),
          SizedBox(width: 72,  child: Text('Pan',     style: style, textAlign: TextAlign.center)),
          SizedBox(width: 72,  child: Text('Doppler', style: style, textAlign: TextAlign.center)),
          SizedBox(width: 56,  child: Text('Buf',     style: style, textAlign: TextAlign.right)),
          const SizedBox(width: 40), // Mute column — no header text
        ],
      ),
    );
  }
}

class _PeerRow extends StatelessWidget {
  final PeerModel peer;
  final void Function(int peerId)?               onMuteToggle;
  final void Function(int peerId, double value)? onVolumeChanged;

  const _PeerRow({
    required this.peer,
    this.onMuteToggle,
    this.onVolumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tt   = Theme.of(context).textTheme;
    // rawGain is the proximity gain before the stereo/equal-power split,
    // so it correctly reads 1.0 (100%) when inside the near radius.
    final gain = peer.rawGain.clamp(0.0, 1.0);
    final mono = '${(gain * 100).toStringAsFixed(0)}%'.padLeft(4);

    final vm = peer.volumeMultiplier;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: peer.muted ? kColorCard.withAlpha(180) : null,
        border: Border(bottom: BorderSide(color: kColorBorder.withAlpha(80))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Main data row ──────────────────────────────────────────────
          Row(
        children: [
          // Player name
          Expanded(
            flex: 3,
            child: Row(children: [
              _StatusDot(active: peer.distanceM > 0 && !peer.muted),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  peer.name.length > 18
                      ? '${peer.name.substring(0, 17)}…'
                      : peer.name,
                  style: tt.bodyLarge?.copyWith(
                    color: peer.muted ? kColorTextMuted : null,
                  ),
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
                  ?.copyWith(fontFamily: 'monospace', color: peer.muted ? kColorTextMuted : kColorText),
              textAlign: TextAlign.right,
            ),
          ),
          // Volume bar + %
          SizedBox(
            width: 108,
            child: peer.muted
                ? Center(
                    child: Text('MUTED',
                        style: tt.labelSmall?.copyWith(
                          color: kColorError,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        )),
                  )
                : Row(
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
            child: Center(
              child: peer.muted
                  ? const SizedBox.shrink()
                  : PanIndicator(pan: peer.pan),
            ),
          ),
          // Doppler
          SizedBox(
            width: 72,
            child: peer.muted
                ? const SizedBox.shrink()
                : Text(
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
              peer.muted ? '—' : '${peer.bufferMs} ms',
              style: tt.bodyMedium
                  ?.copyWith(fontFamily: 'monospace', color: kColorTextMuted),
              textAlign: TextAlign.right,
            ),
          ),
          // Mute button
          SizedBox(
            width: 40,
            child: IconButton(
              iconSize:   18,
              splashRadius: 16,
              padding:    EdgeInsets.zero,
              tooltip:    peer.muted ? 'Unmute ${peer.name}' : 'Mute ${peer.name}',
              icon: Icon(
                peer.muted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                color: peer.muted ? kColorError : kColorTextMuted,
              ),
              onPressed: onMuteToggle != null
                  ? () => onMuteToggle!(peer.id)
                  : null,
            ),
          ),
        ],
      ),

      // ── Per-peer volume slider ─────────────────────────────────────────
      if (onVolumeChanged != null)
        Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 4),
          child: Row(children: [
            Icon(
              vm < 0.05
                  ? Icons.volume_off_outlined
                  : vm > 1.05
                      ? Icons.volume_up_rounded
                      : Icons.volume_down_rounded,
              size:  14,
              color: vm > 1.05 ? kColorPrimary : kColorTextMuted,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: SliderTheme(
                data: const SliderThemeData(
                  trackHeight:  2,
                  thumbShape:   RoundSliderThumbShape(enabledThumbRadius: 5),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
                  inactiveTrackColor: kColorBorder,
                  overlayColor: Color(0x19FF6B00),
                ).copyWith(
                  activeTrackColor: vm > 1.05 ? kColorPrimary : kColorSecondary,
                  thumbColor:       vm > 1.05 ? kColorPrimary : kColorSecondary,
                ),
                child: Slider(
                  value:     vm.clamp(0.0, 2.0),
                  min:       0.0,
                  max:       2.0,
                  divisions: 40,
                  onChanged: (v) => onVolumeChanged!(peer.id, v),
                ),
              ),
            ),
            SizedBox(
              width: 38,
              child: Text(
                '${(vm * 100).round()}%',
                style: tt.labelSmall?.copyWith(
                  fontFamily:  'monospace',
                  color: vm > 1.05 ? kColorPrimary : kColorTextMuted,
                  fontWeight:  vm > 1.05 ? FontWeight.w700 : FontWeight.normal,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ]),
        ),
        ],   // Column children
      ),     // Column
    );       // Container
  }

  Color _dopplerColor(double f) {
    if (f > 1.05) return kColorError;     // approaching fast
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
