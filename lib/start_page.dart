import 'package:current_weather/bloc/weather_bloc.dart';
import 'package:current_weather/search_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/weather_bloc.dart';
import 'city_list.dart';
import 'current_weather.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    final TextEditingController textController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
              if (state is WeatherIsNotSearchedState) {
                return Column(
                  children: [
                    SearchComponent(),
                    Padding(
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: CityListWidget(),
                    )
                  ],
                );
              } else if (state is WeatherIsLoadingState ||
                  state is LoadingFromDbState)
                return Center(child: CircularProgressIndicator());
              else if (state is WeatherIsLoadedState)
                return CurrentWeatherWidget(state.getWeather);
              else if (state is WeatherIsNotLoadedState)
                return Text(
                  "Error",
                  style: TextStyle(color: Colors.white),
                );
            })
          ],
        ),
      ],
    );
  }
}
