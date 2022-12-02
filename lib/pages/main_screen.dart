import 'package:flutter/material.dart';
import 'package:lang_app/pages/home/home_page.dart';
import 'package:lang_app/pages/levels/level_page.dart';
import 'package:lang_app/pages/map/map_page.dart';
import 'package:lang_app/pages/user/user_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int pos = 0;
  final List<_Page> pages = const <_Page>[
    _Page(Icons.home_filled, HomePage()), //0
    _Page(Icons.edit_sharp, LevelPage()), //1
    _Page(Icons.favorite, MapPage()), //2
    _Page(Icons.person_outline, UserPage()), //3
  ];

  _onTap(int index) {
    setState(() {
      pos = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pos = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        ),
        bottomNavigationBar: Container(
          color: Colors.blue,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.grey,
            tabs: pages
                .map((e) => Tab(
                      icon: Icon(
                        e.icon,
                        size: 40,
                      ),
                    ))
                .toList(),
            onTap: _onTap,
          ),
        ),
        body: TabBarView(
          children: (pages.map((e) => e.page).toList()),
        ),
      ),
    );
  }
}

class _Page {
  const _Page(this.icon, this.page);

  final IconData icon;
  final Widget page;
}
