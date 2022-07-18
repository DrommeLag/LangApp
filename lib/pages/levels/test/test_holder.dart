import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lang_app/core/database.dart';
import 'package:lang_app/models/task.dart';
import 'package:lang_app/models/test.dart';
import 'package:lang_app/pages/levels/test/test_page.dart';
import 'package:lang_app/pages/levels/test/test_summary.dart';

class TestHolder extends StatefulWidget {
  TestHolder({Key? key, required this.test, required this.onComplete})
      : super(key: key);

  final Test test;
  final _key = GlobalKey();

  final Function(int result) onComplete;

  @override
  State<StatefulWidget> createState() => _TestHolder();
}

class _TestHolder extends State<TestHolder> {
  bool inited = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!inited) {
      initTests();
    }
  }

  int targetSize = -1;

  int now = 0;

  int result = 0;

  List<Future<Task>> tasks = [];

  late Task activeTask;

  initTests() async {
    pageContent = const CircularProgressIndicator();
    for (String curentId in widget.test.taskIds) {
      tasks.add(
          DatabaseService().getTask(curentId));
    }
    targetSize = tasks.length;
    prepareTest();
  }

  Future prepareTest() async {
    pageContent = const CircularProgressIndicator();

    if (now >= targetSize || tasks.isEmpty) {
      log("Something bad happened here in test holder");
      setState(() {
        pageContent = TestSummary(
            callback: (() => Navigator.pop(context)),
            questionsQuantity: targetSize,
            result: result,
            onComplete: widget.onComplete);
      });
    } else {
      activeTask = await tasks[now];

      setState(() {
        pageContent = TestPage(
            key: widget._key,
            task: activeTask,
            callback: ((answer) {
              result += answer ? 1 : 0;
              prepareTest();
            }));
        widget._key.currentState?.didChangeDependencies();
      });

      now++;
    }
  }

  late Widget pageContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color.fromRGBO(10, 103, 233, 1),
          Color.fromRGBO(11, 108, 229, 1),
          Color.fromRGBO(57, 165, 180, 1),
        ],
      )),
      child: pageContent,
    );
  }
}
