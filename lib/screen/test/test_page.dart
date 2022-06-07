import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lang_app/models/test.dart';

import 'level_page.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key, required this.test, required this.callback}):super(key: key){
    var rightString = test.answers[0];
    test.answers.shuffle();
    right = test.answers.indexOf(rightString);
  }

  final Test test;
  late final int right;
  final Function(bool) callback;

  @override
  State<StatefulWidget> createState() => _TestPage();
}

class _TestPage extends State<TestPage> {

  @override
  didChangeDependencies(){
    super.didChangeDependencies();
    setState(() {
      
    choosed = -1;
    isTested = false;
    isRight = false;
    });
  }
  int choosed = -1;

  bool isTested = false;

  bool isRight = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
<<<<<<< HEAD
              widget.test.headline,
=======
              widget.levelName,
>>>>>>> origin/tests
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
<<<<<<< HEAD
            widget.test.question,
=======
            widget.question,
>>>>>>> origin/tests
            overflow: TextOverflow.visible,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(
            height: 80,
          ),
          ...buildOptions(context, widget.test.answers),
          ...<Widget>[
            Column(children: [
              const SizedBox(
                height: 50,
              ),
              Visibility(
                child: MaterialButton(
                    minWidth: 170,
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: (isTested)? () {
                      widget.callback(isRight);
                      LevelPage.index ++;
                    }: onCheckTap,
                    child: Text((isTested)?'Далі':'Перевірити'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                visible: choosed != -1,
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
              )
            ])
          ],
        ],
      );
  }

  choose(int position) {
    if (!isTested) {
      setState(() {
        choosed = position;
      });
    }
  }

  onCheckTap() {
    if (choosed != -1) {
      isRight = choosed == widget.right;
      setState(() {
        isTested = true;
      });
    }
  }

  Iterable<Widget> buildOptions(BuildContext context, List<String> list) {
    return list
        .asMap()
        .entries
        .map(
          // ignore: unnecessary_cast
          (entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              child: Container(
                height: 50,
                color: choosed != entry.key
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: choosed != entry.key
                          ? Theme.of(context).colorScheme.shadow
                          : Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      entry.value,
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                    const Spacer(),
                    Visibility(
                        visible: isTested && entry.key == choosed,
                        child: Icon(
                          entry.key == widget.right
                              ? Icons.check
                              : Icons.sunny_snowing,
                          color: (entry.key != widget.right)
                              ? Theme.of(context).colorScheme.error
                              : Colors.green,
                        ))
                  ],
                ),
              ),
              onTap: () => choose(entry.key),
            ),
          ) as Widget,
        );
  }
}
