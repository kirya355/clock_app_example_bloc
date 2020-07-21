import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timerblocexample/blocs/bloc_page/pages_bloc.dart';
import 'package:timerblocexample/blocs/bloc_timer/timer_bloc.dart';
import 'package:timerblocexample/blocs/bloc_world_time_page/world_time_page_bloc.dart';
import 'package:timerblocexample/constants.dart';
import 'package:timerblocexample/ui/app_screen.dart';
import 'package:timerblocexample/blocs/bloc_stopwatch/stopwatch_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => PageBloc(),
    ),
    BlocProvider(
      create: (context) => WorldTimePageBloc(),
    ),
    BlocProvider(
      create: (context) => TimerBloc(ticker: Ticker()),
    ),
    BlocProvider(
      create: (context) => StopwatchBloc(ticker: StopwatchTicker()),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));*/

    return MaterialApp(
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      debugShowCheckedModeBanner: false,
      home: AppScreen(),
    );
  }
}
