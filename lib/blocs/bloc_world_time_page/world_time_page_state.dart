part of 'world_time_page_bloc.dart';

abstract class WorldTimePageState extends Equatable {
  final String time;
  const WorldTimePageState(this.time);
  @override
  List<Object> get props => [time];
}

class WorldTimePageInitial extends WorldTimePageState {
  const WorldTimePageInitial(String time) : super(time);
}
