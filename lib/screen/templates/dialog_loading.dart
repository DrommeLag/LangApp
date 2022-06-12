import 'package:flutter/material.dart';

class DialogLoadingIndicator {
  final BuildContext context;
  DialogLoadingIndicator(this.context) {
    showDialog(
        context: context,
        builder: (context) => Container(
            alignment: Alignment.center,
            color: Colors.black38,
            child: const CircularProgressIndicator()));
  }

  pop() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
