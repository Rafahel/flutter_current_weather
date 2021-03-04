import 'package:flutter/material.dart';

enum AppTheme { Day, Night }

final appThemes = {
  AppTheme.Night: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      highlightColor: Colors.amber,
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
      cardTheme: CardTheme(
          color: Colors.deepPurple[800].withOpacity(0.4), elevation: 0)),
  AppTheme.Day: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      highlightColor: Colors.amber,
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
      cardTheme: CardTheme(color: Colors.white60, elevation: 2)),
};
