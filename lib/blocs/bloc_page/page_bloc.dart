import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(StateAlarm());
  int currentIndex = 0;

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    if (event is TapEvent) {
      print('index: ${event.index}');
      if (event.index != null)
        this.currentIndex = event.index;
      else
        this.currentIndex = 0;
      if (this.currentIndex == 0) {
        yield StateAlarm();
      }
      if (this.currentIndex == 1) {
        yield StateWorldTime();
      }
      if (this.currentIndex == 2) {
        yield StateStopwatch();
      }
      if (this.currentIndex == 3) {
        yield StateTimer();
      }
    }
  }
}
