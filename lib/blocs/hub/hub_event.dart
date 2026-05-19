part of 'hub_bloc.dart';

@freezed
class HubEvent with _$HubEvent {
  const factory HubEvent.startRequested({@Default(kDefaultHubPort) int port}) = HubStartRequested;
  const factory HubEvent.stopRequested()                                       = HubStopRequested;
  const factory HubEvent.restartRequested()                                    = HubRestartRequested;
  const factory HubEvent.statusRefreshed()                                     = HubStatusRefreshed;
}
