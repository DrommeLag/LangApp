import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/pages/auth/landing_page.dart';
import 'package:lang_app/pages/main-screen.dart';
import 'package:lang_app/pages/themes.dart';
import 'package:provider/provider.dart';

import 'domain/user.dart';
import 'login/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return StreamProvider<MyUser?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lang App',
        theme: AppTheme().light,
        darkTheme: AppTheme().dark,
        /*ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          //primarySwatch: Colors.deepOrange,
          textTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ),
        ),*/

          home: MainScreen(),

      ),
    );
  }
}