import 'package:flutter/material.dart';

class AppTheme {
  AppTheme() {
    var light = ThemeData.from(
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: const Color(0xff0068C9),
            primaryContainer: const Color(0xFF193EBC),
            onPrimary: Colors.white,
            secondary: const Color(0xFFF2D84F),
            secondaryContainer: const Color(0xFFF8F49F),
            onSecondary: Colors.black,
            error: Colors.red[800]!,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.black,
            surface: const Color(0xFFFFE44D),
            onSurface: Colors.white,
            shadow: Colors.grey[500]!),
        textTheme: ThemeData.light().textTheme
            );
    this.light = _updateTheme(light);

    
    var dark = ThemeData.from(
        colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: const Color(0xff5b95fd),
            primaryContainer: const Color(0xFF0068C9),
            onPrimary: Colors.black,
            secondary: const Color(0xFfffff7e),
            secondaryContainer: const Color(0xFFF2d84c),
            onSecondary: Colors.black,
            error: Colors.red[800]!,
            onError: Colors.black,
            background: Colors.grey[900]!,
            onBackground: Colors.white,
            surface: const Color(0xFFbca70f),
            onSurface: Colors.white,
            shadow: Colors.grey[300]!),
        textTheme: ThemeData.dark().textTheme
            );
    this.dark = _updateTheme(dark);
  }
  late final ThemeData light;
  late final ThemeData dark;
  
  ThemeData _updateTheme(ThemeData theme) {
    return theme.copyWith(
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
        backgroundColor: theme.colorScheme.primary,
        selectedIconTheme: IconThemeData(color: theme.colorScheme.secondary),
      ),
      textTheme: theme.textTheme.copyWith(
        headlineSmall: theme.textTheme.headlineSmall!.copyWith(color: theme.colorScheme.primaryContainer),
      ),
      
    );
  }
  
  }

