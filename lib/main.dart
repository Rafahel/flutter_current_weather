import 'dart:io';

import 'package:current_weather/bloc/weather_bloc.dart';
import 'package:current_weather/data/repository.dart';
import 'package:current_weather/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme:
            ThemeData(primarySwatch: Colors.blue, highlightColor: Colors.amber),
        home: BlocProvider(
          builder: (context) => WeatherBloc(Repository()),
          child: MyHomePage(title: 'Current Weather'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context).add(LoadFromDbEvent());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[900],
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white70,
          ),
          onPressed: () {
            final WeatherBloc weatherBloc =
                BlocProvider.of<WeatherBloc>(context);
            if (weatherBloc.state is WeatherIsNotSearchedState) {
              exit(0);
            } else {
              weatherBloc.add(ResetWeatherEvent());
            }
          },
        ),
      ),
      body: MainPage(),
      backgroundColor: Colors.grey[900],
      resizeToAvoidBottomInset: false,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
