import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/pages/user/settings/notifications/notifications_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const keyLanguage = "key-language";
  static const keyLocation = "key-location";
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
      onTap: () async {
        String email = Uri.encodeComponent("drommelagua@gmail.com");
        String subject = Uri.encodeComponent("Фідбек");
        Uri mail = Uri.parse("mailto:$email?subject=$subject");
        if (await launchUrl(mail)) {
          //open email app
        } else {
          //don't open email app
        }
      },
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
}
