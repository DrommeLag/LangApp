import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/models/user.dart';
import 'package:lang_app/screen/main_screen.dart';
import 'package:lang_app/screen/themes.dart';
import 'package:lang_app/screen/user/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:lang_app/login/auth.dart';

import 'login/auth_data.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthData.loadLoginInfo();
  runApp(const MyApp());
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
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserDescription?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lang App',
        theme: AppTheme().light,
        darkTheme: AppTheme().dark,
          home: AuthData.userDescription != null ?
          const MainScreen(): const AuthPage(),
        //TODO add reading login data from saved storage

      ),
    );
  }
}
