import 'dart:developer';

import 'package:flutter/material.dart';

import 'level_page.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key, required this.levelName, required this.question, required List<dynamic> options, required this.right, required this.callback})
      : list = options.map((e) => e.toString()).toList(),
        super(key: key);

  final String question;
  final String levelName;
  final int right;
  final List<String> list;
  final int index = 0;

  final Function(bool) callback;

  @override
  State<StatefulWidget> createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  int choosed = -1;

  bool isTested = false;

  bool isRight = false;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              widget.levelName,
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
            widget.question,
            overflow: TextOverflow.visible,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(
            height: 80,
          ),
          ...buildOptions(context, widget.list),
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
      ),
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

  List<Widget> buildOptions(BuildContext context, List<String> list) {
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
                      //style: Theme.of(context).textTheme.headline3
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
        )
        .toList();
  }
}
