import 'dart:developer';

import 'package:flutter/material.dart';

class StyledElevatedButton extends StatelessWidget {
  const StyledElevatedButton({required this.onPressed, required this.child, Key? key}) : super(key: key);

  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: Colors.transparent,
        maximumSize: const Size(120, 40),
        textStyle:
            const TextStyle(
              fontWeight: FontWeight.bold,
        ),
      ),
      child: child,
    );
  }
}