import 'package:flutter/material.dart';
import 'package:lang_app/core/inherit_provider.dart';
import 'package:lang_app/models/progress.dart';
import 'package:lang_app/models/test.dart';
import 'package:lang_app/screen/levels/context_onscreen_message.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({Key? key}) : super(key: key);

  @override
  State<LevelPage> createState() => _LevelPage();
}

class _Level extends StatelessWidget {
  final String text;

  final Function() callback;
  final TestStatus testStatus;

  const _Level(
      {Key? key,
      required this.text,
      required this.callback,
      required this.testStatus})
      : super(key: key);

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

class _LevelPage extends State<LevelPage> {
  Widget page = const CircularProgressIndicator();

  List<Test> testList = <Test>[];

  late UserProgress userProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: page),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A67E9), Color(0xFF0B6CE5), Color(0xFF39A5B4)],
            stops: [0, 0.1, 1]),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (testList.isEmpty) {
      _loadData();
    }
  }

  Widget _buildLevelsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      reverse: true,
      itemCount: testList.length + 1,
      itemBuilder: _listviewItemBuilder,
    );
  }

  Widget _listviewItemBuilder(context, index) {
    if (index == 0) {
      return const SizedBox(
        height: 130,
      );
    } else {
      index -= 1;
      late TestStatus testStatus;
      int testStatusInt = userProgress.testStatuses[index];
      if (testStatusInt == testList[index].taskIds.length) {
        testStatus = TestStatus.completed;
      } else if (testStatusInt != -1) {
        testStatus = TestStatus.unlocked;
      } else {
        testStatus = TestStatus.locked;
      }
      bool isRight = index % 2 == 0;
      bool isLast = testList.length - 1 == index;

      List<Widget> rowWidgets = [
        SizedBox(
          height: 170,
          child: Align(
            alignment: Alignment.bottomRight,
            child: _Level(
              text: index.toString(),
              callback: () {
                Navigator.push(
                  context,
                  ContextOnscreenMessage(
                      test: testList[index],
                      onComplete: (result) {
                        _updateResultAndUnlockNext(result, index);
                      },
                      testStatus: testStatus,
                      completed: userProgress.testStatuses[index]),
                );
              },
              testStatus: testStatus,
            ),
          ),
        ),
        Expanded(
            child: (!isLast)
                ? Padding(
                    padding: const EdgeInsets.all(35),
                    child: CustomPaint(
                        painter: _LineBetweenLevels(isRight: isRight),
                        size: const Size.fromHeight(100)))
                : const SizedBox()),
      ];

      return Row(
        children: (isRight) ? rowWidgets : rowWidgets.reversed.toList(),
      );
    }
  }

  _loadData() async {
    await InheritedDataProvider.of(context)!
        .databaseService
        .getProgress()
        .then((value) {
      userProgress = value;
    });
    testList =
        (await InheritedDataProvider.of(context)!.databaseService.getTests())
            .toList();
    if (testList.length != userProgress.testStatuses.length) {
      for (var i = testList.length;
          i <= userProgress.testStatuses.length;
          i++) {
        InheritedDataProvider.of(context)!
            .databaseService
            .updateProgress(i, -1);
      }
    }
    _updatePage();
  }

  _updatePage() {
    setState(() {
      page = _buildLevelsList();
    });
  }

  _updateResultAndUnlockNext(int result, int level) {
    if (userProgress.testStatuses[level] < result) {
      InheritedDataProvider.of(context)!
          .databaseService
          .updateProgress(level, result);
      userProgress.testStatuses[level] = result;
      if (result == testList[level].taskIds.length &&
          level < testList.length - 1 &&
          userProgress.testStatuses[level + 1] == -1) {
        InheritedDataProvider.of(context)!
            .databaseService
            .updateProgress(level + 1, 0);
        userProgress.testStatuses[level + 1] = 0;
        didChangeDependencies();
      }
    }
  }
}

class _LineBetweenLevels extends CustomPainter {
  final bool isRight;

  const _LineBetweenLevels({this.isRight = true});
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

enum TestStatus { unlocked, locked, completed }
