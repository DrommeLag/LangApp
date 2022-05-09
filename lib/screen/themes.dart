import 'package:flutter/material.dart';

class AppTheme{
  AppTheme(){
    var light = ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen, secondary: Colors.orange));
    light = light.copyWith(
      bottomNavigationBarTheme: light.bottomNavigationBarTheme.copyWith(
        backgroundColor: light.colorScheme.primary,
        selectedIconTheme: IconThemeData(color: light.colorScheme.secondary),
      ),
    );
    this.light = light;
  }
  late final ThemeData light;
  final ThemeData dark = ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, brightness: Brightness.dark));
}