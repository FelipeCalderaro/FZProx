import 'package:flutter/material.dart' hide ConnectionState;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/connection/connection_bloc.dart';
import '../../models/room_info.dart';
import '../../protocol/protocol.dart';
import '../theme.dart';

/// Room selection screen — list existing rooms or create a new one.
class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionBloc, ConnectionState>(
      listener: (context, state) {
        if (state is ConnectionInSession) {
          Navigator.of(context).pushReplacementNamed('/session');
        } else if (state is ConnectionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: kColorError,
          ));
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: kColorBg,
          elevation:       0,
          title: const Text('Choose a Room'),
          leading: BackButton(
            onPressed: () {
              context.read<ConnectionBloc>().add(const ConnectionEvent.disconnect());
              Navigator.of(context).pop();
            },
          ),
          actions: [
            if (state is ConnectionSelectingRoom)
              IconButton(
                icon:    const Icon(Icons.refresh_outlined),
                tooltip: 'Refresh rooms',
                onPressed: () =>
                    context.read<ConnectionBloc>().add(const ConnectionEvent.listRooms()),
              ),
          ],
        ),
        body: _RoomBody(state: state),
      ),
    );
  }
}

class _RoomBody extends StatelessWidget {
  final ConnectionState state;
  const _RoomBody({required this.state});

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      ConnectionIdle()        => _connectingView(context),
      ConnectionConnecting()  => _loadingView('Connecting to hub…'),
      ConnectionSelectingRoom(rooms: final rooms, username: final username) =>
          _RoomPicker(rooms: rooms, username: username),
      ConnectionJoining()     => _loadingView('Joining room…'),
      ConnectionReconnecting(attempt: final attempt) =>
          _loadingView('Reconnecting… (attempt ${attempt + 1})'),
      ConnectionFailed(message: final msg) => _errorView(context, msg),
      _                       => _loadingView('…'),
    };
  }

  Widget _loadingView(String msg) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircularProgressIndicator(color: kColorPrimary),
          const SizedBox(height: 20),
          Text(msg),
        ]),
      );

  Widget _connectingView(BuildContext context) {
    // RoomScreen is pushed after SetupBloc completes; ConnectionBloc.connect
    // is called from app.dart's route listener. This state appears only briefly.
    return _loadingView('Connecting…');
  }

  Widget _errorView(BuildContext context, String msg) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.error_outline, color: kColorError, size: 48),
          const SizedBox(height: 16),
          Text(msg, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back'),
          ),
        ]),
      );
}

// ── Room picker ──────────────────────────────────────────────────────────────

class _RoomPicker extends StatefulWidget {
  final List<RoomInfo> rooms;
  final String         username;
  const _RoomPicker({required this.rooms, required this.username});

  @override
  State<_RoomPicker> createState() => _RoomPickerState();
}

class _RoomPickerState extends State<_RoomPicker> {
  final _codeCtrl = TextEditingController();
  final _formKey  = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  void _joinCode(String code) {
    context.read<ConnectionBloc>().add(ConnectionEvent.joinRoom(
      code:     code.toUpperCase(),
      username: widget.username,
    ));
  }

  void _createRoom() {
    context.read<ConnectionBloc>().add(
        ConnectionEvent.createRoom(username: widget.username));
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Existing rooms
              if (widget.rooms.isNotEmpty) ...[
                Text('OPEN ROOMS',
                    style: tt.labelLarge?.copyWith(color: kColorTextMuted)),
                const SizedBox(height: 12),
                ...widget.rooms.map((r) => _RoomTile(
                      room:    r,
                      onJoin:  () => _joinCode(r.code),
                    )),
                const SizedBox(height: 32),
              ],

              // Create new room
              Text('CREATE OR JOIN',
                  style: tt.labelLarge?.copyWith(color: kColorTextMuted)),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller:    _codeCtrl,
                          decoration:    const InputDecoration(
                            labelText:   'Room code (4 characters)',
                            prefixIcon:  Icon(Icons.tag),
                            hintText:    'e.g.  ABCD',
                          ),
                          maxLength:     4,
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                            _UpperCaseFormatter(),
                          ],
                          validator: (v) => (v == null || v.length != 4)
                              ? 'Code must be exactly 4 characters'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Row(children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon:  const Icon(Icons.login_outlined),
                              label: const Text('Join'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _joinCode(_codeCtrl.text.trim());
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon:  const Icon(Icons.add_circle_outline),
                              label: const Text('Create Random'),
                              onPressed: _createRoom,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoomTile extends StatelessWidget {
  final RoomInfo     room;
  final VoidCallback onJoin;
  const _RoomTile({required this.room, required this.onJoin});

  @override
  Widget build(BuildContext context) {
    final tt    = Theme.of(context).textTheme;
    final isFull = room.playerCount >= kMaxPlayersPerRoom;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color:        kColorPrimary.withAlpha(30),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(room.code,
              style: tt.titleMedium?.copyWith(
                  color: kColorPrimary, fontFamily: 'monospace')),
        ),
        title: Text(
          '${room.playerCount} / $kMaxPlayersPerRoom players',
          style: tt.bodyLarge,
        ),
        subtitle: isFull
            ? Text('Full', style: tt.bodyMedium?.copyWith(color: kColorError))
            : null,
        trailing: ElevatedButton(
          onPressed: isFull ? null : onJoin,
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          child: const Text('Join'),
        ),
      ),
    );
  }
}

class _UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
          TextEditingValue o, TextEditingValue n) =>
      n.copyWith(text: n.text.toUpperCase());
}
