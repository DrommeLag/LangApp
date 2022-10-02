import 'package:flutter/material.dart';

class StyledCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  StyledCard(this.title, this.description, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme
          .of(context)
          .colorScheme
          .secondaryContainer,
      child: InkWell(
        splashColor: Colors.yellow[600],
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: SizedBox(
          width: 50,
          height: 300,
          child: Center(
              child: Column(
                children: [
                  Image.asset(imagePath),
                  Text(title, style: TextStyle(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),),
                  Text(description, style: TextStyle(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onSecondary,
                    fontSize: 20,
                  ),),
                ],
              )
          ),
        ),
      ),
    );
  }
}