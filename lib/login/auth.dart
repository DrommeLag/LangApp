import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/models/user.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  UserDescription? _userDescription;
  final _storage = const FlutterSecureStorage();

  UserDescription? get userDescription => _userDescription;

  //Return true if success
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      _userDescription = UserDescription.fromFirebase(user);
      bool out = _userDescription != null;
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
      await DatabaseService(uid: user?.uid)
          .updateUserData(name + ' ' + (surname ?? ''), email);
      _userDescription = UserDescription.fromFirebase(user);
      bool out = _userDescription != null;
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
    _userDescription = null;
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

  Stream<UserDescription?> get currentUser {
    return _fAuth.authStateChanges().map((User? user) =>
        user != null ? UserDescription.fromFirebase(user) : null);
  }

  bool get isLoggedIn => _userDescription != null;
}
