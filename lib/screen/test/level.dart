import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/screen/test/test_page.dart';

import '../../core/database.dart';

class Level extends StatefulWidget {
  const Level({Key? key, required String this.levelName}) : super(key: key);

  final String levelName;

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    return FutureBuilder<DocumentSnapshot>(
      future: DatabaseService().testsCollection.doc(widget.levelName).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final DocumentSnapshot doc = snapshot.data!;
          final testsArray = doc["tests"];
          while (index < 3) {
            return TestPage(
                levelName: widget.levelName,
                question: testsArray[index]["question"],
                options: testsArray[index]["options"],
                right: testsArray[index]["correct"],
                callback: (right) => log(right.toString()));
            index++;
          }
          return Text("Some");
          index = 0;
        } else {
          return const Text('Its Error!');
        }
      },
    );
  }

// @override
// Widget build(BuildContext context) {
//   return StreamBuilder<QuerySnapshot>(
//     stream: DatabaseService().testsCollection.snapshots(),
//     builder: (context, snapshot){
//       if (!snapshot.hasData) {
//         return Test(snapshot.data!);
//       }
//       return Text("Loading");
//     },
//   );
// }
//
// Widget Test(QuerySnapshot<Object?> snapshot){
//   final ref = snapshot.docs[0];
//   final doc = ref["tests"];
//   return TestPage(options: doc["options"], right: doc["correct"], callback: (right)=> log(right.toString()));
// }
}
