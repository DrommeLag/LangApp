import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/core/inherit_provider.dart';
import 'package:lang_app/screen/test/test_holder.dart';
import 'package:lang_app/core/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: InheritedDataProvider.of(context)!.databaseService.testEpisodeRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text("Завантаження..."),
          );
        }
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
              return TestHolder(testEpisodeId: '0');
            }));
          },
          child: Text(doc["0"]),
          color: Colors.orangeAccent,
        );
      },
    );
  }
}
