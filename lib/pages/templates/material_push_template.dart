import 'package:flutter/material.dart';

materialPushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: ((context) => page)));
}
