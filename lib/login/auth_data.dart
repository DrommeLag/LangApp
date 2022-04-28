import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lang_app/domain/user.dart';
import 'package:lang_app/login/auth.dart';

class AuthData{
  static UserDescription? userDescription;

  static final AuthService _authService = AuthService();

  static register({required String name, String? surname, required String email, required String password}) async{
    userDescription = await _authService.registerWithEmailAndPassword(
        name, surname, email.trim(), password.trim());
  }

  static login({required String email, required String password}) async{
    userDescription = await _authService.signInWithEmailAndPassword(
        email.trim(), password);
    if(userDescription == null) {
      throw "Error in connection";
    }
  }

  static void singOut() {
    userDescription = null;
    _authService.logOut();
  }
}