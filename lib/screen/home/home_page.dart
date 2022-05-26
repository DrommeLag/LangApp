import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/screen/test/level.dart';
import 'package:lang_app/screen/test/test_page.dart';

import '../../core/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService().levelsCollection.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(
            child: Text("LOADING."),
          );
        return Center(
          child: _buildLevelsList(snapshot.data!),
        );
      },
    );
  }

  Widget _buildLevelsList(QuerySnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) {
        final doc = snapshot.docs[index];
        return MaterialButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Level(levelName: doc["name"]);
            }));
          },
          child: Text(doc["name"]),
          color: Colors.orangeAccent,
        );
      },
    );
  }
}
