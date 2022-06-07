import 'package:flutter/material.dart';

class AppTheme {
  AppTheme() {
    var light = ThemeData.from(
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: const Color.fromRGBO(23, 117, 209, 1),
            onPrimary: Colors.white,
            secondary: const Color.fromRGBO(255, 227, 77, 1),
            onSecondary: Colors.black,
            error: Colors.red[800]!,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.black,
            surface: const Color(0xFFFFE44D),
            onSurface: Colors.white,
            shadow: Colors.grey),
        textTheme: ThemeData.light().textTheme
            );
    light = light.copyWith(
      bottomNavigationBarTheme: light.bottomNavigationBarTheme.copyWith(
        backgroundColor: light.colorScheme.primary,
        selectedIconTheme: IconThemeData(color: light.colorScheme.secondary),
      ),
    );
    this.light = light;
  }
  late final ThemeData light;
  final ThemeData dark = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange, brightness: Brightness.dark));
}
