import 'package:flutter/material.dart';
import 'package:lang_app/screen/templates/gradients.dart';
import 'package:lang_app/screen/templates/list_tile.dart';
import 'package:lang_app/screen/templates/material_push_template.dart';
import 'package:lang_app/screen/user/settings/account_settings_page.dart';
import 'package:lang_app/screen/user/settings/settings_page.dart';

import 'auth/auth_page.dart';

//final _formKey = GlobalKey<FormState>();

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).primaryColorLight;
    Color textColor = Theme.of(context).primaryColor;

    return ListView(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: backgroundGradient,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          height: 200,
        ),
        ListView(
          shrinkWrap: true,
          children: [
            buildTile(Icons.account_circle_outlined, 'Account settings',
                textColor, iconColor,
                callback: () =>
                    materialPushPage(context, const AccountSettingsPage())),
            buildTile(Icons.star_border_outlined, 'Your achiebements',
                textColor, iconColor),
            buildTile(Icons.settings_outlined, 'Settings', textColor, iconColor,
                callback: () =>
                    materialPushPage(context, const SettingsPage())),
            buildTile(Icons.light_mode_outlined, 'Change theme', textColor,
                iconColor),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Needs help?'),
            ),
            buildTile(
                Icons.messenger_outline_sharp, 'Help', textColor, iconColor),
            buildTile(
              Icons.favorite_border_outlined,
              'Help us',
              textColor,
              iconColor,
            ),
            buildTile(
              Icons.exit_to_app_outlined,
              'Exit',
              Theme.of(context).colorScheme.error,
              Theme.of(context).colorScheme.error.withOpacity(0.5),
              callback: () => materialPushPage(context, const AuthPage()),
            ),
          ],
        )
      ],
    );
  }

}
