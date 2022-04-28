import 'package:flutter/foundation.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/domain/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<MyUser?> signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return MyUser.fromFirebase(user);
    }
    on FirebaseException catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  Future<MyUser?> registerWithEmailAndPassword(String name, String? surname, String email, String password) async {
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await user?.updateDisplayName(name);
      await user?.reload();
      await DatabaseService(uid: user?.uid).updateUserData(name+' ' +(surname ?? ''), email);
      return MyUser.fromFirebase(user);
    }
    on FirebaseException catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<MyUser?> get currentUser {
    return _fAuth.authStateChanges().map((User? user) => user != null ? MyUser.fromFirebase(user): null);
  }
}