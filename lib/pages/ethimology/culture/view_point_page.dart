import 'package:flutter/material.dart';

class ViewPointPage extends StatelessWidget {
  const ViewPointPage({Key? key, required this.title, required this.description, required this.imagePath}) : super(key: key);
  final String title;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
          child: Column(
            children: [
              Text(title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10,)),
              Image.network(imagePath),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20,)),
              Text(description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      )
    );
  }
}
