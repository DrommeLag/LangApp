import 'package:flutter/material.dart';
import 'package:lang_app/models/test.dart';
import 'package:lang_app/screen/levels/level_page.dart';
import 'package:lang_app/screen/levels/test/test_holder.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ContextOnscreenMessage extends ModalRoute<void> {
  final Test test;

  final Function(int) onComplete;

  final TestStatus testStatus;

  final double progress;

  ContextOnscreenMessage(
      {required this.test,
      required this.onComplete,
      required this.testStatus,
      required int completed})
      : progress = (completed == -1) ? 0 : completed / test.taskIds.length;

  @override
  Color? get barrierColor => Colors.black26;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    late List<Widget> status;
    TextStyle nextButtonTextStyle = Theme.of(context).textTheme.titleLarge!;
    Function()? callback = () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: ((context) =>
                TestHolder(test: test, onComplete: onComplete))));

    if (testStatus == TestStatus.locked) {
      nextButtonTextStyle = nextButtonTextStyle.copyWith(
          color: Theme.of(context).colorScheme.shadow);
      callback = null;
    }

    TextStyle textStyleForStatus = Theme.of(context).textTheme.titleSmall!;
    switch (testStatus) {
      case TestStatus.locked:
        status = [
          Icon(Icons.lock,
              color: Theme.of(context).colorScheme.shadow,
              size: textStyleForStatus.fontSize),
          Text(
            'Закрито',
            style: textStyleForStatus.copyWith(
                color: Theme.of(context).colorScheme.shadow),
          )
        ];
        break;
      case TestStatus.completed:
        status = [
          Icon(
            Icons.check_rounded,
            color: Colors.green,
            size: textStyleForStatus.fontSize,
          ),
          Text(
            'Завершено',
            style: textStyleForStatus,
          )
        ];
        break;
      case TestStatus.unlocked:
        status = [];
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      test.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                        visible: testStatus != TestStatus.unlocked,
                        maintainSize: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: status,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Опис: ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: test.description,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Прогрес:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LinearPercentIndicator(
                      percent: progress,
                      lineHeight: 15,
                      barRadius: const Radius.circular(10),
                      progressColor: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).primaryColorLight,
                      center: Text("${(progress * 100).toString()}%"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          alignment: Alignment.center,
                          color: Theme.of(context).colorScheme.shadow,
                          child: Text('Назад',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: callback,
                        child: Container(
                          alignment: Alignment.center,
                          color: Theme.of(context).colorScheme.secondary,
                          child: Text(
                            'Почати',
                            style: nextButtonTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
