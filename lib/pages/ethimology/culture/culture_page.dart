import 'package:flutter/material.dart';
import 'package:lang_app/models/card.dart';

class CulturePage extends StatefulWidget {
  const CulturePage({Key? key}) : super(key: key);

  @override
  State<CulturePage> createState() => _CulturePageState();
}

class _CulturePageState extends State<CulturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let it be Volyn"),
      ),
      body: Center(
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 10,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return StyledCard("title", "description", "assets/images/ethimology/culture_preview.png", const Scaffold(body: Center(child: Text("Default"),),));
            },
          ),
        ),
      )
    );
  }
}
