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
        child: Text(lines[1], style: highlightedStyle),
        onTap: onTap,
      ),
      Text(lines[2], style: textStyle),
    ],
  );
}
