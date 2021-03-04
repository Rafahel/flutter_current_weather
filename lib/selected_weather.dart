import 'package:current_weather/bloc/theme_bloc.dart';
import 'package:current_weather/selected_weather_widget.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_bloc.dart';
import 'models/weather_model.dart';

class SelectedWeatherScreenArgs {
  final WeatherModel weather;
  SelectedWeatherScreenArgs(this.weather);
}

class SelectedWeatherScreen extends StatelessWidget {
  static const routeName = '/currentWeatherScreen';

  @override
  Widget build(BuildContext context) {
    final SelectedWeatherScreenArgs args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: Container(
            child: Stack(
          children: [
            Container(
              child: FlareActor(
                BlocProvider.of<ThemeBloc>(context).flareAsset,
                fit: BoxFit.fill,
                animation: BlocProvider.of<ThemeBloc>(context).flareAnimation,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Current Weather App',
                style: TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context, ResetWeatherEvent());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: SelectedWeatherWidget(args.weather),
            ),
          ],
        )),
      ),
    );
  }
}
