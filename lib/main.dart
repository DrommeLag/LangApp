import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/core/auth.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/core/inherit_provider.dart';
import 'package:lang_app/screen/main_screen.dart';
import 'package:lang_app/screen/themes.dart';
import 'package:lang_app/screen/user/auth/auth_page.dart';
import 'package:lang_app/screen/user/settings/notifications/NotificationApi.dart';
import 'package:lang_app/screen/user/settings/settings_page.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final AuthService authService;
  late final DatabaseService databaseService;

  @override
  Widget build(BuildContext context) {
    return InheritedDataProvider(
      authService: authService,
      databaseService: databaseService,
      child: ValueChangeObserver<int>(
        cacheKey: SettingsPage.keyDarkMode,
        defaultValue: ThemeMode.system.index,
        builder: (_, isDarkMode, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lang App',
          theme: AppTheme().light,
          darkTheme: AppTheme().dark,
          themeMode: ThemeMode.values[isDarkMode],
          home: authService.isLoggedIn
              ? const MainScreen()
              : const AuthPage(),
        ),
      ),
    );
  }

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  initState() {
    super.initState();
    initFirebase();
    NotificationApi.init();
    listenNotifications();
    tz.initializeTimeZones();

    databaseService = DatabaseService();
    authService = AuthService(databaseService);
    authService.loadLoginInfo();
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

