import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lang_app/screen/test/test_page.dart';

class LevelPage extends StatefulWidget {
  LevelPage({Key? key, required dynamic arrayTests})
      : list = arrayTests.toList(),
        super(key: key);

  final List list;
  static int index = 0;

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  @override
  Widget build(BuildContext context) {
    switch (LevelPage.index) {
      case 0:
        return TestPage(levelName: "Рівень " + (LevelPage.index + 1).toString(),
            question: widget.list[0]["question"],
            options: widget.list[0]["options"],
            right: widget.list[0]["correct"],
            callback: (right) => log(right.toString()));
      case 1:
        return TestPage(levelName: "level" + (LevelPage.index + 1).toString(),
            question: widget.list[1]["question"],
            options: widget.list[1]["options"],
            right: widget.list[1]["correct"],
            callback: (right) => log(right.toString()));
    }
    return const Text("Завантаження...");
  }
}
