import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class Ticker {
  Stream<int> tick({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 0;
  int hours = 0, minutes = 0, seconds = 0;
  int startDuration = 0;
  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker,
        super(TimerInitial(_duration, null));

  @override
  void onTransition(Transition<TimerEvent, TimerState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState();
    } else if (event is TimerPicked) {
      _tickerSubscription?.cancel();
      startDuration = 0;
      if (event.hours != null) hours = event.hours;
      if (event.minutes != null) minutes = event.minutes;
      if (event.seconds != null) seconds = event.seconds;
      startDuration += seconds;
      startDuration += minutes * 60;
      startDuration += hours * 3600;
      yield TimerInitial(startDuration, startDuration);
    } else if (event is TimerPaused) {
      yield* _mapTimerPausedToState(event);
    } else if (event is TimerResumed) {
      yield* _mapTimerResumedToState(event);
    } else if (event is TimerReset) {
      yield* _mapTimerResetToState(event);
    } else if (event is TimerTicked) {
      yield* _mapTimerTickedToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState() async* {
    yield TimerRunInProgress(startDuration, startDuration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: startDuration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  Stream<TimerState> _mapTimerPausedToState(TimerPaused pause) async* {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      yield TimerRunPause(state.duration, startDuration);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumed resume) async* {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      yield TimerRunInProgress(state.duration, startDuration);
    }
  }

  Stream<TimerState> _mapTimerResetToState(TimerReset reset) async* {
    _tickerSubscription?.cancel();
    hours = 0;
    minutes = 0;
    seconds = 0;
    yield TimerInitial(0, null);
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async* {
    yield tick.duration > 0
        ? TimerRunInProgress(tick.duration, startDuration)
        : TimerRunComplete();
  }
}
