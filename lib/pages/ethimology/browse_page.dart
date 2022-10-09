import 'package:flutter/material.dart';
import 'package:lang_app/pages/ethimology/culture/culture_page.dart';
import 'package:lang_app/pages/main_screen.dart';
import 'package:lang_app/pages/templates/material_push_template.dart';

import '../../models/card.dart';
import '../home/home_page.dart';
import '../levels/level_page.dart';
import '../map/map_page.dart';
import '../user/user_page.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  int pos = 2;
  List<Widget> pages = const <Widget>[
    HomePage(), //0
    LevelPage(), //1
    MapPage(), //2
    UserPage(), //3
  ];

  _onTap(int index) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen(index: index)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let it be Volyn"),
      ),
      body: Center(
        child: ListView(
          children: [
            StyledCard("Культура", "", "assets/images/ethimology/culture_preview.png", CulturePage()),
            StyledCard("Населення", "", "assets/images/ethimology/citizens_preview.png", CulturePage()),
            StyledCard("Історичні події", "", "assets/images/ethimology/history_preview.png", CulturePage()),
          ],
        ),
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
    );
  }
}
