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
  Set<WeatherModel> weatherList = Set();

  WeatherBloc(this.weatherRepo) : super() {
    this.add(LoadFromDbEvent());
  }

  DatabaseProvider db = DatabaseProvider.db;

  List<WeatherModel> get getWeatherList =>
      weatherList.toList()..sort((a, b) => a.cityName.compareTo(b.cityName));

  @override
  WeatherState get initialState => WeatherIsLoadingState();

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
      this.weatherList.addAll(await db.getAllWeather());
      yield WeatherIsNotSearchedState();
    }
  }
}
