import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lang_app/screen/test/level.dart';
import 'package:lang_app/screen/test/test_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Level();
                  }));
                },
                child: const Text("Level1"),
                color: Colors.orangeAccent,
              ),
            ],
          )
      ),
    );
  }
}