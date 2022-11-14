import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/pages/user/settings/notifications/notification_api.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    AppLocalizations local = AppLocalizations.of(context)!;
    return SimpleSettingsTile(
      title: local.notifications,
      subtitle: local.notificationsSubtitle,
      leading: const Icon(Icons.notifications),
      child: SettingsScreen(
        children:[
          buildNotif(local),
          buildNewsletter(local),
          buildAppUpdated(local),
        ],
      ),
    );
  }

  Widget buildNotif(AppLocalizations local){
    return SwitchSettingsTile(
      title:local.enableDailyNotif,
      settingKey: NotificationsPage.keyNotif,
      leading: const Icon(Icons.message),
      onChange: (value) {
        if(value) {
          NotificationApi.showScheduledNotification(
            title:local.notifTitle,
            body:local.notifBody,
            payload: 'daily_reminder',
          );
        }
      },
    );
  }

  Widget buildNewsletter(AppLocalizations local){
    return SwitchSettingsTile(
      title: local.emailNotifQuestion,
      settingKey: NotificationsPage.keyNewsletter,
      leading: const Icon(Icons.newspaper),
      onChange: (value) {
        if(value){
          // sendNewsletter();
        }
      },
    );
  }

  Widget buildAppUpdated(AppLocalizations local){
    return SwitchSettingsTile(
      title: local.enableAutoupdate,
      settingKey: NotificationsPage.keyAppUpdates,
      leading: const Icon(Icons.timer),
    );
  }
}
