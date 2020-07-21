import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

class StopwatchTicker {
  Stream<int> tick() {
    return Stream.periodic(Duration(milliseconds: 10), (x) => x + 1);
  }
}

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  final StopwatchTicker _ticker;
  static const int _duration = 0;
  StreamSubscription<int> _tickerSubscription;
  List<String> _list = new List();
  StopwatchBloc({@required StopwatchTicker ticker})
      : assert(ticker != null),
        _ticker = ticker,
        super(TimerInitial(_duration, null));

  @override
  void onTransition(Transition<StopwatchEvent, StopwatchState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<StopwatchState> mapEventToState(
    StopwatchEvent event,
  ) async* {
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState();
    } else if (event is TimerPaused) {
      yield* _mapTimerPausedToState(event);
    } else if (event is TimerLoop) {
      yield* _mapTimerLoopToState(event);
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

  Stream<StopwatchState> _mapTimerStartedToState() async* {
    yield TimerRunInProgress(_duration, _list);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick()
        .listen((duration) => add(TimerTicked(duration: duration + _duration)));
  }

  Stream<StopwatchState> _mapTimerPausedToState(TimerPaused pause) async* {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      yield TimerRunPause(state.duration, _list);
    }
  }

  Stream<StopwatchState> _mapTimerResumedToState(TimerResumed resume) async* {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      yield TimerRunInProgress(state.duration, _list);
    }
  }

  Stream<StopwatchState> _mapTimerResetToState(TimerReset reset) async* {
    _tickerSubscription?.cancel();
    _list = new List();
    yield TimerInitial(0, _list);
  }

  Stream<StopwatchState> _mapTimerTickedToState(TimerTicked tick) async* {
    yield TimerRunInProgress(tick.duration, _list);
  }

  Stream<StopwatchState> _mapTimerLoopToState(TimerLoop tick) async* {
    Duration _duration = Duration(milliseconds: tick.duration * 10);
    String _milliseconds = ((_duration.inMilliseconds / 10) % 100)
        .floor()
        .toString()
        .padLeft(2, '0');
    String _seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');
    String _minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    String _hours = (_duration.inHours).toString().padLeft(2, '0');
    _list.add(
        '#${_list != null ? _list.length : 1}: ${_duration.inHours == 0 ? '$_minutes:$_seconds.$_milliseconds' : '$_hours:$_minutes:$_seconds'}');
    yield TimerRunInProgress(tick.duration, _list);
  }

  /// Schedules a notification that specifies a different icon, sound and vibration pattern
/* Future<void> _scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 0));
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description',
        sound: RawResourceAndroidNotificationSound('slow_spring_board'),
        vibrationPattern: vibrationPattern,
        enableLights: true,
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        titles[3],
        'Время вышло',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }*/
}
