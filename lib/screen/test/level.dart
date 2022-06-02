import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/screen/test/test_page.dart';

import '../../core/database.dart';
import 'level_page.dart';

class Level extends StatefulWidget {
  const Level({Key? key, required String this.levelName}) : super(key: key);

  final String levelName;

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: DatabaseService().testsCollection.doc(widget.levelName).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final DocumentSnapshot doc = snapshot.data!;
          final testsArray = doc["tests"];
          return LevelPage(arrayTests: testsArray);
        } else {
          return const Text('Its Error!');
        }
      },
    );
  }

}
