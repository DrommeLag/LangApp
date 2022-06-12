import 'package:flutter/material.dart';

Row highlightedText(
    {required String text,
    TextStyle? textStyle,
    TextStyle? highlightedStyle,
    required Function() onTap}) {
  var lines = text.split('|');
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(lines[0], style: textStyle),
      GestureDetector(
        onTap: onTap,
        child: Text(lines[1], style: highlightedStyle),
      ),
      Text(lines[2], style: textStyle),
    ],
  );
}
