part of 'world_time_page_bloc.dart';

abstract class WorldTimePageState extends Equatable {
  final String time;
  final String location;
  const WorldTimePageState(this.time, this.location);
  @override
  List<Object> get props => [time];
}


class WorldTimePageInitial extends WorldTimePageState {
  const WorldTimePageInitial(String _time, String _location)
      : super(_time, _location);
}
