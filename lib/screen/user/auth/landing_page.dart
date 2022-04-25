import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/user.dart';
import 'auth.dart';
import 'home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<MyUser?>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? const HomeScreen() : const AuthPage();
  }
}