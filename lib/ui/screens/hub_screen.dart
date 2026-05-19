import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/hub/hub_bloc.dart';
import '../../blocs/setup/setup_bloc.dart';
import '../../protocol/protocol.dart';
import '../theme.dart';

/// Hub management screen — start / stop a local relay server.
class HubScreen extends StatefulWidget {
  const HubScreen({super.key});

  @override
  State<HubScreen> createState() => _HubScreenState();
}

class _HubScreenState extends State<HubScreen> {
  final _portCtrl = TextEditingController(text: '$kDefaultHubPort');
  final _formKey  = GlobalKey<FormState>();

  @override
  void dispose() {
    _portCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorBg,
        elevation:       0,
        title: const Text('Hub Server'),
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: BlocConsumer<HubBloc, HubState>(
        listener: (context, state) {
          if (state is HubFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:         Text(state.message),
              backgroundColor: kColorError,
            ));
          }
        },
        builder: (context, state) => switch (state) {
          HubStopped() => _StoppedView(portCtrl: _portCtrl, formKey: _formKey),
          HubStarting() => const _LoadingView(),
          HubRunning()  => _RunningView(state: state),
          HubFailed()   => _StoppedView(portCtrl: _portCtrl, formKey: _formKey),
          _             => const _LoadingView(),
        },
      ),
    );
  }
}

// ── Stopped ───────────────────────────────────────────────────────────────────

class _StoppedView extends StatelessWidget {
  final TextEditingController portCtrl;
  final GlobalKey<FormState>  formKey;
  const _StoppedView({required this.portCtrl, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.dns_outlined, size: 56, color: kColorPrimary),
                const SizedBox(height: 20),
                Text('Start Hub Server',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(
                  'Clients will connect to your IP on this port.\n'
                  'The hub never processes audio — it only relays.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: kColorTextMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller:   portCtrl,
                  decoration:   const InputDecoration(
                    labelText:  'Port',
                    prefixIcon: Icon(Icons.settings_ethernet_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    final n = int.tryParse(v ?? '');
                    return (n == null || n < 1 || n > 65535)
                        ? 'Enter a valid port (1–65535)'
                        : null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon:  const Icon(Icons.play_arrow_outlined),
                  label: const Text('Start Hub'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<HubBloc>().add(HubEvent.startRequested(
                        port: int.parse(portCtrl.text.trim()),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Loading ───────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) => const Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CircularProgressIndicator(color: kColorPrimary),
          SizedBox(height: 20),
          Text('Starting hub…'),
        ]),
      );
}

// ── Running ───────────────────────────────────────────────────────────────────

class _RunningView extends StatelessWidget {
  final HubRunning state;
  const _RunningView({required this.state});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Status badge
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 12, height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kColorSuccess,
                  ),
                ),
                const SizedBox(width: 10),
                Text('Hub running on port ${state.port}',
                    style: tt.titleLarge?.copyWith(color: kColorSuccess)),
              ]),
              const SizedBox(height: 32),

              // Room list
              Text('ACTIVE ROOMS',
                  style: tt.labelLarge?.copyWith(color: kColorTextMuted)),
              const SizedBox(height: 12),
              if (state.rooms.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text('No rooms yet — waiting for clients…',
                      style: tt.bodyMedium?.copyWith(color: kColorTextMuted),
                      textAlign: TextAlign.center),
                )
              else
                ...state.rooms.map((r) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: const Icon(Icons.meeting_room_outlined,
                            color: kColorPrimary),
                        title: Text(r.code,
                            style: tt.titleMedium
                                ?.copyWith(fontFamily: 'monospace')),
                        trailing: Text('${r.count} player${r.count == 1 ? '' : 's'}',
                            style: tt.bodyMedium),
                      ),
                    )),
              const Spacer(),

              // Connect as client
              OutlinedButton.icon(
                icon:  const Icon(Icons.person_add_outlined),
                label: const Text('Connect as Client'),
                onPressed: () {
                  context.read<SetupBloc>().add(SetupEvent.started(
                    prefilledHost: 'localhost',
                    prefilledPort: state.port,
                  ));
                  Navigator.of(context).pushNamed('/setup');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: kColorSecondary,
                  side:            const BorderSide(color: kColorSecondary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 12),

              // Stop button
              OutlinedButton.icon(
                icon:  const Icon(Icons.stop_circle_outlined),
                label: const Text('Stop Hub'),
                onPressed: () =>
                    context.read<HubBloc>().add(const HubEvent.stopRequested()),
                style: OutlinedButton.styleFrom(
                  foregroundColor: kColorError,
                  side:            const BorderSide(color: kColorError),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
