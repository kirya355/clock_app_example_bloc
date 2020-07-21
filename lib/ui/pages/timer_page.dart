import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timerblocexample/blocs/bloc_timer/timer_bloc.dart';
import 'package:timerblocexample/constants.dart';

class TimerPage extends StatelessWidget {
  TimerPage() : super();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          titles[2],
          style: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Center(
          child: BlocBuilder<TimerBloc, TimerState>(
            builder: (context, state) {
              Duration _duration = Duration(seconds: state.duration);
              String _minutes =
                  (_duration.inMinutes % 60).toString().padLeft(2, '0');
              String _seconds =
                  (_duration.inSeconds % 60).toString().padLeft(2, '0');
              return Column(
                children: <Widget>[
                  state is TimerRunComplete
                      ? Text(
                          timeOut,
                          style: worldTimeText,
                          textAlign: TextAlign.center,
                        )
                      : CircularPercentIndicator(
                          radius: 270.0,
                          lineWidth: 13.0,
                          percent: !(state is TimerInitial)
                              ? ((state.duration) / state.startDuration)
                              : 0,
                          center: Text(
                            '${_duration.inHours.toString().padLeft(2, '0')}:$_minutes:$_seconds',
                            style: worldTimeText,
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: colorScheme.primary,
                          backgroundColor: colors[0],
                        ),
                  SizedBox(
                    height: 40,
                  ),
                  TimePicker(state),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) => Actions(state,colorScheme),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class TimePicker extends StatelessWidget {
  final TimerState state;
  TimePicker(this.state);

  TimerBloc timerBloc;
  @override
  Widget build(BuildContext context) {
    timerBloc = BlocProvider.of<TimerBloc>(context);
    return timerBloc.state is TimerInitial
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  NumberPicker.integer(
                    infiniteLoop: true,
                    initialValue: (state.duration / 3600).floor(),
                    minValue: 0,
                    maxValue: 99,
                    onChanged: (newValue) =>
                        timerBloc.add(TimerPicked(hours: newValue)),
                  ),
                  Text(textUnderPicker[0])
                ],
              ),
              Column(
                children: <Widget>[
                  NumberPicker.integer(
                      infiniteLoop: true,
                      initialValue: ((state.duration / 60) % 60).floor(),
                      minValue: 0,
                      maxValue: 59,
                      onChanged: (newValue) =>
                          timerBloc.add(TimerPicked(minutes: newValue))),
                  Text(textUnderPicker[1]),
                ],
              ),
              Column(
                children: <Widget>[
                  NumberPicker.integer(
                      infiniteLoop: true,
                      initialValue: state.duration % 60,
                      minValue: 0,
                      maxValue: 59,
                      onChanged: (newValue) =>
                          timerBloc.add(TimerPicked(seconds: newValue))),
                  Text(textUnderPicker[2]),
                ],
              ),
            ],
          )
        : SizedBox();
  }
}

class Actions extends StatelessWidget {
  final TimerState state;
  final ColorScheme colorScheme;
  Actions(this.state,this.colorScheme);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
        timerBloc: BlocProvider.of<TimerBloc>(context), colorScheme: colorScheme
      ),
    );
  }

  List<Widget> _mapStateToActionButtons({
    TimerBloc timerBloc, ColorScheme colorScheme
  }) {
    final TimerState currentState = timerBloc.state;
    if (currentState is TimerInitial) {
      return [
        FloatingActionButton(

          child: Icon(
            Icons.play_arrow, color: colorScheme.background,
          ),
          onPressed: () => state.duration != 0
              ? timerBloc.add(TimerStarted(duration: state.duration))
              : null,
        ),
      ];
    }
    if (currentState is TimerRunInProgress) {
      return [
        IconButton(
          icon: Icon(Icons.replay),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
        FloatingActionButton(

          child: Icon(Icons.pause,color: colorScheme.background,),
          onPressed: () => timerBloc.add(TimerPaused()),
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


          child: Icon(Icons.play_arrow,color: colorScheme.background,),
          onPressed: () => timerBloc.add(TimerResumed()),
        ),
      ];
    }
    if (currentState is TimerRunComplete) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay,color: colorScheme.background,),
          onPressed: () => timerBloc.add(TimerReset()),
        ),
      ];
    }
    return [];
  }
}
