import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference newsCollection = FirebaseFirestore.instance.collection('news');
  final CollectionReference levelsCollection = FirebaseFirestore.instance.collection('levels');
  final CollectionReference testsCollection = FirebaseFirestore.instance.collection('some');

  Future updateUserData(String? displayName, String? email) async{
    return await usersCollection.doc(uid).set({
      'displayName': displayName,
      'email': email,
      'photo': null,
    });
  }

  Future addNews(String? title, String? subtitle, String? url, Icon icon, String? id) async{
    return await newsCollection.doc(id).set({
      'title': title,
      'subtitle': subtitle,
      'url': url,
      'icon': icon,
    });
  }

  // Future updatePhotoURL(File? photo) async{
  //   return await usersColection.doc(uid).set({
  //     'photo': photo,
  //   });
  // }
}