import 'package:flutter/material.dart';
import 'package:lang_app/pages/ethimology/culture/culture_page.dart';

import '../../models/card.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
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
    );
  }
}
