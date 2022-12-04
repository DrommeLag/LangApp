import 'package:fluttertoast/fluttertoast.dart';

showToastErrorMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      fontSize: 16.0);
}