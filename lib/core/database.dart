import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:lang_app/models/test.dart';

class DatabaseService {

  final CollectionReference newsCollection = FirebaseFirestore.instance.collection('news');

  final testRef = FirebaseFirestore.instance.collection('levels').withConverter<Test>(
    fromFirestore: ((snapshot, options) => Test.fromFirebase(snapshot.data()!)), 
    toFirestore: ((test, options) => test.toFirestore())
  );

  final testEpisodeRef = FirebaseFirestore.instance.collection('test_episodes').withConverter<List<String>>(
    fromFirestore: ((snapshot, options) => snapshot.data()!.values.map((e) => e as String).toList()),
    toFirestore: ((data, options) => data.asMap().map((key, value) => MapEntry(key.toString(), value)))
  );

  Future updateUserData(String? displayName, String? email) async{
    if(displayName != null){
      FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
    }
    if(email != null){
      FirebaseAuth.instance.currentUser!.updateEmail(email);
    }
    // return await usersCollection.doc(uid).set({
    //   'displayName': displayName,
    //   'email': email,
    //   'photo': null,
    // });
  }

  Future addNews(String? title, String? subtitle, String? url, Icon icon, String? id) async{
    return await newsCollection.doc(id).set({
      'title': title,
      'subtitle': subtitle,
      'url': url,
      'icon': icon,
    });
  }

  Future<Test> getTestData(String id) async{
    return testRef.doc(id).get().then((value) => value.data()!);
  }

  Future<List<String>> getTestEpisode(String id) async{
    return testEpisodeRef.doc(id).get().then((value) => value.data()!);
  }

  // Future updatePhotoURL(File? photo) async{
  //   return await usersColection.doc(uid).set({
  //     'photo': photo,
  //   });
  // }
}
