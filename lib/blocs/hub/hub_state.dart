part of 'hub_bloc.dart';

@freezed
class HubState with _$HubState {
  const factory HubState.stopped()                                         = HubStopped;
  const factory HubState.starting()                                        = HubStarting;
  const factory HubState.running({
    required int                          port,
    required List<({String code, int count})> rooms,
  })                                                                       = HubRunning;
  const factory HubState.failed({required String message})                 = HubFailed;
}
