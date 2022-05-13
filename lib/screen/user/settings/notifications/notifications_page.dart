import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/screen/user/settings/notifications/NotificationApi.dart';
import 'package:http/http.dart' as http;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  static const keyNotif = "key-notif";
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
      title: "Enable daily reminder",
      settingKey: NotificationsPage.keyNotif,
      leading: const Icon(Icons.message),
      onChange: (value) {
        if(value) {
          NotificationApi.showScheduledNotification(
            title: "Dinner with the boooooooys",
            body: "Right now",
            payload: 'dinner_asap',
          );
        }
      },
    );
  }

  Widget buildNewsletter(){
    return SwitchSettingsTile(
      title: "Enable newsletter to your email",
      settingKey: NotificationsPage.keyNewsletter,
      leading: const Icon(Icons.newspaper),
      onChange: (value) {
        if(value){
          sendNewsletter(email: "", subject: "", message: "");
        }
      },
    );
  }

  Widget buildAppUpdated(){
    return SwitchSettingsTile(
      title: "Enable App Updates",
      settingKey: NotificationsPage.keyAppUpdates,
      leading: const Icon(Icons.timer),
    );
  }

  Future sendNewsletter({
    required String email,
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_v90f2v7';
    final templateId = 'template_c3g6947';
    final userId = 'FVyO9KPzCJ4a1QVO6';

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',

      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        }
      }),
    );
  }
}
