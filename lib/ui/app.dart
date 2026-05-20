import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../audio/audio_engine.dart';
import '../blocs/connection/connection_bloc.dart';
import '../blocs/hub/hub_bloc.dart';
import '../blocs/session/session_bloc.dart';
import '../blocs/setup/setup_bloc.dart';
import '../models/setup_config.dart';
import 'screens/home_screen.dart';
import 'screens/hub_screen.dart';
import 'screens/room_screen.dart';
import 'screens/session_screen.dart';
import 'screens/setup_screen.dart';
import 'theme.dart';

// ── Persistent hub status overlay ─────────────────────────────────────────────

// Navigator key shared between MaterialApp and the hub badge so the badge
// can push a dialog route from a context that is above the Navigator.
final _navKey = GlobalKey<NavigatorState>();

class _HubOverlay extends StatelessWidget {
  const _HubOverlay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HubBloc, HubState>(
      builder: (context, state) {
        if (state is HubStopped) return const SizedBox.shrink();
        return Positioned(
          bottom: 24,
          right:  24,
          child:  _HubBadge(state: state),
        );
      },
    );
  }
}

class _HubBadge extends StatelessWidget {
  final HubState state;
  const _HubBadge({required this.state});

  // builder context is above the Navigator, so we push directly via _navKey
  // instead of using showDialog(context: ...).
  void _showActions(BuildContext context) {
    final nav     = _navKey.currentState;
    if (nav == null) return;
    final bloc    = context.read<HubBloc>();
    final running = state is HubRunning;
    final port    = running ? (state as HubRunning).port : null;
    final rooms   = running ? (state as HubRunning).rooms.length : 0;

    nav.push<void>(PageRouteBuilder<void>(
      opaque:              false,
      barrierDismissible:  true,
      barrierColor:        Colors.black54,
      barrierLabel:        'Dismiss',
      pageBuilder: (ctx, animation, _) => FadeTransition(
        opacity: animation,
        child: AlertDialog(
        backgroundColor: kColorCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(children: [
          Container(
            width: 10, height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: running ? kColorSuccess : kColorPrimary,
            ),
          ),
          const SizedBox(width: 10),
          Text('Hub Server',
              style: Theme.of(ctx).textTheme.titleMedium),
        ]),
        content: Text(
          running
              ? 'Running on port $port\n$rooms active room${rooms == 1 ? '' : 's'}'
              : 'Starting…',
          style: Theme.of(ctx).textTheme.bodyMedium
              ?.copyWith(color: kColorTextMuted),
        ),
        actions: [
          if (running)
            TextButton.icon(
              icon:  const Icon(Icons.restart_alt_outlined, size: 18),
              label: const Text('Restart'),
              onPressed: () {
                Navigator.of(ctx).pop();
                bloc.add(const HubEvent.restartRequested());
              },
            ),
          TextButton.icon(
            icon:  const Icon(Icons.stop_circle_outlined, size: 18),
            label: const Text('Stop Hub'),
            onPressed: () {
              Navigator.of(ctx).pop();
              bloc.add(const HubEvent.stopRequested());
            },
            style: TextButton.styleFrom(foregroundColor: kColorError),
          ),
        ],
      ),        // closes AlertDialog
    ),          // closes FadeTransition
    ));         // closes PageRouteBuilder + nav.push
  }

  @override
  Widget build(BuildContext context) {
    final running  = state is HubRunning;
    final starting = state is HubStarting;

    return Material(
      elevation:    8,
      color:        kColorCard,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () => _showActions(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            // Status indicator
            if (starting)
              const SizedBox(
                width: 10, height: 10,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: kColorPrimary),
              )
            else
              Container(
                width: 10, height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kColorSuccess,
                ),
              ),
            const SizedBox(width: 8),
            Text(
              running
                  ? 'Hub  •  :${(state as HubRunning).port}'
                  : 'Hub starting…',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color:      kColorText,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.more_vert, size: 14, color: kColorTextMuted),
          ]),
        ),
      ),
    );
  }
}

class FzproxApp extends StatefulWidget {
  const FzproxApp({super.key});

  @override
  State<FzproxApp> createState() => _FzproxAppState();
}

class _FzproxAppState extends State<FzproxApp> {
  late final AudioEngine    _audioEngine;
  late final SetupBloc      _setupBloc;
  late final ConnectionBloc _connectionBloc;
  late final SessionBloc    _sessionBloc;
  late final HubBloc        _hubBloc;

  SetupConfig? _pendingConfig;

  @override
  void initState() {
    super.initState();
    _audioEngine    = AudioEngine();
    _setupBloc      = SetupBloc(audioEngine: _audioEngine);
    _connectionBloc = ConnectionBloc();
    _sessionBloc    = SessionBloc(audioEngine: _audioEngine);
    _hubBloc        = HubBloc();

    // When setup completes, immediately connect to the hub
    _setupBloc.stream.listen((state) {
      if (state is SetupCompleteState) {
        _pendingConfig = state.config;
        _connectionBloc.add(ConnectionEvent.connect(
          hubHost:  state.config.hubHost,
          hubPort:  state.config.hubPort,
          username: state.config.username,
        ));
      }
    });
  }

  @override
  void dispose() {
    _setupBloc.close();
    _connectionBloc.close();
    _sessionBloc.close();
    _hubBloc.close();
    _audioEngine.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _setupBloc),
        BlocProvider.value(value: _connectionBloc),
        BlocProvider.value(value: _sessionBloc),
        BlocProvider.value(value: _hubBloc),
      ],
      child: MaterialApp(
        title:         'HorizonProx',
        theme:         buildAppTheme(),
        navigatorKey:  _navKey,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // Persistent hub status badge rendered above all routes
        builder: (context, child) => Stack(
          children: [
            child!,
            const _HubOverlay(),
          ],
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                  builder: (_) => const HomeScreen());
            case '/setup':
              return MaterialPageRoute(
                  builder: (_) => const SetupScreen());
            case '/room':
              return MaterialPageRoute(
                  builder: (_) => BlocListener<ConnectionBloc, ConnectionState>(
                        listener: (context, state) {
                          // When connection enters inSession from /room,
                          // push /session — handled by RoomScreen's listener
                        },
                        child: const RoomScreen(),
                      ));
            case '/session':
              final config = _pendingConfig;
              if (config == null) {
                return MaterialPageRoute(builder: (_) => const HomeScreen());
              }
              return MaterialPageRoute(
                  builder: (_) => SessionScreen(config: config));
            case '/hub':
              return MaterialPageRoute(builder: (_) => const HubScreen());
            default:
              return MaterialPageRoute(builder: (_) => const HomeScreen());
          }
        },
      ),
    );
  }
}
