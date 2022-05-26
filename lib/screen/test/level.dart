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
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService().testsCollection.snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return const Text("LOADING.");
        return Center(
          child: _buildLevel(snapshot.data!),
        );
      },
    );
  }

  Widget _buildLevel(QuerySnapshot snapshot){
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index){
        final doc = snapshot.docs[index];
        return TestPage(options: doc["options"], right: doc["correct"], callback: (right)=> log(right.toString()));
      },
    );
  }
}
