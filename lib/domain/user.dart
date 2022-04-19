import 'package:firebase_auth/firebase_auth.dart';

class MyUser {
  String? id;
  String? displayName;
  String? email;
  String? photoURL;
  MyUser.fromFirebase(User? user) {
    displayName = user?.displayName;
    email = user?.email;
    photoURL = user?.photoURL;
    id = user?.uid;
  }
}