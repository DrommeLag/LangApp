import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lang_app/domain/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference usersColection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String? displayName, String? email) async{
    return await usersColection.doc(uid).set({
      'displayName': displayName,
      'email': email,
      'photo': null,
    });
  }

  // Future updatePhotoURL(File? photo) async{
  //   return await usersColection.doc(uid).set({
  //     'photo': photo,
  //   });
  // }
}