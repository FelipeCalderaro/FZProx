import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../hub/hub_server.dart';
import '../../protocol/protocol.dart';

part 'hub_bloc.freezed.dart';
part 'hub_event.dart';
part 'hub_state.dart';

class HubBloc extends Bloc<HubEvent, HubState> {
  HubServer? _server;
  Timer?     _refreshTimer;

  HubBloc() : super(const HubState.stopped()) {
    on<HubStartRequested>(_onStart);
    on<HubStopRequested>(_onStop);
    on<HubRestartRequested>(_onRestart);
    on<HubStatusRefreshed>(_onRefresh);
  }

  Future<void> _startServer(int port, Emitter<HubState> emit) async {
    emit(const HubState.starting());
    try {
      _server = HubServer(port: port);
      await _server!.start();
      emit(HubState.running(port: port, rooms: []));
      _refreshTimer = Timer.periodic(
        const Duration(seconds: 2),
        (_) => add(const HubEvent.statusRefreshed()),
      );
    } catch (e) {
      _server = null;
      emit(HubState.failed(message: 'Could not start hub: $e'));
    }
  }

  Future<void> _onStart(HubStartRequested event, Emitter<HubState> emit) =>
      _startServer(event.port, emit);

  Future<void> _onStop(HubStopRequested event, Emitter<HubState> emit) async {
    _refreshTimer?.cancel();
    await _server?.stop();
    _server = null;
    emit(const HubState.stopped());
  }

  Future<void> _onRestart(HubRestartRequested event, Emitter<HubState> emit) async {
    final port = state is HubRunning
        ? (state as HubRunning).port
        : kDefaultHubPort;
    _refreshTimer?.cancel();
    await _server?.stop();
    _server = null;
    await _startServer(port, emit);
  }

  void _onRefresh(HubStatusRefreshed event, Emitter<HubState> emit) {
    final current = state;
    if (current is! HubRunning || _server == null) return;
    emit(HubState.running(
      port:  current.port,
      rooms: _server!.roomSummaries,
    ));
  }

  @override
  Future<void> close() async {
    _refreshTimer?.cancel();
    await _server?.stop();
    return super.close();
  }
}
