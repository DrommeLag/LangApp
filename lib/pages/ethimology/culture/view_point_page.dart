import 'package:flutter/material.dart';

class ViewPointPage extends StatelessWidget {
  const ViewPointPage({Key? key, required this.title, required this.description, required this.imagePath}) : super(key: key);
  final String title;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.substring(0, 15) + "..."),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(title),
              Image.network(imagePath),
              Text(description),
            ],
          ),
        ),
      )
    );
  }
}
