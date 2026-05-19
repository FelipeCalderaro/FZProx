import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/setup/setup_bloc.dart';
import '../../models/audio_device_info.dart';
import '../../models/proximity_params.dart';
import '../../protocol/protocol.dart';
import '../theme.dart';
import '../widgets/proximity_form.dart';

/// 4-step setup wizard: Identity → Audio In → Audio Out → Proximity.
class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SetupBloc, SetupState>(
      listener: (context, state) {
        if (state is SetupCompleteState) {
          Navigator.of(context).pushReplacementNamed('/room');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kColorBg,
            elevation:       0,
            leading: state is SetupIdentityState
                ? const BackButton()
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () =>
                        context.read<SetupBloc>().add(const SetupEvent.backPressed()),
                  ),
            title: Text(_stepTitle(state)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4),
              child: _StepProgress(state: state),
            ),
          ),
          body: switch (state) {
            SetupInitial()        => const _LoadingView(message: 'Initialising…'),
            SetupLoadingDevices() => const _LoadingView(message: 'Enumerating audio devices…'),
            SetupIdentityState()  => _IdentityStep(state: state),
            SetupAudioInputState()=> _AudioInputStep(state: state),
            SetupAudioOutputState()=> _AudioOutputStep(state: state),
            SetupProximityState() => _ProximityStep(state: state),
            SetupCompleteState()  => const _LoadingView(message: 'Connecting…'),
            SetupErrorState()     => _ErrorView(state: state),
            _                    => const _LoadingView(message: '…'),
          },
        );
      },
    );
  }

  String _stepTitle(SetupState state) => switch (state) {
    SetupIdentityState()   => 'Step 1 — Identity',
    SetupAudioInputState() => 'Step 2 — Audio Input',
    SetupAudioOutputState()=> 'Step 3 — Audio Output',
    SetupProximityState()  => 'Step 4 — Proximity',
    _                      => 'Setup',
  };
}

// ── Step progress bar ────────────────────────────────────────────────────────

class _StepProgress extends StatelessWidget {
  final SetupState state;
  const _StepProgress({required this.state});

  double get _fraction => switch (state) {
    SetupIdentityState()    => 0.25,
    SetupAudioInputState()  => 0.50,
    SetupAudioOutputState() => 0.75,
    SetupProximityState()   => 1.00,
    _                       => 0.0,
  };

  @override
  Widget build(BuildContext context) => LinearProgressIndicator(
        value:           _fraction,
        backgroundColor: kColorBorder,
        valueColor: const AlwaysStoppedAnimation<Color>(kColorPrimary),
        minHeight: 4,
      );
}

// ── Shared helpers ───────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  final String message;
  const _LoadingView({required this.message});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircularProgressIndicator(color: kColorPrimary),
          const SizedBox(height: 20),
          Text(message,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: kColorTextMuted)),
        ]),
      );
}

class _ErrorView extends StatelessWidget {
  final SetupErrorState state;
  const _ErrorView({required this.state});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.error_outline, color: kColorError, size: 48),
          const SizedBox(height: 16),
          Text(state.message,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: kColorError),
              textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () =>
                context.read<SetupBloc>().add(const SetupEvent.started()),
            child: const Text('Retry'),
          ),
        ]),
      );
}

Widget _stepBody(Widget child) => SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: child,
        ),
      ),
    );

Widget _nextButton(BuildContext context, String label, VoidCallback onPressed) =>
    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18)),
        child: Text(label),
      ),
    );

// ── Step 1: Identity ─────────────────────────────────────────────────────────

class _IdentityStep extends StatefulWidget {
  final SetupIdentityState state;
  const _IdentityStep({required this.state});

  @override
  State<_IdentityStep> createState() => _IdentityStepState();
}

class _IdentityStepState extends State<_IdentityStep> {
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _hostCtrl;
  late final TextEditingController _portCtrl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController(text: widget.state.username);
    _hostCtrl     = TextEditingController(text: widget.state.hubHost);
    _portCtrl     = TextEditingController(text: '${widget.state.hubPort}');
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _hostCtrl.dispose();
    _portCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<SetupBloc>().add(SetupEvent.identitySubmitted(
      username: _usernameCtrl.text.trim(),
      hubHost:  _hostCtrl.text.trim(),
      hubPort:  int.tryParse(_portCtrl.text.trim()) ?? kDefaultHubPort,
    ));
  }

  @override
  Widget build(BuildContext context) => _stepBody(
        Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _SectionLabel('Your Identity'),
            const SizedBox(height: 16),
            TextFormField(
              controller:  _usernameCtrl,
              decoration:  const InputDecoration(
                  labelText: 'Username', prefixIcon: Icon(Icons.person_outline)),
              maxLength:   32,
              validator:   (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter a username' : null,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 32),
            _SectionLabel('Hub Address'),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller:  _hostCtrl,
                  decoration:  const InputDecoration(
                      labelText: 'Host', prefixIcon: Icon(Icons.dns_outlined)),
                  validator:   (v) =>
                      (v == null || v.trim().isEmpty) ? 'Enter a host' : null,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller:  _portCtrl,
                  decoration:  const InputDecoration(labelText: 'Port'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator:   (v) {
                    final n = int.tryParse(v ?? '');
                    return (n == null || n < 1 || n > 65535)
                        ? 'Bad port'
                        : null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                ),
              ),
            ]),
            const SizedBox(height: 40),
            _nextButton(context, 'Next — Audio Input', _submit),
          ]),
        ),
      );
}

// ── Step 2: Audio Input ───────────────────────────────────────────────────────

class _AudioInputStep extends StatefulWidget {
  final SetupAudioInputState state;
  const _AudioInputStep({required this.state});

  @override
  State<_AudioInputStep> createState() => _AudioInputStepState();
}

class _AudioInputStepState extends State<_AudioInputStep> {
  late AudioInputMode _mode;
  AudioDeviceInfo?    _selectedDevice;
  AudioSessionInfo?   _selectedSession;

  @override
  void initState() {
    super.initState();
    _mode            = widget.state.selectedMode;
    _selectedDevice  = widget.state.selectedInputDevice;
    _selectedSession = widget.state.selectedSession;
  }

  void _setMode(AudioInputMode newMode) {
    if (newMode == _mode) return;
    setState(() {
      _mode           = newMode;
      _selectedDevice = null; // clear stale device when switching modes
    });
  }

  void _submit() {
    context.read<SetupBloc>().add(SetupEvent.audioInputSelected(
      inputMode:    _mode,
      inputDevice:  _selectedDevice,
      audioSession: _selectedSession,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final tt      = Theme.of(context).textTheme;
    final devices = _mode == AudioInputMode.loopback
        ? widget.state.outputDevices
        : widget.state.inputDevices;

    final deviceLabel = switch (_mode) {
      AudioInputMode.mic      => 'Choose Microphone',
      AudioInputMode.loopback => 'Choose Output Device',
      _                       => 'Choose Device',
    };

    return _stepBody(Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header row with refresh button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _SectionLabel('Audio Source'),
            TextButton.icon(
              icon:    const Icon(Icons.refresh_outlined, size: 16),
              label:   const Text('Refresh'),
              onPressed: () => context
                  .read<SetupBloc>()
                  .add(const SetupEvent.devicesRefreshed()),
              style: TextButton.styleFrom(
                foregroundColor: kColorTextMuted,
                visualDensity:  VisualDensity.compact,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Mode chips
        Wrap(spacing: 10, children: [
          _ModeChip(
            label:    'Microphone',
            icon:     Icons.mic_outlined,
            selected: _mode == AudioInputMode.mic,
            onTap:    () => _setMode(AudioInputMode.mic),
          ),
          _ModeChip(
            label:    'System Loopback',
            icon:     Icons.speaker_outlined,
            selected: _mode == AudioInputMode.loopback,
            onTap:    () => _setMode(AudioInputMode.loopback),
          ),
          _ModeChip(
            label:    'App Capture',
            icon:     Icons.apps_outlined,
            selected: _mode == AudioInputMode.processCapture,
            onTap:    () => _setMode(AudioInputMode.processCapture),
          ),
        ]),
        const SizedBox(height: 24),

        // Device / session list for the selected mode
        if (_mode == AudioInputMode.processCapture) ...[
          const _SectionLabel('Choose Application'),
          const SizedBox(height: 8),
          if (widget.state.audioSessions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No active audio sessions found.\nStart the app you want to capture, then tap Refresh.',
                style: tt.bodyMedium?.copyWith(color: kColorTextMuted),
              ),
            )
          else
            ...widget.state.audioSessions.map((sess) => _SessionTile(
                  session:  sess,
                  selected: _selectedSession?.pid == sess.pid,
                  onTap:    () => setState(() => _selectedSession = sess),
                )),
        ] else ...[
          _SectionLabel(deviceLabel),
          const SizedBox(height: 8),
          if (devices.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No devices found. Tap Refresh to try again.',
                style: tt.bodyMedium?.copyWith(color: kColorTextMuted),
              ),
            )
          else
            ...devices.map((dev) => _DeviceTile(
                  device:   dev,
                  selected: _selectedDevice?.index == dev.index,
                  onTap:    () => setState(() => _selectedDevice = dev),
                )),
        ],

        const SizedBox(height: 40),
        _nextButton(context, 'Next — Audio Output', _submit),
      ],
    ));
  }
}

// ── Step 3: Audio Output ──────────────────────────────────────────────────────

class _AudioOutputStep extends StatefulWidget {
  final SetupAudioOutputState state;
  const _AudioOutputStep({required this.state});

  @override
  State<_AudioOutputStep> createState() => _AudioOutputStepState();
}

class _AudioOutputStepState extends State<_AudioOutputStep> {
  AudioDeviceInfo? _selectedDevice;

  @override
  void initState() {
    super.initState();
    _selectedDevice = widget.state.selectedOutputDevice;
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return _stepBody(Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionLabel('Playback Device'),
        const SizedBox(height: 8),
        Text('Leave unselected to use the system default.',
            style: tt.bodyMedium?.copyWith(color: kColorTextMuted)),
        const SizedBox(height: 16),
        _DeviceTile(
          device:   const AudioDeviceInfo(index: -1, name: 'System Default', isOutput: true),
          selected: _selectedDevice == null,
          onTap:    () => setState(() => _selectedDevice = null),
        ),
        ...widget.state.outputDevices.map((dev) => _DeviceTile(
              device:   dev,
              selected: _selectedDevice?.index == dev.index,
              onTap:    () => setState(() => _selectedDevice = dev),
            )),
        const SizedBox(height: 40),
        _nextButton(
          context,
          'Next — Proximity Settings',
          () => context.read<SetupBloc>().add(
              SetupEvent.audioOutputSelected(outputDevice: _selectedDevice)),
        ),
      ],
    ));
  }
}

// ── Step 4: Proximity ─────────────────────────────────────────────────────────

class _ProximityStep extends StatefulWidget {
  final SetupProximityState state;
  const _ProximityStep({required this.state});

  @override
  State<_ProximityStep> createState() => _ProximityStepState();
}

class _ProximityStepState extends State<_ProximityStep> {
  late ProximityParams _params;

  @override
  void initState() {
    super.initState();
    _params = widget.state.params;
  }

  @override
  Widget build(BuildContext context) => _stepBody(
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const _SectionLabel('Proximity Parameters'),
          const SizedBox(height: 8),
          Text(
            'These can also be adjusted live during a session.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: kColorTextMuted),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ProximityForm(
                initial:   _params,
                onChanged: (p) => setState(() => _params = p),
              ),
            ),
          ),
          const SizedBox(height: 40),
          _nextButton(
            context,
            'Connect',
            () => context.read<SetupBloc>().add(
                SetupEvent.proximitySubmitted(params: _params)),
          ),
        ]),
      );
}

// ── Shared sub-widgets ────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Text(text,
      style: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(color: kColorTextMuted, letterSpacing: 1.2));
}

class _ModeChip extends StatelessWidget {
  final String   label;
  final IconData icon;
  final bool     selected;
  final VoidCallback onTap;
  const _ModeChip(
      {required this.label,
      required this.icon,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar:   Icon(icon, size: 16, color: selected ? kColorPrimary : kColorTextMuted),
      label:    Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: kColorPrimary.withAlpha(40),
      labelStyle: TextStyle(
          color: selected ? kColorPrimary : kColorText,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  final AudioDeviceInfo device;
  final bool            selected;
  final VoidCallback    onTap;
  const _DeviceTile({required this.device, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) => ListTile(
        dense:        true,
        leading:      Icon(
          device.isOutput ? Icons.speaker_outlined : Icons.mic_outlined,
          color: selected ? kColorPrimary : kColorTextMuted,
        ),
        title:        Text(device.name),
        trailing:     selected
            ? const Icon(Icons.check_circle, color: kColorPrimary)
            : null,
        selected:     selected,
        selectedColor: kColorPrimary,
        onTap:        onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );
}

class _SessionTile extends StatelessWidget {
  final AudioSessionInfo session;
  final bool             selected;
  final VoidCallback     onTap;
  const _SessionTile({required this.session, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return ListTile(
      dense:   true,
      leading: Icon(Icons.apps_outlined,
          color: selected ? kColorPrimary : kColorTextMuted),
      title:   Text(session.displayName),
      subtitle:Text(
        '${session.deviceName}  •  ${session.sharedWith} app${session.sharedWith == 1 ? '' : 's'} sharing',
        style: tt.bodyMedium?.copyWith(color: kColorTextMuted),
      ),
      trailing: selected
          ? const Icon(Icons.check_circle, color: kColorPrimary)
          : null,
      selected:     selected,
      selectedColor: kColorPrimary,
      onTap:        onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
