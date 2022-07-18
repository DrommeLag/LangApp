import 'package:flutter/material.dart';
import 'package:lang_app/pages/home/home_page.dart';
import 'package:lang_app/pages/levels/level_page.dart';
import 'package:lang_app/pages/map/map_page.dart';
import 'package:lang_app/pages/user/user_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int pos = 0;
  List<Widget> pages = const <Widget>[
    HomePage(), //0
    LevelPage(), //1
    MapPage(), //2
    UserPage(), //3
  ];

  _onTap(int a) {
    setState(() {
      pos = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lang App"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
        currentIndex: pos,
        iconSize: 40,
        onTap: _onTap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Theme.of(context).colorScheme.shadow,
      ),
      body: pages[pos],
    );
  }
}
