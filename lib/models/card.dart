import 'package:flutter/material.dart';
import 'package:lang_app/pages/templates/material_push_template.dart';

class StyledCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Widget page;

  StyledCard(this.title, this.description, this.imagePath, this.page);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.surface,
        onTap: () {
          debugPrint('Card tapped.');
          materialPushPage(context, page);
        },
        child: SizedBox(
          width: 50,
          height: 310,
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