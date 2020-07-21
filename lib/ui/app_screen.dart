import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timerblocexample/blocs/bloc_page/pages_bloc.dart';
import 'package:timerblocexample/constants.dart';
import 'package:timerblocexample/ui/pages/pages.dart';

class AppScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final PageBloc _pageBloc = BlocProvider.of<PageBloc>(context);
    return Scaffold(
      body: BlocBuilder<PageBloc, PageState>(
        bloc: _pageBloc,
        builder: (_, state) {
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
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.onBackground,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.language),
                title: Text(
                  titles[0],
                ),
              ),
              BottomNavigationBarItem(

                icon: Icon(
                  Icons.timer,
                ),
                title: Text(
                  titles[1],
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.av_timer,
                ),
                title: Text(
                  titles[2],
                ),
              ),
            ],
            onTap: (_index) => _pageBloc.add(TapEvent(index: _index)),
          );
        },
      ),
    );
  }
}