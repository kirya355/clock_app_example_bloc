part of 'pages_bloc.dart';

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