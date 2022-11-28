import 'package:flutter/material.dart';
import 'package:lang_app/pages/ethimology/culture/view_point_page.dart';
import '../pages/templates/material_push_template.dart';

class StyledCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const StyledCard(this.title, this.description, this.imagePath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.surface,
          onTap: () {
            debugPrint('Card tapped.');
            materialPushPage(context, ViewPointPage(title: title, description: description, imagePath: imagePath));
          },
          child: Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(imagePath),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10,)),
                    Text(title,
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5,)),
                    Text("${description.substring(0, 60)}...",
                      style: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSecondary,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}