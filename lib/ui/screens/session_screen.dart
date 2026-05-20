import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../audio/audio_engine.dart';
import '../../blocs/connection/connection_bloc.dart';
import '../../blocs/session/session_bloc.dart';
import '../../client/local_test_controller.dart';
import '../../client/session_runner.dart';
import '../../models/audio_device_info.dart';
import '../../models/proximity_params.dart';
import '../../models/setup_config.dart';
import '../theme.dart';
import '../widgets/peer_table.dart';
import '../widgets/proximity_form.dart';

/// The live session screen — shows peer table, proximity controls,
/// telemetry status, and connection info.
class SessionScreen extends StatefulWidget {
  final SetupConfig config;

  const SessionScreen({super.key, required this.config});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  SessionRunner?        _runner;
  LocalTestController?  _testController;
  AudioEngine?          _audio;

  @override
  void initState() {
    super.initState();
    _startRunner();
  }

  void _startRunner() {
    final connBloc    = context.read<ConnectionBloc>();
    final sessionBloc = context.read<SessionBloc>();
    final client      = connBloc.client;
    if (client == null) return;

    // IMPORTANT: Use the same AudioEngine that SessionBloc owns.
    // SessionBloc.setGains() operates on this instance — if we created a
    // separate AudioEngine, the gain values would never reach the mix loop.
    final audio = sessionBloc.audioEngine;
    _audio = audio;

    final runner = SessionRunner(
      client:         client,
      audio:          audio,
      sessionBloc:    sessionBloc,
      connectionBloc: connBloc,
      config:         widget.config,
    );

    final connState = connBloc.state;
    if (connState is ConnectionInSession) {
      // 1. Emit started so SessionBloc transitions to active
      sessionBloc.add(SessionEvent.started(
        selfId:   connState.selfId,
        roomCode: connState.roomCode,
        username: connState.username,
      ));

      // 2. Replay peers that were already in the room when we joined (WELCOME list)
      for (final peer in connState.existingPeers) {
        audio.addPeer(peer.id);
        sessionBloc.add(SessionEvent.peerAdded(id: peer.id, name: peer.name));
      }
    }

    runner.start();
    _runner = runner;

    _testController = LocalTestController(
      sessionBloc: sessionBloc,
      audio:       audio,
    );
  }

  Future<void> _leave(BuildContext context) async {
    _testController?.stop();
    await _runner?.stop();
    if (context.mounted) {
      context.read<ConnectionBloc>().add(const ConnectionEvent.disconnect());
      Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
    }
  }

  @override
  void dispose() {
    _testController?.dispose();
    _runner?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionBloc, ConnectionState>(
      builder: (context, connState) {
        final sessionCode = connState is ConnectionInSession
            ? connState.roomCode
            : '----';
        final selfName = connState is ConnectionInSession
            ? connState.username
            : '';

        return Scaffold(
          backgroundColor: kColorBg,
          body: Column(children: [
            _SessionHeader(
              roomCode: sessionCode,
              username: selfName,
              onLeave:  () => _leave(context),
            ),
            Expanded(
              child: Row(children: [
                // Left sidebar: telemetry + proximity + local test
                SizedBox(
                  width: 340,
                  child: _LeftPanel(
                    runner:         _runner,
                    testController: _testController,
                    audio:          _audio,
                  ),
                ),
                const VerticalDivider(width: 1),
                // Right: peer table
                const Expanded(child: _PeerPanel()),
              ]),
            ),
          ]),
        );
      },
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _SessionHeader extends StatelessWidget {
  final String     roomCode;
  final String     username;
  final VoidCallback onLeave;

  const _SessionHeader({
    required this.roomCode,
    required this.username,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      height: 56,
      color:  kColorSurface,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        const Icon(Icons.spatial_audio_off_rounded,
            color: kColorPrimary, size: 22),
        const SizedBox(width: 10),
        Text('HorizonProx',
            style: tt.titleLarge?.copyWith(color: kColorPrimary)),
        const SizedBox(width: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color:        kColorCard,
            borderRadius: BorderRadius.circular(6),
            border:       Border.all(color: kColorBorder),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.tag, size: 14, color: kColorTextMuted),
            const SizedBox(width: 4),
            Text(roomCode,
                style: tt.titleMedium?.copyWith(
                    fontFamily: 'monospace', color: kColorText)),
          ]),
        ),
        const SizedBox(width: 12),
        Text(username, style: tt.bodyMedium?.copyWith(color: kColorTextMuted)),
        const Spacer(),
        TextButton.icon(
          icon:  const Icon(Icons.logout_outlined, size: 18),
          label: const Text('Leave'),
          onPressed: onLeave,
          style: TextButton.styleFrom(foregroundColor: kColorError),
        ),
      ]),
    );
  }
}

// ── Left panel ────────────────────────────────────────────────────────────────

class _LeftPanel extends StatelessWidget {
  final SessionRunner?         runner;
  final LocalTestController?   testController;
  final AudioEngine?           audio;

  const _LeftPanel({
    required this.runner,
    required this.testController,
    required this.audio,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        final active = state is SessionActive ? state : null;
        final telemetryOn = active?.telemetryActive ?? false;

        return Container(
          color: kColorSurface,
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            // Audio Settings (Realtime)
            if (runner != null && audio != null) ...[
              _AudioSettingsCard(runner: runner!, audio: audio!),
              const SizedBox(height: 16),
            ],

            // Telemetry status
            _InfoCard(
              title: 'Forza Telemetry',
              child: Row(children: [
                Container(
                  width: 10, height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: telemetryOn ? kColorSuccess : kColorTextMuted,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  telemetryOn ? 'Active' : 'No signal (not in race)',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: telemetryOn ? kColorSuccess : kColorTextMuted),
                ),
              ]),
            ),
            const SizedBox(height: 16),

            // Self position (when telemetry active)
            if (active != null && telemetryOn)
              _InfoCard(
                title: 'Position',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MonoRow('X',     active.selfX.toStringAsFixed(1)),
                    _MonoRow('Z',     active.selfZ.toStringAsFixed(1)),
                    _MonoRow('Yaw',   '${(active.selfYaw * 57.29).toStringAsFixed(1)}°'),
                    _MonoRow('Speed', '${active.selfSpeed.toStringAsFixed(1)} m/s'),
                  ],
                ),
              ),
            const SizedBox(height: 16),

            // Proximity controls
            _InfoCard(
              title: 'Proximity',
              child: ProximityForm(
                initial:   active?.proximity ?? runner?.config.proximity ?? const ProximityParams(),
                onChanged: (p) => context
                    .read<SessionBloc>()
                    .add(SessionEvent.proximityParamsChanged(params: p)),
              ),
            ),
            const SizedBox(height: 16),

            // Local test scenario
            if (testController != null && audio != null)
              _LocalTestCard(controller: testController!, audio: audio!),
          ]),
        );
      },
    );
  }
}

// ── Local Test Card ───────────────────────────────────────────────────────────

class _LocalTestCard extends StatefulWidget {
  final LocalTestController controller;
  final AudioEngine         audio;
  const _LocalTestCard({required this.controller, required this.audio});

  @override
  State<_LocalTestCard> createState() => _LocalTestCardState();
}

class _LocalTestCardState extends State<_LocalTestCard> {
  final _xCtrl = TextEditingController(text: '0');
  final _zCtrl = TextEditingController(text: '100');
  bool _running = false;
  bool _monitor = false;

  @override
  void dispose() {
    _xCtrl.dispose();
    _zCtrl.dispose();
    super.dispose();
  }

  double get _parsedX => double.tryParse(_xCtrl.text) ?? 0;
  double get _parsedZ => double.tryParse(_zCtrl.text) ?? 0;

  void _toggle() {
    if (_running) {
      widget.controller.stop();
      setState(() => _running = false);
    } else {
      widget.controller.start(_parsedX, _parsedZ);
      setState(() => _running = true);
    }
  }

  void _setMonitor(bool value) {
    setState(() => _monitor = value);
    widget.audio.monitorEnabled = value;
  }

  void _onCoordChanged() {
    if (_running) {
      widget.controller.updatePosition(_parsedX, _parsedZ);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color:        kColorCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _running
              ? kColorPrimary.withAlpha(180)
              : kColorBorder,
          width: _running ? 1.5 : 1,
        ),
      ),
      child: Theme(
        // suppress ExpansionTile dividers
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          leading: Icon(
            Icons.science_outlined,
            size: 18,
            color: _running ? kColorPrimary : kColorTextMuted,
          ),
          title: Text(
            'Local Test',
            style: tt.labelLarge?.copyWith(
              color:       _running ? kColorPrimary : kColorTextMuted,
              letterSpacing: 1.1,
              fontSize:    11,
            ),
          ),
          trailing: _running
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color:        kColorPrimary.withAlpha(30),
                    borderRadius: BorderRadius.circular(20),
                    border:       Border.all(color: kColorPrimary.withAlpha(120)),
                  ),
                  child: Text('ACTIVE',
                      style: tt.labelSmall?.copyWith(
                          color: kColorPrimary, fontWeight: FontWeight.w700)),
                )
              : null,
          children: [
            const SizedBox(height: 4),
            Text(
              'Simulate a peer at a fixed world position.\n'
              'Your capture audio is looped back to it.',
              style: tt.bodySmall?.copyWith(color: kColorTextMuted),
            ),
            const SizedBox(height: 12),

            // Coordinates — always editable (update live when test is running)
            Row(children: [
              Expanded(
                child: _CoordField(
                  label:      'X',
                  controller: _xCtrl,
                  onChanged:  _onCoordChanged,
                  enabled:    true,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CoordField(
                  label:      'Z',
                  controller: _zCtrl,
                  onChanged:  _onCoordChanged,
                  enabled:    true,
                ),
              ),
            ]),
            const SizedBox(height: 12),

            // Monitor toggle — hear your own capture immediately
            InkWell(
              onTap: () => _setMonitor(!_monitor),
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value:         _monitor,
                      onChanged:     (v) => _setMonitor(v ?? false),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor:   kColorPrimary,
                      side: BorderSide(
                        color: _monitor ? kColorPrimary : kColorTextMuted,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Monitor Input',
                            style: tt.bodySmall?.copyWith(
                              color: _monitor ? kColorText : kColorTextMuted,
                              fontWeight: FontWeight.w600,
                            )),
                        Text('Hear your capture source directly',
                            style: tt.bodySmall?.copyWith(
                              color: kColorTextMuted,
                              fontSize: 10,
                            )),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 10),

            // Start / Stop button
            SizedBox(
              width: double.infinity,
              child: _running
                  ? OutlinedButton.icon(
                      icon:     const Icon(Icons.stop_circle_outlined, size: 16),
                      label:    const Text('Stop Test'),
                      onPressed: _toggle,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kColorError,
                        side: const BorderSide(color: kColorError),
                      ),
                    )
                  : FilledButton.icon(
                      icon:     const Icon(Icons.play_arrow_rounded, size: 16),
                      label:    const Text('Start Test'),
                      onPressed: _toggle,
                      style: FilledButton.styleFrom(
                        backgroundColor: kColorPrimary,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoordField extends StatelessWidget {
  final String                label;
  final TextEditingController controller;
  final VoidCallback          onChanged;
  final bool                  enabled;

  const _CoordField({
    required this.label,
    required this.controller,
    required this.onChanged,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return TextField(
      controller:  controller,
      enabled:     enabled,
      onChanged:   (_) => onChanged(),
      keyboardType: const TextInputType.numberWithOptions(
          signed: true, decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
      ],
      style: tt.bodyMedium?.copyWith(fontFamily: 'monospace'),
      decoration: InputDecoration(
        labelText:    label,
        labelStyle:   tt.labelSmall?.copyWith(color: kColorTextMuted),
        isDense:      true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        filled:       true,
        fillColor:    kColorBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide:   const BorderSide(color: kColorBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide:   const BorderSide(color: kColorBorder),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: kColorBorder.withAlpha(80)),
        ),
      ),
    );
  }
}

// ── Shared small widgets ───────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _InfoCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(),
          style: tt.labelLarge?.copyWith(
              color: kColorTextMuted, letterSpacing: 1.1, fontSize: 11)),
      const SizedBox(height: 10),
      child,
    ]);
  }
}

class _MonoRow extends StatelessWidget {
  final String label;
  final String value;
  const _MonoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: tt.bodyMedium?.copyWith(color: kColorTextMuted)),
          Text(value,
              style: tt.bodyMedium?.copyWith(
                  fontFamily: 'monospace', color: kColorText)),
        ],
      ),
    );
  }
}

// ── Right panel: peer table ───────────────────────────────────────────────────

class _PeerPanel extends StatelessWidget {
  const _PeerPanel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        final peers =
            state is SessionActive ? state.peers : const <int, dynamic>{};

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sub-header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: kColorSurface,
              child: Row(children: [
                const Icon(Icons.people_outline,
                    color: kColorTextMuted, size: 18),
                const SizedBox(width: 8),
                Text('Peers — ${peers.length} in room',
                    style: Theme.of(context).textTheme.titleMedium),
              ]),
            ),
            const Divider(height: 1),
            Expanded(
              child: state is SessionActive
                  ? PeerTable(
                      peers: state.peers,
                      onMuteToggle: (id) => context
                          .read<SessionBloc>()
                          .add(SessionEvent.peerMuteToggled(id: id)),
                    )
                  : const Center(
                      child: CircularProgressIndicator(color: kColorPrimary)),
            ),
          ],
        );
      },
    );
  }
}

// ── Audio Settings Card (Realtime) ──────────────────────────────────────────

class _AudioSettingsCard extends StatefulWidget {
  final SessionRunner runner;
  final AudioEngine   audio;

  const _AudioSettingsCard({required this.runner, required this.audio});

  @override
  State<_AudioSettingsCard> createState() => _AudioSettingsCardState();
}

class _AudioSettingsCardState extends State<_AudioSettingsCard> {
  List<AudioDeviceInfo> _inputDevices = [];
  List<AudioDeviceInfo> _outputDevices = [];
  List<AudioSessionInfo> _sessions = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchDevices();
  }

  Future<void> _fetchDevices() async {
    setState(() => _loading = true);
    final inDevs  = await widget.audio.listInputDevices();
    final outDevs = await widget.audio.listOutputDevices();
    final sess    = await widget.audio.listAudioSessions();
    if (mounted) {
      setState(() {
        _inputDevices  = inDevs;
        _outputDevices = outDevs;
        _sessions      = sess;
        _loading       = false;
      });
    }
  }

  void _onInputModeChanged(AudioInputMode? mode) {
    if (mode == null) return;
    // When switching modes, fallback to default device
    widget.runner.changeInput(mode);
    setState(() {});
  }

  void _onInputDeviceChanged(dynamic selection) {
    if (selection == null) return;
    final mode = widget.runner.config.inputMode;
    if (mode == AudioInputMode.processCapture) {
      widget.runner.changeInput(mode, session: selection as AudioSessionInfo);
    } else {
      widget.runner.changeInput(mode, device: selection as AudioDeviceInfo);
    }
    setState(() {});
  }

  void _onOutputDeviceChanged(AudioDeviceInfo? device) {
    // device can be null (System Default)
    widget.runner.changeOutput(device);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cfg = widget.runner.config;
    final tt  = Theme.of(context).textTheme;

    return _InfoCard(
      title: 'Audio Settings',
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (_loading)
          const Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: LinearProgressIndicator(minHeight: 2),
          ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Audio Source', style: tt.labelMedium?.copyWith(color: kColorTextMuted)),
            InkWell(
              onTap: _fetchDevices,
              child: const Icon(Icons.refresh, size: 16, color: kColorTextMuted),
            )
          ],
        ),
        const SizedBox(height: 4),

        // Input Mode Selector
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: kColorBg,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: kColorBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AudioInputMode>(
              value: [AudioInputMode.mic, AudioInputMode.loopback, AudioInputMode.processCapture].contains(cfg.inputMode) ? cfg.inputMode : AudioInputMode.mic,
              isExpanded: true,
              dropdownColor: kColorSurface,
              icon: const Icon(Icons.arrow_drop_down, color: kColorTextMuted),
              items: const [
                DropdownMenuItem(value: AudioInputMode.mic, child: Text('Microphone')),
                DropdownMenuItem(value: AudioInputMode.loopback, child: Text('System Loopback')),
                DropdownMenuItem(value: AudioInputMode.processCapture, child: Text('App Capture')),
              ],
              onChanged: _onInputModeChanged,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Input Device/Session Selector
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: kColorBg,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: kColorBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: _buildInputDeviceDropdown(cfg),
          ),
        ),
        const SizedBox(height: 8),

        // Input VU Meter
        Row(
          children: [
            const Icon(Icons.mic, size: 16, color: kColorTextMuted),
            const SizedBox(width: 8),
            Expanded(
              child: ValueListenableBuilder<double>(
                valueListenable: widget.audio.captureRms,
                builder: (context, rms, _) => _VuMeter(rms: rms),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        Text('Audio Output', style: tt.labelMedium?.copyWith(color: kColorTextMuted)),
        const SizedBox(height: 4),

        // Output Device Selector
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: kColorBg,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: kColorBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: (() {
              final items = <AudioDeviceInfo?>[null, ..._outputDevices];
              if (cfg.outputDevice != null && !items.contains(cfg.outputDevice)) {
                items.add(cfg.outputDevice);
              }
              return DropdownButton<AudioDeviceInfo?>(
                value: cfg.outputDevice,
                isExpanded: true,
                dropdownColor: kColorSurface,
                icon: const Icon(Icons.arrow_drop_down, color: kColorTextMuted),
                items: items.map((d) => DropdownMenuItem(
                  value: d,
                  child: Text(d == null ? 'System Default' : d.name, overflow: TextOverflow.ellipsis),
                )).toList(),
                onChanged: _onOutputDeviceChanged,
              );
            })(),
          ),
        ),
        const SizedBox(height: 8),

        // Output VU Meter
        Row(
          children: [
            const Icon(Icons.speaker, size: 16, color: kColorTextMuted),
            const SizedBox(width: 8),
            Expanded(
              child: ValueListenableBuilder<double>(
                valueListenable: widget.audio.playbackRms,
                builder: (context, rms, _) => _VuMeter(rms: rms),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildInputDeviceDropdown(SetupConfig cfg) {
    if (cfg.inputMode == AudioInputMode.processCapture) {
      final items = _sessions.toList();
      if (cfg.audioSession != null && !items.contains(cfg.audioSession)) {
        items.add(cfg.audioSession!);
      }
      
      if (items.isEmpty) {
        return const DropdownMenuItem(value: null, child: Text('No active apps found'));
      }
      
      return DropdownButton<AudioSessionInfo?>(
        value: cfg.audioSession,
        isExpanded: true,
        dropdownColor: kColorSurface,
        icon: const Icon(Icons.arrow_drop_down, color: kColorTextMuted),
        items: items.map((s) => DropdownMenuItem<AudioSessionInfo?>(
          value: s,
          child: Text(s.displayName, overflow: TextOverflow.ellipsis),
        )).toList(),
        onChanged: _onInputDeviceChanged,
      );
    } else {
      final devices = cfg.inputMode == AudioInputMode.loopback ? _outputDevices : _inputDevices;
      final items = devices.toList();
      if (cfg.inputDevice != null && !items.contains(cfg.inputDevice)) {
        items.add(cfg.inputDevice!);
      }

      if (items.isEmpty) {
        return const DropdownMenuItem(value: null, child: Text('No devices found'));
      }

      return DropdownButton<AudioDeviceInfo?>(
        value: cfg.inputDevice,
        isExpanded: true,
        dropdownColor: kColorSurface,
        icon: const Icon(Icons.arrow_drop_down, color: kColorTextMuted),
        items: items.map((d) => DropdownMenuItem<AudioDeviceInfo?>(
          value: d,
          child: Text(d.name, overflow: TextOverflow.ellipsis),
        )).toList(),
        onChanged: _onInputDeviceChanged,
      );
    }
  }
}

// ── VU Meter ──────────────────────────────────────────────────────────────

class _VuMeter extends StatelessWidget {
  final double rms;
  const _VuMeter({required this.rms});

  @override
  Widget build(BuildContext context) {
    // RMS is typically between 0 and 1, but we boost it visually so normal speech looks good
    final displayRms = (rms * 3.0).clamp(0.0, 1.0);

    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: kColorBg,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: kColorBorder),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: displayRms,
        child: Container(
          decoration: BoxDecoration(
            color: _getColor(displayRms),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Color _getColor(double v) {
    if (v < 0.5) return kColorPrimary;
    if (v < 0.85) return const Color(0xFFFACC15); // Yellow
    return kColorError; // Red
  }
}
