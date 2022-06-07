import 'package:flutter/material.dart';

class TestSummary extends StatelessWidget {
  const TestSummary(
      {Key? key,
      required this.callback,
      required this.questionsQuantity,
      required this.result})
      : super(key: key);
  final Function() callback;
  final int result;
  final int questionsQuantity;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ти закінчив тест!!!',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Твій результат: $result/$questionsQuantity',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        const SizedBox(
          height: 40,
        ),
        MaterialButton(
          minWidth: 170,
          color: Theme.of(context).colorScheme.secondary,
          onPressed: callback,
          child: Text('Завершити'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
