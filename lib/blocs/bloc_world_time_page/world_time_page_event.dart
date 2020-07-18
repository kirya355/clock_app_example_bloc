part of 'world_time_page_bloc.dart';

abstract class WorldTimePageEvent extends Equatable {
  const WorldTimePageEvent();
}
class TimerTicked extends WorldTimePageEvent {
  final String time;

  const TimerTicked({@required this.time});

  @override
  List<Object> get props => [time];

  @override
  String toString() => "TimerTicked { time: $time }";
}