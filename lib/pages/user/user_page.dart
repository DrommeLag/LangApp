import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:lang_app/pages/templates/list_tile.dart';
import 'package:lang_app/pages/templates/material_push_template.dart';
import 'package:lang_app/pages/user/settings/account_settings_page.dart';
import 'package:lang_app/pages/user/settings/settings_page.dart';
import 'package:lang_app/pages/user/settings/theme/theme_page.dart';

import 'auth/auth_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//final _formKey = GlobalKey<FormState>();

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  final String firebaseUser =
      FirebaseAuth.instance.currentUser!.displayName ?? 'Unknown user';
  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).primaryColor.withOpacity(0.5);
    Color textColor = Theme.of(context).primaryColor;

    return ListView(
      children: [
        AppBar(
          title: const Text("Профіль"),
          backgroundColor: const Color(0xff0A67E9),
          elevation: 0,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: backgroundGradient,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          height: 200,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(children: [
              const Icon(
                Icons.person,
                color: Colors.white,
                size: 80,
              ),
              Text(firebaseUser, textAlign: TextAlign.center)
            ]),
          ),
        ),
        Column(
          children: [
            buildTile(Icons.account_circle_outlined, 'Налаштування акаунта',
                textColor, iconColor,
                callback: () =>
                    materialPushPage(context, const AccountSettingsPage())),
            buildTile(Icons.star_border_outlined, 'Твої досягнення', textColor,
                iconColor),
            buildTile(
                Icons.settings_outlined, 'Налаштування', textColor, iconColor,
                callback: () =>
                    materialPushPage(context, const SettingsPage())),
            buildTile(
                Icons.light_mode_outlined, 'Змінити тему', textColor, iconColor,
                callback: () => materialPushPage(context, const ThemePage())),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
              child: const Text('Потрібна допомога?'),
            ),
            buildTile(Icons.messenger_outline_sharp, 'Допомога', textColor,
                iconColor),
            buildTile(
              Icons.favorite_border_outlined,
              'Підтримай нас',
              textColor,
              iconColor,
            ),
            buildTile(
              Icons.exit_to_app_outlined,
              'Вийти',
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
