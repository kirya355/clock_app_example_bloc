part of 'stopwatch_bloc.dart';

@immutable
abstract class StopwatchEvent extends Equatable {
  const StopwatchEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends StopwatchEvent {
  const TimerStarted();

  @override
  String toString() => "TimerStarted { duration: 0}";
}

class TimerPaused extends StopwatchEvent {}

class TimerLoop extends StopwatchEvent {
  final int duration;
  const TimerLoop({@required this.duration});

  @override
  List<Object> get props => [duration];
}

class TimerResumed extends StopwatchEvent {}

class TimerReset extends StopwatchEvent {}

class TimerTicked extends StopwatchEvent {
  final int duration;
  const TimerTicked({@required this.duration});

  @override
  List<Object> get props => [duration];
}
