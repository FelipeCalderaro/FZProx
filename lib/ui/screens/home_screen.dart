import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/hub/hub_bloc.dart';
import '../../blocs/setup/setup_bloc.dart';
import '../theme.dart';

/// Landing screen — choose between joining a session or hosting a hub.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo / title
                const Icon(Icons.spatial_audio_off_rounded,
                    size: 64, color: kColorPrimary),
                const SizedBox(height: 20),
                Text(
                  'HorizonProx',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: kColorPrimary, letterSpacing: 1),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Proximity voice chat for Forza Horizon',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: kColorTextMuted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 56),

                // Join button
                ElevatedButton.icon(
                  icon: const Icon(Icons.headset_mic_outlined),
                  label: const Text('Join / Host Session'),
                  onPressed: () {
                    context.read<SetupBloc>().add(const SetupEvent.started());
                    Navigator.of(context).pushNamed('/setup');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
                const SizedBox(height: 16),

                // Hub button — adapts based on whether the hub is running
                BlocBuilder<HubBloc, HubState>(
                  builder: (context, hubState) {
                    final running = hubState is HubRunning;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OutlinedButton.icon(
                          icon:  Icon(running
                              ? Icons.dns_rounded
                              : Icons.dns_outlined),
                          label: Text(running
                              ? 'Hub Running — port ${hubState.port}'
                              : 'Run Hub Server'),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/hub'),
                          style: running
                              ? OutlinedButton.styleFrom(
                                  foregroundColor: kColorSuccess,
                                  side: const BorderSide(color: kColorSuccess),
                                )
                              : null,
                        ),
                        if (running) ...[
                          const SizedBox(height: 10),
                          OutlinedButton.icon(
                            icon:  const Icon(Icons.person_add_outlined),
                            label: const Text('Connect to My Hub'),
                            onPressed: () {
                              context.read<SetupBloc>().add(SetupEvent.started(
                                prefilledHost: 'localhost',
                                prefilledPort: hubState.port,
                              ));
                              Navigator.of(context).pushNamed('/setup');
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: kColorSecondary,
                              side: const BorderSide(color: kColorSecondary),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
                const SizedBox(height: 48),

                // Forza telemetry hint
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color:        kColorSurface,
                    borderRadius: BorderRadius.circular(8),
                    border:       Border.all(color: kColorBorder),
                  ),
                  child: Row(children: [
                    const Icon(Icons.info_outline,
                        color: kColorSecondary, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Forza Data Out → 127.0.0.1:9988, format "Car Dash"',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: kColorTextMuted),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
