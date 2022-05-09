import 'package:firebase_auth/firebase_auth.dart';

class UserDescription {
  String? id;
  String? displayName;
  String? email;
  String? photoURL;
  UserDescription.fromFirebase(User? user) {
    displayName = user?.displayName;
    email = user?.email;
    photoURL = user?.photoURL;
    id = user?.uid;
  }
}