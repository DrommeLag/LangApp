import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  static const keyNews = "key-news";
  static const keyNewsletter = "key-newsletter";
  static const keyAppUpdates = "key-app-updates";

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "Notifications",
      subtitle: "Newsletter, App Updates",
      leading: const Icon(Icons.notifications, color: Colors.redAccent,),
      child: SettingsScreen(
        children: [
          buildNews(),
          buildNewsletter(),
          buildAppUpdated(),
        ],
      ),
    );
  }

  Widget buildNews(){
    return SwitchSettingsTile(
      title: "Enable notifications",
      settingKey: NotificationsPage.keyNews,
      leading: const Icon(Icons.message, color: Colors.blueGrey,),
    );
  }

  Widget buildNewsletter(){
    return SwitchSettingsTile(
      title: "Enable newsletter to your email",
      settingKey: NotificationsPage.keyNewsletter,
      leading: const Icon(Icons.newspaper, color: Colors.blue,),
    );
  }

  Widget buildAppUpdated(){
    return SwitchSettingsTile(
      title: "Enable App Updates",
      settingKey: NotificationsPage.keyAppUpdates,
      leading: const Icon(Icons.timer, color: Colors.lightBlueAccent,),
    );
  }
}
