import 'package:flutter/material.dart';

import 'package:lang_app/screen/map/map_page.dart';
import 'package:lang_app/screen/newsletter/news_page.dart';
import 'package:lang_app/screen/home/home_page.dart';
import 'package:lang_app/screen/user/user_page.dart';

import 'newsletter/news_page.dart';



class MainScreen extends StatefulWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen>{

  int pos = 0;
  List<Widget> pages = const <Widget>[
    HomePage(), //0
    MapPage(), //1
    NewsPage(), //2
    UserPage(), //3
  ];

  _onTap(int a){
    setState(() {
      pos = a;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UkrLangApp - dev-ng"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: pos,
        iconSize: 40,
        onTap: _onTap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      body: pages[pos],

    );
  }

}