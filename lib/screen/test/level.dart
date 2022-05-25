import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/screen/test/test_page.dart';

import '../../core/database.dart';

class Level extends StatefulWidget {
  const Level({Key? key}) : super(key: key);

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService().testsCollection.snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Text("No news.");
        return Center(
          child: _buildLevel(snapshot.data!),
        );
      },
    );
  }

  Widget _buildLevel(QuerySnapshot snapshot){
    return ListView.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index){
        final doc = snapshot.docs[index];
        return TestPage(options: doc["options"], right: doc["correct"], callback: (right)=> log(right.toString()));
      },
    );
  }
}
