
import 'package:flutter/material.dart';

class MainScreen extends Material{
  const MainScreen({Key? key}): super(key: key);


  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen>{

  int pos = 0;
  List<Widget> pages = const <Widget>[
    //TODO(add there),
  ];

  _onTap(int a){
    setState(() {
      pos = a;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: //TODO later pages[pos]
      Center(
        child: Text(pos.toString()),
      ),
    );
  }

}