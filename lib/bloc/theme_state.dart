part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class NightThemeState extends ThemeState {}

class DayThemeState extends ThemeState {}
