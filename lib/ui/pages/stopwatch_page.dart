import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timerblocexample/constants.dart';
import 'package:timerblocexample/blocs/bloc_stopwatch/stopwatch_bloc.dart';

class StopwatchPage extends StatelessWidget {
  StopwatchPage() : super();
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          titles[1],
          style: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Center(
          child: BlocBuilder<StopwatchBloc, StopwatchState>(
            builder: (context, state) {
              Duration _duration = Duration(milliseconds: state.duration * 10);
              String _milliseconds = ((_duration.inMilliseconds / 10) % 100)
                  .floor()
                  .toString()
                  .padLeft(2, '0');
              String _seconds =
                  (_duration.inSeconds % 60).toString().padLeft(2, '0');
              String _minutes =
                  (_duration.inMinutes % 60).toString().padLeft(2, '0');
              String _hours = (_duration.inHours).toString().padLeft(2, '0');
              return Column(
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 270.0,
                    lineWidth: 13.0,
                    percent: (_duration.inMilliseconds % 60000) / 60000,
                    center: _duration.inHours == 0
                        ? Text(
                            '$_minutes:$_seconds.$_milliseconds',
                            style: worldTimeText,
                          )
                        : Text(
                            '$_hours:$_minutes:$_seconds',
                            style: worldTimeText,
                          ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: colors[(_duration.inMinutes % 6) + 1],
                    backgroundColor: colors[_duration.inMinutes % 6],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  (state.list != null)
                      ? Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: Scrollbar(
                            controller: _controller,
                            child: ListView.builder(
                                controller: _controller,
                                padding: const EdgeInsets.all(8),
                                itemCount: state.list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                    state.list[index],
                                    style: underStopwatchStyleText,
                                    textAlign: TextAlign.center,
                                  );
                                }),
                          ),
                        )
                      : SizedBox()

                  //TimePicker(state),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<StopwatchBloc, StopwatchState>(
        builder: (context, state) => ActionsStopwatch(state, colorScheme),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ActionsStopwatch extends StatelessWidget {
  final StopwatchState state;
  final ColorScheme colorScheme;
  ActionsStopwatch(this.state, this.colorScheme);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
          timerBloc: BlocProvider.of<StopwatchBloc>(context),
          colorScheme: colorScheme),
    );
  }

  List<Widget> _mapStateToActionButtons(
      {StopwatchBloc timerBloc, ColorScheme colorScheme}) {
    final StopwatchState currentState = timerBloc.state;

    if (currentState is TimerInitial) {
      return [
        IconButton(
          icon: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
          color: colorScheme.onBackground,
        ),
        FloatingActionButton(
          child: Icon(
            Icons.play_arrow,
            color: colorScheme.background,
          ),
          onPressed: () => timerBloc.add(TimerStarted()),
        ),
        IconButton(
          icon: Icon(Icons.timer),
          onPressed: null,
          color: colorScheme.onBackground,
        ),
      ];
    }
    if (currentState is TimerRunInProgress) {
      return [
        IconButton(
          icon: Icon(Icons.replay),
          onPressed: () => null,
          color: colorScheme.onBackground,
        ),
        FloatingActionButton(
          child: Icon(
            Icons.pause,
            color: colorScheme.background,
          ),
          onPressed: () => timerBloc.add(TimerPaused()),
        ),
        IconButton(
          icon: Icon(
            Icons.timer,
            color: colorScheme.onPrimary,
          ),
          onPressed: () => timerBloc.add(TimerLoop(duration: state.duration)),
        ),
      ];
    }
    if (currentState is TimerRunPause) {
      return [
        IconButton(
          icon: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
        FloatingActionButton(
          child: Icon(
            Icons.play_arrow,
            color: colorScheme.background,
          ),
          onPressed: () => timerBloc.add(TimerResumed()),
        ),
        IconButton(
          icon: Icon(Icons.timer),
          onPressed: null,
          color: colorScheme.onBackground,
        ),
      ];
    }
    return [];
  }
}
