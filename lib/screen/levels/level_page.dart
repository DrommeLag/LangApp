import 'dart:developer';

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
    return Center(child: page);
  }

  Widget _buildLevelsList() {
    return  ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            reverse: true,
            itemCount: levels.length + 1,
            itemBuilder: listviewItemBuilder,
            );
  }
  Widget listviewItemBuilder(context, index) {
    if (index == 0) {
      return const SizedBox(
        height: 150,
      );
    } else {
      index -= 1;

      bool isRight = index % 2 == 0;
      bool isLast = levels.length - 1 == index;

      List<Widget> rowWidgets = [
        SizedBox(
            height: 150,
            child: Align(
                alignment: Alignment.bottomRight,
                child:
                    Level(text: index.toString(), callback: () => log(index.toString())))),
        Expanded(
            child: (!isLast)
                ? Padding(
                    padding: const EdgeInsets.all(25).copyWith(top: 15),
                    child: CustomPaint(
                        //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: LineBetweenLevels(isRight: isRight),
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
class LineBetweenLevels extends CustomPainter {
  const LineBetweenLevels({this.isRight = true});

  final bool isRight;
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    var coefBank =
        (isRight) ? const [0, 0.9, 0.96, 0.9, 1] : const [1, 0.1, 0.04, 0.9, 0];

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
      ..strokeWidth = 5;
    paint.color = Color.fromARGB(255, 80, 80, 80);
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Level extends StatelessWidget {
  const Level({Key? key, required this.text, required this.callback})
      : super(key: key);

  final String text;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow,
              border: Border.all(color: Colors.blueAccent, width: 4),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          width: 50,
          height: 50,
          child: Center(
            child: Text(text),
          )),
    );
  }
}
