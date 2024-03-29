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
    ThemeData theme = Theme.of(context);
    AppLocalizations local = AppLocalizations.of(context)!;

    Color iconColor = theme.primaryColor.withOpacity(0.5);
    Color textColor = theme.primaryColor;

    return ListView(children: [
      AppBar(
        title: Text(local.profile),
        backgroundColor: theme.colorScheme.primaryContainer,
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
              return Center(child: Text(local.loading));
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
      Column(children: [
        buildTile(Icons.account_circle_outlined, local.accountSettings,
            textColor, iconColor,
            callback: () =>
                materialPushPage(context, const AccountSettingsPage())),
        buildTile(Icons.star_border_outlined, local.yourAchievements, textColor,
            iconColor),
        buildTile(Icons.settings_outlined, local.settings, textColor, iconColor,
            callback: () => materialPushPage(context, const SettingsPage())),
        buildTile(
            Icons.light_mode_outlined, local.changeTheme, textColor, iconColor,
            callback: () => materialPushPage(context, const ThemePage())),
      ]),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
        child: Text(local.needHelp),
      ),
      buildTile(
        Icons.messenger_outline_sharp,
        local.help,
        textColor,
        iconColor,
        callback: () async {
          String email = Uri.encodeComponent("drommelagua@gmail.com");
          String subject = Uri.encodeComponent(local.askHelp);
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
        local.fundUA,
        textColor,
        iconColor,
        callback: () async {
          await launchUrl(Uri.parse("https://savelife.in.ua/donate/"));
        },
      ),
      buildTile(
        Icons.exit_to_app_outlined,
        local.logOut,
        theme.colorScheme.error,
        theme.colorScheme.error.withOpacity(0.5),
        callback: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AuthPage())),
      ),
    ]);
  }
}
