import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lang_app/login/auth.dart';
import 'package:lang_app/models/user.dart';
import 'package:provider/provider.dart';

class AuthData{

  static UserDescription? userDescription;
  static const _storage = FlutterSecureStorage();

  static final AuthService _authService = AuthService();

  static register({required String name, String? surname, required String email, required String password}) async{
    userDescription = await _authService.registerWithEmailAndPassword(
        name, surname, email.trim(), password.trim());
  }

  static login({required String email, required String password}) async{
    email = email.trim();
    userDescription = await _authService.signInWithEmailAndPassword(
        email, password);
    if(userDescription == null) {
      throw "Error in connection";
    }

    _storage.write(key: "login", value: email);
    _storage.write(key: "password", value: password);
  }

  static void singOut() {
    userDescription = null;
    _authService.logOut();
    _storage.deleteAll();
  }

  static Future<bool> loadLoginInfo() async{
    var login = await _storage.read(key: "login");
    var password = await _storage.read(key: "password");

    if(login == null || password == null){
      return false;
    }
    userDescription = await _authService.signInWithEmailAndPassword(login, password);
    if(userDescription == null){
      return false;
    }
    return true;
  }
}