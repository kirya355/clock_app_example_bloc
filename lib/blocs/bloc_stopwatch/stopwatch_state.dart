part of 'stopwatch_bloc.dart';

@immutable
abstract class StopwatchState extends Equatable {
  final int duration;
  final List<String> list;
  const StopwatchState(this.duration, this.list);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends StopwatchState {
  const TimerInitial(int duration, List<String> list) : super(duration, list);
}

class TimerRunPause extends StopwatchState {
  const TimerRunPause(int duration, List<String> list) : super(duration, list);
}

class TimerRunInProgress extends StopwatchState {
  const TimerRunInProgress(int duration, List<String> list)
      : super(duration, list);
}
