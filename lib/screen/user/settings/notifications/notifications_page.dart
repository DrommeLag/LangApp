import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/screen/user/settings/notifications/NotificationApi.dart';

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
      leading: const Icon(Icons.notifications),
      child: SettingsScreen(
        children: [
          buildSimpleNotificationButton(),
          buildScheduledNotificationButton(),
          buildNews(),
          buildNewsletter(),
          buildAppUpdated(),
        ],
      ),
    );
  }

  Widget buildSimpleNotificationButton(){
    return ElevatedButton(
      onPressed: () {
        NotificationApi.showNotification(
          title: "Simple Notif-n",
          body: "It`s working!!! FUCK YEAAAAAAAAAAAAAAAAAAAH",
          payload: 'igor.owner',
        );
      },
      child: Row(
        children: const [
          Icon(Icons.notifications_on),
          Text("Simple notifications"),
        ],
      ),);
  }

  Widget buildScheduledNotificationButton(){ // throws error, caused by TimeZone package - still working on it
    return ElevatedButton(
      onPressed: () {
        NotificationApi.showScheduledNotification(
          title: "Dinner with the boooooooys",
          body: "Right now",
          payload: 'dinner_asap',
          scheduledDate: DateTime.now().add(const Duration(seconds: 5)),
        );
      },
      child: Row(
        children: const [
          Icon(Icons.schedule_send),
          Text("Scheduled notifications"),
        ],
      ),);
  }

  Widget buildNews(){
    return SwitchSettingsTile(
      title: "Enable notifications",
      settingKey: NotificationsPage.keyNews,
      leading: const Icon(Icons.message),
    );
  }

  Widget buildNewsletter(){
    return SwitchSettingsTile(
      title: "Enable newsletter to your email",
      settingKey: NotificationsPage.keyNewsletter,
      leading: const Icon(Icons.newspaper),
    );
  }

  Widget buildAppUpdated(){
    return SwitchSettingsTile(
      title: "Enable App Updates",
      settingKey: NotificationsPage.keyAppUpdates,
      leading: const Icon(Icons.timer),
    );
  }
}
