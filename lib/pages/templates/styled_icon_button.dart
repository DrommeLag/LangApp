import 'dart:developer';

import 'package:flutter/material.dart';

class StyledIconButton extends StatelessWidget {
  const StyledIconButton({required this.onPressed, this.selected, Key? key}) : super(key: key);

  // final Widget? child;
  final VoidCallback? onPressed;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/images/map_pointer.png'),
      onPressed: onPressed,
      splashColor: Colors.yellow,
    );

    // return ElevatedButton(
    //   onPressed: onPressed,
    //   style: ElevatedButton.styleFrom(
    //     elevation: 0,
    //     primary: selected == true ? Theme.of(context).colorScheme.secondary : Colors.transparent,
    //     textStyle:
    //     const TextStyle(
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    //   child: Column(
    //     children: [
    //       Image.asset('assets/images/map_pointer.png'),
    //       Visibility(
    //         visible: true,
    //         child: child!,
    //       ),
    //     ],
    //   ),
    // );
  }
}