import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lang_app/screen/user/settings/notifications/NotificationApi.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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
          // sendNewsletter();
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

  // Future sendNewsletter() async{
  //   User? user = FirebaseAuth.instance.currentUser;
  //
  //   if(user == null) return;
  //
  //   final email = user.email!;
  //   final auth = await user.getIdTokenResult();
  //   final token = auth.token!;
  //
  //   // print("Auth: $email");
  //   // print("Token: $token");
  //   final smtpServer = gmailSaslXoauth2(email, token);
  //
  //   final message = Message()
  //     ..from = Address(email, 'DrommeLag')
  //     ..recipients.add(Address(email, 'Igor'))
  //     ..subject = 'Hi man, that`s a subject!'
  //     ..text = 'Test email. Hope it will work';
  //
  //   try {
  //     await send(message, smtpServer);
  //   } on MailerException catch (e) {
  //     if(kDebugMode){
  //       print(e);
  //     }
  //   }
  // }
}
