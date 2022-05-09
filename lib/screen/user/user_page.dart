import 'package:flutter/material.dart';

import 'auth/auth.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  onPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const AuthPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
      tag: 'user-settings',
      child: Center(
        child: MaterialButton(
          onPressed: onPressed,
          color: Theme.of(context).primaryColor,
          child:  Text(
            'exit',
            style: Theme.of(context).primaryTextTheme.button,
          ),
        ),
      ),
    );
  }
}
