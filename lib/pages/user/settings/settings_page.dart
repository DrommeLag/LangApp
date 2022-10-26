import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/pages/user/settings/notifications/notifications_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const keyLanguage = "key-language";
  static const keyLocation = "key-location";
  static const keyDarkMode = "key-dark-mode";
  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(local.userSettings),
        //backgroundColor: Colors.orangeAccent,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SettingsGroup(title:local.apperience, children: [
              buildDarkMode(local),
            ]),
            SettingsGroup(
              title: local.general,
              children: <Widget>[
                // buildAccountSettings(),
                const NotificationsPage(),
                buildLanguage(local),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SettingsGroup(
              title: local.feedback,
              subtitle: "",
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                buildSendFeedback(local),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildAccountSettings() {
  //   return SimpleSettingsTile(
  //     title: "Account Settings",
  //     leading: const Icon(Icons.account_circle),
  //     onTap: () {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return const UserPage();
  //       }));
  //     },
  //   );
  // }

  Widget buildSendFeedback(AppLocalizations local) {
    return SimpleSettingsTile(
      title: local.sendFeedback,
      subtitle: "",
      leading: const Icon(Icons.thumb_up),
      onTap: () {},
    );
  }


  Widget buildLanguage(AppLocalizations local) {
    return DropDownSettingsTile(
      settingKey: SettingsPage.keyLanguage,
      title: local.language,
      selected: 1,
      values: <int, String>{
        1:  local.uk_ua,
      },
      onChange: (language) {},
    );
  }


  Widget buildDarkMode(AppLocalizations local) {
    return RadioModalSettingsTile(
        title: local.chooseTheme,
        settingKey: SettingsPage.keyDarkMode,
        selected:
            Settings.getValue(SettingsPage.keyDarkMode, defaultValue: ThemeMode.system.index)!,
        values: <int, String>{
          ThemeMode.system.index: local.systemTheme,
          ThemeMode.dark.index: local.darkTheme,
          ThemeMode.light.index: local.lightTheme,
        });
  }
}
