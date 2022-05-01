import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/models/user.dart';
import 'package:lang_app/screen/home/home_page.dart';
import 'package:lang_app/screen/main_screen.dart';
import 'package:lang_app/screen/themes.dart';
import 'package:lang_app/screen/user/auth/auth.dart';
import 'package:lang_app/screen/user/settings/notifications/NotificationApi.dart';
import 'package:lang_app/screen/user/settings/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:lang_app/login/auth.dart';
import 'login/auth_data.dart';

void main() async{
  await Settings.init(cacheProvider: SharePreferenceCache());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthData.loadLoginInfo();
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

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications(){
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload){
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const MainScreen(),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserDescription?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: ValueChangeObserver<bool>(
        cacheKey: SettingsPage.keyDarkMode,
        defaultValue: true,
        builder: (_, isDarkMode, __) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Lang App',
            theme: isDarkMode
            ? AppTheme().dark
            : AppTheme().light,
            home: AuthData.userDescription != null ?
            const MainScreen(): const AuthPage(),
            //TODO add reading login data from saved storage
          ),
      ),
    );
  }
}
