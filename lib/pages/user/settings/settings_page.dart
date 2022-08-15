import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/pages/user/settings/notifications/notifications_page.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Налаштування користувача"),
        //backgroundColor: Colors.orangeAccent,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SettingsGroup(title: "Вигляд", children: [
              buildDarkMode(),
            ]),
            SettingsGroup(
              title: "Загальні",
              children: <Widget>[
                // buildAccountSettings(),
                const NotificationsPage(),
                buildLanguage(context),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SettingsGroup(
              title: "Зворотний зв'язок",
              subtitle: "",
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                buildSendFeedback(context),
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

  Widget buildSendFeedback(BuildContext context) {
    return SimpleSettingsTile(
      title: "Надіслати фідбек",
      subtitle: "",
      leading: const Icon(Icons.thumb_up),
      onTap: () {},
    );
  }


  Widget buildLanguage(BuildContext context) {
    return DropDownSettingsTile(
      settingKey: SettingsPage.keyLanguage,
      title: "Мова",
      selected: 1,
      values: const <int, String>{
        1: "Українська",
        2: "English",
        3: "Spanish",
        4: "French",
      },
      onChange: (language) {},
    );
  }


  Widget buildDarkMode() {
    return RadioModalSettingsTile(
        title: 'Тема додатку',
        settingKey: SettingsPage.keyDarkMode,
        selected:
            Settings.getValue(SettingsPage.keyDarkMode, defaultValue: ThemeMode.system.index),
        values: <int, String>{
          ThemeMode.system.index: 'Тема системи',
          ThemeMode.dark.index: 'Темна тема',
          ThemeMode.light.index: 'Світла тема',
        });
  }
}
