import 'dart:io';

import 'package:current_weather/start_page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_background.dart';
import 'bloc/theme_bloc.dart';
import 'bloc/weather_bloc.dart';

class AppScreen extends StatelessWidget {
  final String title;
  static String flareAnimation = "switch_night";
  AppScreen({Key key, this.title}) : super(key: key);

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
                  title,
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
                      flareAnimation = (flareAnimation == "switch_night")
                          ? "switch_day"
                          : "switch_night";
                      BlocProvider.of<ThemeBloc>(context).add(ChangeThemeEvent());
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