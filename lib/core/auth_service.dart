import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lang_app/core/database.dart';

class AuthService {
  AuthService(this.databaseService);

  final DatabaseService databaseService;
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final _storage = const FlutterSecureStorage();

  //Return true if success
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      bool out = _fAuth.currentUser != null;
      if (out) {
        _storage.write(key: "login", value: email);
        _storage.write(key: "password", value: password);
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return false;
    }
  }

  //Return true if success
  Future<bool> registerWithEmailAndPassword(
      String name, String? surname, String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await user?.updateDisplayName(name);
      await user?.reload();
      await databaseService
          .updateUserData(displayName: name + ' ' + (surname ?? ''), email:email);
      bool out = _fAuth.currentUser != null;
      if (out) {
        _storage.write(key: "login", value: email);
        _storage.write(key: "password", value: password);
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return false;
    }
  }

  logOut() {
    _fAuth.signOut();
    _storage.deleteAll();
  }

  //Return true if success
  Future<bool> loadLoginInfo() async {
    var login = await _storage.read(key: "login");
    var password = await _storage.read(key: "password");

    if (login == null || password == null) {
      return false;
    }
    return await signInWithEmailAndPassword(login, password);
  }

  bool get isLoggedIn => _fAuth.currentUser != null;
}
