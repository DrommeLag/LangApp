import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/core/inherit_provider.dart';
import 'package:lang_app/screen/main_screen.dart';
import 'package:lang_app/screen/themes.dart';
import 'package:lang_app/screen/user/auth/auth_page.dart';
import 'package:lang_app/screen/user/settings/notifications/notification_api.dart';
import 'package:lang_app/screen/user/settings/settings_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) :super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final AuthService authService;
  late final DatabaseService databaseService;

  @override
  initState() {
    super.initState();
    NotificationApi.init();
    listenNotifications();
    tz.initializeTimeZones();

    databaseService = DatabaseService();
    authService = AuthService();
    authService.loadLoginInfo();

    checkIfThereAreUserProgressRegistered();
  }

  checkIfThereAreUserProgressRegistered() async {
    databaseService.checkProgress(authService.uid);
  }

  @override
  Widget build(BuildContext context) {
    return InheritedDataProvider(
      authService: authService,
      databaseService: databaseService,
      child: ValueChangeObserver<int>(
        cacheKey: SettingsPage.keyDarkMode,
        defaultValue: ThemeMode.system.index,
        builder: (_, isDarkMode, __) => MaterialApp(
          //Localization
          localizationsDelegates: const [
            AppLocalizations.delegate, // Add this line
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
          home: authService.isLoggedIn
              ? const MainScreen()
              : const AuthPage(),
        ),
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
