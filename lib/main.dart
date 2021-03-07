import 'dart:io';

import 'package:current_weather/appTheme.dart';
import 'package:current_weather/bloc/theme_bloc.dart';
import 'package:current_weather/bloc/weather_bloc.dart';
import 'package:current_weather/selected_weather.dart';
import 'package:current_weather/data/repository.dart';
import 'package:current_weather/start_page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('pt_BR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          CurrentWeatherScreen.routeName: (context) => CurrentWeatherScreen(),
        },
        title: 'Current Weather App',
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
  static String flareAnimation = "switch_night";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: [
          AppBackground(),
          AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
                if (weatherBloc.state is WeatherIsNotSearchedState) {
                  weatherBloc.close();
                  exit(0);
                } else {
                  weatherBloc.add(ResetWeatherEvent());
                }
              },
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  setState(() async {
                    flareAnimation = (flareAnimation == "switch_night")
                        ? "switch_day"
                        : "switch_night";
                    BlocProvider.of<ThemeBloc>(context).add(ChangeThemeEvent());
                  });
                },
                child: Container(
                  child: FlareActor(
                    "assets/swich_day_night.flr",
                    animation: flareAnimation,
                    fit: BoxFit.contain,
                  ),
                  height: 10,
                  width: 65,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: MainPage(),
          ),
        ],
      )),
      backgroundColor: Colors.grey[900],
      resizeToAvoidBottomInset: false,
    );
  }
}

class AppBackground extends StatelessWidget {
  const AppBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          FlareCacheBuilder(["assets/day_scene.flr", "assets/background.flr"],
              builder: (BuildContext context, bool isWarm) {
        return FlareActor(
          BlocProvider.of<ThemeBloc>(context).flareAsset,
          fit: BoxFit.fill,
          animation: BlocProvider.of<ThemeBloc>(context).flareAnimation,
        );
      }),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}
