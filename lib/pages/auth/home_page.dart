import 'package:flutter/material.dart';

import '../../login/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              AuthService().logOut();
            },
            icon: const Icon(Icons.logout_outlined),)
        ],
        title: const Text("Language App 1.0"),
      ),
      backgroundColor: Colors.grey,
      // body: const HomeButtons(),
    );
  }
}
