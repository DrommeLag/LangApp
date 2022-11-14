import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestSummary extends StatelessWidget {
  const TestSummary(
      {Key? key,
      required this.questionsQuantity,
      required this.result,
      required this.callback,
      required this.onComplete})
      : super(key: key);

  final int result;
  final int questionsQuantity;

  final Function(int result) onComplete;
  final Function() callback;

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    AppLocalizations local = AppLocalizations.of(context)!;

    onComplete.call(result);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          local.testEnded,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          local.yourResult + ' $result/$questionsQuantity',
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(local.end),
        ),
      ],
    );
  }
}
