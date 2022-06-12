import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/screen/user/settings/notifications/notification_api.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  static const keyNotif = "key-notif";
  static const keyNewsletter = "key-newsletter";
  static const keyAppUpdates = "key-app-updates";

  @override
  State<StatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "Сповіщення",
      subtitle: "Новини, оновлення додатку",
      leading: const Icon(Icons.notifications),
      child: SettingsScreen(
        children:[
          buildNotif(),
          buildNewsletter(),
          buildAppUpdated(),
        ],
      ),
    );
  }

  Widget buildNotif(){
    return SwitchSettingsTile(
      title: "Дозволити щоденні нагадування",
      settingKey: NotificationsPage.keyNotif,
      leading: const Icon(Icons.message),
      onChange: (value) {
        if(value) {
          NotificationApi.showScheduledNotification(
            title: "Ти ще не заходив у додаток сьогодні?",
            body: "Гайда прокачувати свою українську! =)",
            payload: 'daily_reminder',
          );
        }
      },
    );
  }

  Widget buildNewsletter(){
    return SwitchSettingsTile(
      title: "Дозволити надсилання новин на пошту",
      settingKey: NotificationsPage.keyNewsletter,
      leading: const Icon(Icons.newspaper),
      onChange: (value) {
        if(value){
          // sendNewsletter();
        }
      },
    );
  }

  Widget buildAppUpdated(){
    return SwitchSettingsTile(
      title: "Дозволити автооновлення додатку",
      settingKey: NotificationsPage.keyAppUpdates,
      leading: const Icon(Icons.timer),
    );
  }
}
