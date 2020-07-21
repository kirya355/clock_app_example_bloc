part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;
  final int startDuration;
  const TimerState(this.duration, this.startDuration);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration, int startDuration) : super(duration, startDuration);
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int duration, int startDuration)
      : super(duration, startDuration);
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration, int startDuration)
      : super(duration, startDuration);
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0, null);
}
