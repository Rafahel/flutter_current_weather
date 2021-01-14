part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherIsNotSearchedState extends WeatherState {}

class LoadingFromDbState extends WeatherState {}

class LoadedFromDbState extends WeatherState {}

class WeatherIsLoadingState extends WeatherState {}

class WeatherIsLoadedState extends WeatherState {
  final _weather;

  WeatherIsLoadedState(this._weather);

  WeatherModel get getWeather => _weather;

  @override
  List<Object> get props => [_weather];
}

class WeatherIsNotLoadedState extends WeatherState {}