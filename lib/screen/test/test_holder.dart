import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lang_app/core/inherit_provider.dart';
import 'package:lang_app/models/test.dart';
import 'package:lang_app/screen/test/test_page.dart';
import 'package:lang_app/screen/test/test_summary.dart';

class TestHolder extends StatefulWidget {
  TestHolder({Key? key, required this.testEpisodeId}) : super(key: key);

  final String testEpisodeId;
  final _key = GlobalKey();

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

  List<Future<Test>> test = [];

  late Test active;

  initTests() async {
    pageContent = const CircularProgressIndicator();
    await InheritedDataProvider.of(context)!
        .databaseService
        .getTestEpisode(widget.testEpisodeId)
        .then((value) {
      for (String id in value) {
        test.add(
            InheritedDataProvider.of(context)!.databaseService.getTestData(id));
      }
      targetSize = value.length;
    });
    prepareTest();
  }

  Future prepareTest() async {
    pageContent = const CircularProgressIndicator();

    if (now >= targetSize || test.isEmpty) {
      log("Something bad happened here in test holder");
      setState(() {
        pageContent = TestSummary(
            callback: (() => Navigator.pop(context)),
            questionsQuantity: targetSize,
            result: result);
      });
    } else {
      active = await test[now];

      setState(() {
        pageContent = TestPage(
            key: widget._key,
            test: active,
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
