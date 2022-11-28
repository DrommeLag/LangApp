import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/core/database_service.dart';
import 'package:lang_app/pages/main_screen.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:lang_app/pages/themes.dart';
import 'package:lang_app/pages/user/auth/auth_page.dart';
import 'package:lang_app/pages/user/settings/notifications/notification_api.dart';
import 'package:lang_app/pages/user/settings/settings_page.dart';
import 'package:timezone/data/latest.dart' as tz;

main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    initFirestore();
    super.initState();
    NotificationApi.init();
    listenNotifications();
    tz.initializeTimeZones();
  }

  initFirestore() async {
    DatabaseService databaseService = DatabaseService();
    AuthService authService = AuthService();

    bool loggedIn = await authService.loadLoginInfo();
    if (loggedIn) {
      databaseService.checkProgress(authService.uid);
    }

    setState(() {
      home = loggedIn ? const MainScreen() : const AuthPage();
    });
  }

  Widget home = Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(gradient: backgroundGradient),
      child: const CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return ValueChangeObserver<int>(
      cacheKey: SettingsPage.keyDarkMode,
      defaultValue: ThemeMode.system.index,
      builder: (_, isDarkMode, __) => MaterialApp(
        //Localization
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('uk', ''), // Ukrainian
        ],
        debugShowCheckedModeBanner: false,
        title: 'LangApp',
        theme: AppTheme().light,
        darkTheme: AppTheme().dark,
        themeMode: ThemeMode.values[isDarkMode],
        home: home,
      ),
    );
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const MainScreen(),
    // ));
  }
}
