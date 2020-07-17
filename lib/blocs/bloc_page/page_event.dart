part of 'page_bloc.dart';

//enum PageEvent { eventTap/*, eventAlarm, eventWorldTime, eventStopwatch, eventTimer*/ }
abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class TapEvent extends PageEvent {
  final int index;
  const TapEvent({@required this.index});

  @override
  String toString() => "TapEvent { index: $index }";
}