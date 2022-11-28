import 'dart:developer';

import 'package:flutter/material.dart';

class StyledElevatedButton extends StatelessWidget {
  const StyledElevatedButton({required this.onPressed, required this.child, this.selected, Key? key}) : super(key: key);

  final Widget? child;
  final VoidCallback? onPressed;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: selected == true ? Theme.of(context).colorScheme.secondary : Colors.transparent,
        minimumSize: const Size(120, 30),
        maximumSize: const Size(150, 50),
        textStyle:
            const TextStyle(
              fontWeight: FontWeight.bold,
        ),
      ),
      child: child,
    );
  }
}