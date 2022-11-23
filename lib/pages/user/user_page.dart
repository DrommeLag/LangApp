import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:lang_app/pages/templates/list_tile.dart';
import 'package:lang_app/pages/templates/material_push_template.dart';
import 'package:lang_app/pages/user/settings/account_settings_page.dart';
import 'package:lang_app/pages/user/settings/settings_page.dart';
import 'package:lang_app/pages/user/settings/theme/theme_page.dart';
import 'package:url_launcher/url_launcher.dart';

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
          child: FutureBuilder<String>(
            future: AccountSettingsPage.retrievePhoto(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text('Please wait its loading...'));
              } else {
                if (snapshot.hasError) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Column(mainAxisSize: MainAxisSize.min, children: const [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 100,
                          ),
                        ]),
                        Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(firebaseUser,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)))
                      ]);
                } else {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                '${snapshot.data}',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ))
                        ]),
                        Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(firebaseUser,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)))
                      ]);
                }
              }
            },
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
            buildTile(
              Icons.messenger_outline_sharp,
              'Допомога',
              textColor,
              iconColor,
              callback: () async {
                String email = Uri.encodeComponent("drommelagua@gmail.com");
                String subject = Uri.encodeComponent("Запит на допомогу");
                Uri mail = Uri.parse("mailto:$email?subject=$subject");
                if (await launchUrl(mail)) {
                  //open email app
                } else {
                  //don't open email app
                }
              },
            ),
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
