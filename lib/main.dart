import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timerblocexample/blocs/bloc_page/pages_bloc.dart';
import 'package:timerblocexample/blocs/bloc_world_time_page/world_time_page_bloc.dart';
import 'package:timerblocexample/ui/app_screen.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => PageBloc(),
    ),
    BlocProvider(
      create: (context) => WorldTimePageBloc(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AppScreen());
  }
}
