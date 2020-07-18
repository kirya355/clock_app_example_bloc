import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timerblocexample/blocs/bloc_world_time_page/world_time_page_bloc.dart';

class WorldTimePage extends StatelessWidget {
  WorldTimePage() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(
                  child: BlocBuilder<WorldTimePageBloc, WorldTimePageState>(
                    builder: (context, state) {
                      return Text(state.time);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
