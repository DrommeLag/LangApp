import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String substringOnSpace(String text, {int amount = 200}) {
  int len = text.length;
  if(len <= amount){
    return text;
  }
  int pos = text.indexOf(' ', amount);
  if(pos == -1){
    return text;
  }

  return text.substring(0, pos);
  }