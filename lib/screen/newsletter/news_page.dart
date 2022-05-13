import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget{
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPage();

}

class _NewsPage extends State<NewsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: const <Widget>[
            ListTile(
              leading: Icon(Icons.new_releases_sharp),
              title: Text("Big changes in 1.0.7 version"),
              subtitle: Text("Fixed bugs, added new levels and design options! Whole info..."),
            ),
            ListTile(
              leading: Icon(Icons.new_releases_sharp),
              title: Text("Big changes in 1.0.6 version"),
              subtitle: Text("Don`t know what to write. Lorem ipsun..."),
            ),
            ListTile(
              leading: Icon(Icons.new_releases_sharp),
              title: Text("Changes in 1.0.5 version"),
              subtitle: Text("Don`t know what to write. Lorem ipsun..."),
            ),
            ListTile(
              leading: Icon(Icons.new_releases_sharp),
              title: Text("What`s new in 1.0.4"),
              subtitle: Text("Nazar, fix authorization."),
            ),
          ],
        )
      ),
    );
  }

}