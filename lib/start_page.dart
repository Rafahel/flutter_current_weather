import 'package:current_weather/bloc/weather_bloc.dart';
import 'package:current_weather/search_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/weather_bloc.dart';
import 'city_list.dart';
import 'selected_weather.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 64),
          child: Column(
            children: [
              SearchComponent(),
              BlocListener<WeatherBloc, WeatherState>(
                listener: (context, state) async {
                  if (state is WeatherIsNotLoadedState) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.grey[900],
                          title: new Text(
                            "Erro",
                            style: TextStyle(color: Colors.white),
                          ),
                          content: new Text(
                            state.error,
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("Fechar",
                                  style: TextStyle(fontSize: 16)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (state is OpenSelectedWeatherScreenState) {
                    final event = await Navigator.pushNamed(
                      context,
                      SelectedWeatherScreen.routeName,
                      arguments: SelectedWeatherScreenArgs(
                        state.getWeather,
                      ),
                    );
                    BlocProvider.of<WeatherBloc>(context).add(event);
                  }
                },
                child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                  if (state is WeatherIsLoadingState ||
                      state is LoadingFromDbState)
                    return Padding(
                        padding: EdgeInsets.only(top: 64),
                        child: Center(child: CircularProgressIndicator()));
                  else {
                    return Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: CityListWidget(),
                        )
                      ],
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ],
    );
  }
}
