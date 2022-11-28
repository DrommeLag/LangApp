import 'package:flutter/material.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:lang_app/pages/templates/list_tile.dart';
import 'package:lang_app/pages/templates/material_push_template.dart';
import 'package:lang_app/pages/user/settings/account_settings_page.dart';
import 'package:lang_app/pages/user/settings/settings_page.dart';

import 'auth/auth_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//final _formKey = GlobalKey<FormState>();

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {



  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations local = AppLocalizations.of(context)!;

    Color iconColor = theme.primaryColor.withOpacity(0.5);
    Color textColor = theme.primaryColor;

    return ListView(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: backgroundGradient,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          height: 200,
        ),
        Column(
          children: [
            buildTile(Icons.account_circle_outlined,local.accountSettings,
                textColor, iconColor,
                callback: () =>
                    materialPushPage(context, const AccountSettingsPage())),
            buildTile(Icons.star_border_outlined,local.yourAchievements,
                textColor, iconColor),
            buildTile(Icons.settings_outlined, local.settings, textColor, iconColor,
                callback: () =>
                    materialPushPage(context, const SettingsPage())),
            buildTile(Icons.light_mode_outlined, local.changeTheme, textColor,
                iconColor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
              child:  Text(local.needHelp),
            ),
            buildTile(
                Icons.messenger_outline_sharp, local.help, textColor, iconColor),
            buildTile(
              Icons.favorite_border_outlined,
              local.fundUs,
              textColor,
              iconColor,
            ),
            buildTile(
              Icons.exit_to_app_outlined,
              local.logOut,
              theme.colorScheme.error,
              theme.colorScheme.error.withOpacity(0.5),
              callback: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthPage())),
            ),
          ],
        )
      ],
    );
  }

}
