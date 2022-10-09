import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  AuthService._privateCons();

  static final AuthService _instance = AuthService._privateCons();

  factory AuthService(){
    return _instance;
  }

  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final _storage = const FlutterSecureStorage();
  UserCredential? _userCredential;


  String get uid => _userCredential!.user!.uid;

  //Return true if success
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _userCredential =
      await _fAuth.signInWithEmailAndPassword(email: email, password: password);
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
  Future<bool> registerWithEmailAndPassword(String name, String? surname,
      String email, String password) async {
    try {
      _userCredential = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _fAuth.currentUser?.reload();
      _fAuth.currentUser?.updateDisplayName("$name ${(surname ?? '')}");
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
    String? login = await _storage.read(key: "login");
    String? password = await _storage.read(key: "password");

    if (login == null || password == null) {
      return false;
    }
    return await signInWithEmailAndPassword(login, password);
  }

  updateDisplayName(String name) async {
    User? user = _fAuth.currentUser;
    if (user == null) {
      throw "Error! User isn't logged in!!";
    }
    await user.updateDisplayName(name);
    await user.reload();
  }

  bool get isLoggedIn => _fAuth.currentUser != null;

  User getUser() {
    return _fAuth.currentUser!;
  }

  Future<bool> updateEmail(String email) async {
    User? user = _fAuth.currentUser;
    if (user == null) {
      throw "Error! USer isn't logged in!";
    }
    try {
      if (!await loadLoginInfo()) {
        throw 'We are doomed!!';
      }
      await user.updateEmail(email);
      _storage.write(key: 'login', value: email);
      log(email);
      user.reload();
      return true;
    } on FirebaseAuthException catch (a) {
      log(a.message ?? 'Without');
      return false;
    }
  }

  Future<bool> updatePassword(String newPassword) async {
    User? user = _fAuth.currentUser;
    if (user == null) {
      throw "Error! User isn't logged in!";
    }
    try {
      if (!await loadLoginInfo()) {
        throw 'No user info';
      }
      await user.updatePassword(newPassword);
      user.reload();
      return true;
    } on FirebaseAuthException catch (a) {
      log(a.message ?? 'Without');
      return false;
    }
  }
}
