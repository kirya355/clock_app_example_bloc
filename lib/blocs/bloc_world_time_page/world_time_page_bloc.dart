import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'world_time_page_event.dart';
part 'world_time_page_state.dart';

class Ticker {
  Stream<int> tick() {
    return Stream.periodic(Duration(seconds: 1));
  }
}

class WorldTimePageBloc extends Bloc<WorldTimePageEvent, WorldTimePageState> {
  final Ticker _ticker;
  static String timeInit =
      '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}';
  WorldTimePageBloc()
      : _ticker = Ticker(),
        super(WorldTimePageInitial(timeInit));
  StreamSubscription<int> _tickerSubscription;

  @override
  Stream<WorldTimePageState> mapEventToState(
    WorldTimePageEvent event,
  ) async* {
    if (event is TimerTicked) {
      String timeNow =
          '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}';
      yield WorldTimePageInitial(timeNow);
    }
    // TODO: implement mapEventToState
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
