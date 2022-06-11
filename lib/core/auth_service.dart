import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {

  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final _storage = const FlutterSecureStorage();

  get uid => _fAuth.currentUser!.uid;

  //Return true if success
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
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
  Future<bool> registerWithEmailAndPassword(
      String name, String? surname, String email, String password) async {
    try {
      await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _fAuth.currentUser?.reload();
      _fAuth.currentUser?.updateDisplayName(name + ' ' + (surname ?? ''));
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

  Future updateDisplayName(String name) async{
    User? user = _fAuth.currentUser;
    if(user == null){
      throw "Error! User isn't logged in!!";
    }
    await user.updateDisplayName(name);
  }

  bool get isLoggedIn => _fAuth.currentUser != null;

  User getUser() {
    return _fAuth.currentUser!;
  }
}
