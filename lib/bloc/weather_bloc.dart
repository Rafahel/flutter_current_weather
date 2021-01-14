import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:current_weather/data/repository.dart';
import 'package:current_weather/db/database.dart';
import 'package:current_weather/models/weather_model.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  Repository weatherRepo;
  List<WeatherModel> weatherList = List.empty();

  WeatherBloc(this.weatherRepo) : super() {
    db.getAllWeather().then((value) => weatherList = value);
  }

  DatabaseProvider db = DatabaseProvider.db;

  List<WeatherModel> get getWeatherList => weatherList;

  @override
  WeatherState get initialState => WeatherIsNotSearchedState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherIsLoadingState();

      try {
        WeatherModel weather = await weatherRepo.getWeather(event.cityName);
        yield WeatherIsLoadedState(weather);
      } catch (_) {
        yield WeatherIsNotLoadedState();
      }
    } else if (event is ResetWeatherEvent) {
      yield WeatherIsNotSearchedState();
    } else if (event is SaveWeatherEvent) {
      db.addWeather(event.getWeather);
      this.weatherList.add(event.getWeather);
    } else if (event is LoadFromDbEvent) {
      this.weatherList = await db.getAllWeather();
      yield WeatherIsNotSearchedState();
    }
  }
}
