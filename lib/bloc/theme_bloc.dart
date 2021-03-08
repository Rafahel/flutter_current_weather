import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:current_weather/appTheme.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(null);
  AppTheme theme = AppTheme.Night;
  String flareAsset = "assets/background.flr";
  String flareAnimation = "0";

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ChangeThemeEvent) {
      if (theme == AppTheme.Night) {
        theme = AppTheme.Day;
        flareAsset = "assets/day_scene.flr";
        flareAnimation = "rotate";
        yield DayThemeState();
      } else {
        theme = AppTheme.Night;
        flareAsset = "assets/background.flr";
        flareAnimation = "0";
        yield NightThemeState();
      }
    }
  }

  @override
  ThemeState get initialState => NightThemeState();
}
