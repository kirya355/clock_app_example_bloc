import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


part 'world_time_page_event.dart';
part 'world_time_page_state.dart';

//

//
class WorldTimePageBloc extends Bloc<WorldTimePageEvent, WorldTimePageState> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  Stream<String> time() {
    var controller = StreamController<String>();
    String counter;
    void tick(Timer timer) {
      counter =
          '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}';
      controller.add(counter); // Ask stream to send counter values as event.
    }

    Timer.periodic(
        Duration(seconds: 1), tick); // BAD: Starts before it has subscribers.
    return controller.stream;
  }

  StreamSubscription<String> _tickerSubscription;
  static String initTime =
      '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}';

  WorldTimePageBloc() : super(WorldTimePageInitial(initTime, '')) {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        time().listen((_time) => add(TimerTicked(time: _time)));
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      _currentAddress = "${place.locality}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }

  @override
  Stream<WorldTimePageState> mapEventToState(
    WorldTimePageEvent event,
  ) async* {
    if (event is TimerTicked) {
      var _time = event.time;
      yield WorldTimePageInitial(_time, _currentAddress);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
