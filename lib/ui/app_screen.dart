import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timerblocexample/blocs/bloc_page/page_bloc.dart';
import 'package:timerblocexample/constants.dart';
import 'package:timerblocexample/ui/pages/pages.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageBloc _pageBloc = BlocProvider.of<PageBloc>(context);
    return Scaffold(
      body: BlocBuilder<PageBloc, PageState>(
        bloc: _pageBloc,
        builder: (_, state) {
          if (state is StateAlarm) return AlarmPage();
          if (state is StateWorldTime) return WorldTimePage();
          if (state is StateStopwatch) return StopwatchPage();
          if (state is StateTimer) return TimerPage();
          return SizedBox();
        },
      ),
      bottomNavigationBar: BlocBuilder<PageBloc, PageState>(
        bloc: _pageBloc,
        builder: (_, state) {
          return BottomNavigationBar(
            currentIndex: _pageBloc.currentIndex,
            selectedItemColor: selectedItemBottomBarColor,
            unselectedItemColor: unselectedItemBottomBarColor,
            items: [
              BottomNavigationBarItem(
                backgroundColor: backgroundBottomBarColor,
                icon: Icon(
                  Icons.alarm,
                ),
                title: Text('Alarm'),
              ),
              BottomNavigationBarItem(
                backgroundColor: backgroundBottomBarColor,
                icon: Icon(Icons.language),
                title: Text(
                  'World Time',
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: backgroundBottomBarColor,
                icon: Icon(
                  Icons.timer,
                ),
                title: Text(
                  'Stopwatch',
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: backgroundBottomBarColor,
                icon: Icon(
                  Icons.av_timer,
                ),
                title: Text(
                  'Timer',
                ),
              ),
            ],
            onTap: (_index) => TapEvent(index: _index),
          );
        },
      ),
    );
  }
}