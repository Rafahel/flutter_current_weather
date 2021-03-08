import 'package:current_weather/bloc/theme_bloc.dart';
import 'package:current_weather/bloc/weather_bloc.dart';
import 'package:current_weather/data/repository.dart';
import 'package:current_weather/selected_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app_screen.dart';

void main() {
  initializeDateFormatting('pt_BR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(

        builder: (BuildContext context, state) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light
          ));
          return MaterialApp(
              routes: {
                SelectedWeatherScreen.routeName: (context) => SelectedWeatherScreen(),
              },
              title: 'Current Weather App',
              theme:
              ThemeData(primarySwatch: Colors.blue, highlightColor: Colors.amber),
              home: BlocProvider(
                create: (context) => WeatherBloc(Repository()),
                child: AppScreen(title: 'Current Weather'),
              ));
        },
      ),
    );
  }
}
