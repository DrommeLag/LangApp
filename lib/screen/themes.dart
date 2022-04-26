import 'package:flutter/material.dart';

class AppTheme{
  final ThemeData light = ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange));
  final ThemeData dark = ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, brightness: Brightness.dark));
}