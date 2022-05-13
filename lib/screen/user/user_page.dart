import 'package:flutter/material.dart';
import 'package:lang_app/login/auth.dart';
import 'package:lang_app/screen/user/settings/settings_page.dart';

import 'auth/auth_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  onPressed() {
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //   return const AuthPage();
    // }));
    // AuthService().logOut();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: onPressed(),
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(Colors.deepOrange),
        ),
        // color: Theme.of(context).primaryColor,
        child: Text(
          "Log out",
          style: Theme.of(context).primaryTextTheme.button,
        ),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SettingsPage();
          }));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.settings),
            Text(" Settings"),
          ],
        ),
      )
    ]);
  }
}