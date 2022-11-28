import 'dart:developer';

import 'package:flutter/material.dart';

class StyledIconButton extends StatelessWidget {
  const StyledIconButton({required this.onPressed, required this.selected, Key? key}) : super(key: key);

  // final Widget? child;
  final VoidCallback? onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/images/map_pointer.png',
        fit: (selected) ? BoxFit.contain : BoxFit.none,
        width: 40,
        height: 40,
        color: (selected) ? Theme.of(context).colorScheme.secondary : Colors.lime[400],
      ),
      onPressed: onPressed,
      splashColor: Colors.yellow,
    );
  }
}