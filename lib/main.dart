import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/login/auth.dart';
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
  var authService = AuthService();
  await authService.loadLoginInfo();
  runApp(MaterialApp(
    home: MyApp(authService),
  ));
}

class InheritedDataProvider extends InheritedWidget {
  final AuthService authService;

  const InheritedDataProvider({
    required Widget child,
    required this.authService,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) =>
      authService != oldWidget.authService;

  static InheritedDataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedDataProvider>();
  }
}

class MyApp extends StatefulWidget {
  final AuthService authService;

  const MyApp(this.authService, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return InheritedDataProvider(
      authService: widget.authService,
      child: ValueChangeObserver<int>(
        cacheKey: SettingsPage.keyDarkMode,
        defaultValue: ThemeMode.system.index,
        builder: (_, isDarkMode, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lang App',
          theme: AppTheme().light,
          darkTheme: AppTheme().dark,
          themeMode: ThemeMode.values[isDarkMode],
          home: widget.authService.isLoggedIn
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
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {}
}
