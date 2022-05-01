import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/screen/user/auth/auth.dart';
import 'package:lang_app/screen/user/settings/notifications/notifications_page.dart';
import 'package:lang_app/screen/user/user_page.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({Key? key}) : super(key: key);

  static const keyLanguage = "key-language";
  static const keyLocation = "key-location";
  static const keyDarkMode = "key-dark-mode";
  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User settings"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SafeArea(
          child: ListView(
            children: [
              buildDarkMode(),
              SettingsGroup(
                title: "General",
                children: <Widget>[
                  // buildAccountSettings(),
                  NotificationsPage(),
                  buildLanguage(context),
                  buildRegion(context),
                ],
              ),
              const SizedBox(height: 20,),
              SettingsGroup(
                title: "FEEDBACK",
                subtitle: "",
                children: <Widget>[
                  const SizedBox(height: 10,),
                  buildReportBug(context),
                  buildSendFeedback(context),
                ],
              ),
            ],),
      ),
    );
  }

  // Widget buildAccountSettings() {
  //   return SimpleSettingsTile(
  //     title: "Account Settings",
  //     leading: const Icon(Icons.account_circle, color: Colors.greenAccent,),
  //     onTap: () {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return const UserPage();
  //       }));
  //     },
  //   );
  // }

  Widget buildSendFeedback(BuildContext context) {
    return SimpleSettingsTile(
      title: "Send Feedback",
      subtitle: "",
      leading: const Icon(Icons.thumb_up, color: Colors.purple,),
      onTap: () {
      },
    );
  }

  Widget buildReportBug(BuildContext context) {
    return SimpleSettingsTile(
      title: "Report A Bug",
      subtitle: "",
      leading: const Icon(Icons.bug_report, color: Colors.greenAccent,),
      onTap: () {
      },
    );
  }

  Widget buildLanguage(BuildContext context) {
    return DropDownSettingsTile(
      settingKey: SettingsPage.keyLanguage,
      title: "Language",
      selected: 1,
      values: const <int, String>{
        1: "Ukrainian",
        2: "English",
        3: "Spanish",
        4: "French",
      },
      onChange: (language){
      },
    );
  }

  Widget buildRegion(BuildContext context) {
    return DropDownSettingsTile(
      settingKey: SettingsPage.keyLocation,
      title: "Region",
      selected: 1,
      values: const <int, String>{
        1: "Chernivtsi obl",
        2: "Lviv obl",
        3: "Kyiv obl",
      },
      onChange: (language){
      },
    );
  }

  Widget buildDarkMode(){
    return SwitchSettingsTile(
      title: "Dark Mode",
      settingKey: SettingsPage.keyDarkMode,
      leading: const Icon(Icons.dark_mode, color: Colors.yellow,),
    );
  }
}