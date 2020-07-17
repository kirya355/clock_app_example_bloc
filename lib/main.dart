import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timerblocexample/blocs/bloc_page/page_bloc.dart';
import 'package:timerblocexample/ui/app_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => PageBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AppScreen());
  }
}
