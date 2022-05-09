import 'package:flutter/foundation.dart';
import 'package:lang_app/core/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lang_app/models/user.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<UserDescription?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return UserDescription.fromFirebase(user);
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  Future<UserDescription?> registerWithEmailAndPassword(
      String name, String? surname, String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await user?.updateDisplayName(name);
      await user?.reload();
      await DatabaseService(uid: user?.uid)
          .updateUserData(name + ' ' + (surname ?? ''), email);
      return UserDescription.fromFirebase(user);
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<UserDescription?> get currentUser {
    return _fAuth.authStateChanges().map((User? user) =>
        user != null ? UserDescription.fromFirebase(user) : null);
  }
}
