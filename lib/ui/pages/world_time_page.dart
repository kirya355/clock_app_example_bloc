import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timerblocexample/blocs/bloc_world_time_page/world_time_page_bloc.dart';
import 'package:timerblocexample/constants.dart';

class WorldTimePage extends StatelessWidget {
  WorldTimePage() : super();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          titles[0],
          style: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 200.0),
                child: Center(
                  child: BlocBuilder<WorldTimePageBloc, WorldTimePageState>(
                    builder: (context, state) {
                      return Column(
                        children: <Widget>[
                          Text(
                            yourTime,
                            style: yourTimeStyle,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            state.time != null ? state.time : '',
                            style: worldTimeText,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          state.location != null
                              ? Column(children: <Widget>[
                                  Text(
                                    yourLocation,
                                    style: yourTimeStyle,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    state.location,
                                    style: worldLocationText,
                                  ),
                                ])
                              : SizedBox()
                        ],
                      );
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
