import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/models/test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var databaseService = DatabaseService();
  var authService = AuthService(databaseService);
  authService.signInWithEmailAndPassword('nz54ds@gmail.com', 'password');

  Test a = Test(name: "Тест 1", description: "Вчися на фільмах", taskIds: ['0', '1','2','3']);
  databaseService.setTest(a, '0');
}
