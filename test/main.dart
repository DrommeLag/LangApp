import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/core/inherit_provider.dart';
import 'package:lang_app/screen/levels/test/test_holder.dart';
import 'package:lang_app/screen/themes.dart';
import 'package:lang_app/screen/user/settings/settings_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Settings.init(cacheProvider: SharePreferenceCache());
  await Firebase.initializeApp();
  var databaseService = DatabaseService();
  var authService = AuthService();
  await authService.loadLoginInfo();

  var test = await databaseService.getTest('0');

  runApp(MaterialApp(
      home: InheritedDataProvider(
      authService: authService,
      databaseService: databaseService,
      child: ValueChangeObserver<int>(
        cacheKey: SettingsPage.keyDarkMode,
        defaultValue: ThemeMode.system.index,
        builder: (_, isDarkMode, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lang App',
          theme: AppTheme().light,
          darkTheme: AppTheme().light,
          themeMode: ThemeMode.values[isDarkMode],
          home: TestHolder(test: test,)
        ),
      ),
    ),
      // home: Scaffold(body: TestPage(options: const["ONE", "TWO",  "FOUR"], right: 1, callback: (right)=> log(right.toString()))),
      // theme: AppTheme().light,
    ));
}

