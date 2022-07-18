import 'package:flutter/material.dart';

Widget buildTile(
        IconData icon, String text, Color textColor, Color iconColor,
        {Function()? callback}) {
      return ListTile(
        leading: Icon(icon),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        textColor: textColor,
        iconColor: iconColor,
        onTap: callback,
      );
    }
