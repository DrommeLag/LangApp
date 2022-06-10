import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lang_app/core/inherit_provider.dart';
import 'package:lang_app/models/test.dart';
import 'package:lang_app/screen/levels/test/test_holder.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({Key? key}) : super(key: key);

  @override
  State<LevelPage> createState() => _LevelPage();
}

class _LevelPage extends State<LevelPage> {
  late Widget page;

  List<Test> testList = <Test>[];

  List<int> levels = Iterable<int>.generate(100).toList();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (testList.isEmpty) {
      _loadTests();
    }
    _updatePage();
  }

  _loadTests() async {
    testList =
        (await InheritedDataProvider.of(context)!.databaseService.getTests())
            .toList();
    _updatePage();
  }

  _updatePage() {
    setState(() {
      if (testList.isEmpty) {
        page = const CircularProgressIndicator();
      } else {
        page = _buildLevelsList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: page),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A67E9), Color(0xFF0B6CE5), Color(0xFF39A5B4)],
          stops: [0, 0.1, 1]
        ),
      ),
    );
  }

  Widget _buildLevelsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      reverse: true,
      itemCount: levels.length + 1,
      itemBuilder: listviewItemBuilder,
    );
  }

  Widget listviewItemBuilder(context, index) {
    if (index == 0) {
      return const SizedBox(
        height: 130,
      );
    } else {
      index -= 1;
      late TestStatus testStatus;
      if (index < 25) {
        testStatus = TestStatus.completed;
      } else if (index == 25) {
        testStatus = TestStatus.unlocked;
      } else {
        testStatus = TestStatus.locked;
      }
      bool isRight = index % 2 == 0;
      bool isLast = levels.length - 1 == index;

      List<Widget> rowWidgets = [
        SizedBox(
          height: 170,
          child: Align(
            alignment: Alignment.bottomRight,
            child: _Level(
              text: index.toString(),
              callback: () => log(index.toString()),
              testStatus: testStatus,
            ),
          ),
        ),
        Expanded(
            child: (!isLast)
                ? Padding(
                    padding: const EdgeInsets.all(35),
                    child: CustomPaint(
                        //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: _LineBetweenLevels(isRight: isRight),
                        size: const Size.fromHeight(100)))
                : const SizedBox()),
      ];

      return Row(
        children: (isRight) ? rowWidgets : rowWidgets.reversed.toList(),
      );
    }
  }
}

//Copy this CustomPainter code to the Bottom of the File
class _LineBetweenLevels extends CustomPainter {
  const _LineBetweenLevels({this.isRight = true});

  final bool isRight;
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    var coefBank = (isRight)
        ? const [0.1, 0.9, 0.96, 0.9, 1]
        : const [0.9, 0.1, 0.04, 0.9, 0];

    path.moveTo(coefBank[0] * size.width, size.height);
    path.lineTo(size.width * coefBank[1], size.height);
    path.cubicTo(
        //From
        size.width * coefBank[2],
        size.height,

        //Helping point for curve
        size.width * coefBank[4],
        size.height,

        //To
        size.width * coefBank[4],
        size.height * coefBank[3]);
    path.lineTo(size.width * coefBank[4], 0);

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    paint.color = Colors.white;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _Level extends StatelessWidget {
  const _Level(
      {Key? key,
      required this.text,
      required this.callback,
      required this.testStatus})
      : super(key: key);

  final String text;
  final Function() callback;

  final TestStatus testStatus;

  @override
  Widget build(BuildContext context) {
    late Color accordingStatus;
    late Widget icon;
    bool onlyUnlocked = false;
    TextStyle textStyle = Theme.of(context).textTheme.titleLarge!;
    double iconSize = 18;
    switch (testStatus) {
      case TestStatus.completed:
        accordingStatus = Theme.of(context).colorScheme.secondaryContainer;
        icon = Icon(
          Icons.check,
          color: Colors.green,
          size: iconSize,
        );
        textStyle = textStyle.copyWith(
            color: Theme.of(context).colorScheme.primaryContainer);
        break;
      case TestStatus.locked:
        icon = Icon(
          Icons.lock_outline,
          color: Theme.of(context).colorScheme.shadow,
          size: iconSize,
        );
        textStyle =
            textStyle.copyWith(color: Theme.of(context).colorScheme.secondary);
        accordingStatus = Theme.of(context).colorScheme.primaryContainer;
        break;
      case TestStatus.unlocked:
        onlyUnlocked = true;
        textStyle = textStyle.copyWith(
            color: Theme.of(context).colorScheme.primaryContainer);
        accordingStatus = Theme.of(context).colorScheme.secondary;
        break;
    }

    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            color: accordingStatus, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Center(
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
              if (!onlyUnlocked)
                Align(alignment: Alignment.topRight, child: icon)
            ],
          ),
        ),
      ),
    );
  }
}

enum TestStatus { unlocked, locked, completed }
