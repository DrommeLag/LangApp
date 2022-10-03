import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lang_app/core/database_service.dart';
import 'package:lang_app/models/article.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:collection/collection.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({Key? key, required this.article})
      : loadIndicator = DatabaseService().getRestArticle(article),
        super(key: key);

  final Future<void> loadIndicator;

  final Article article;

  @override
  State<StatefulWidget> createState() => _ArticlePage();
}

class _ArticlePage extends State<ArticlePage> {
  bool _isArticlePresent = false;

  @override
  void initState() {
    super.initState();
  }


  Widget imageRoundedAndWithPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                gradient: backgroundGradient,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: theme.colorScheme.secondary),
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20,
                      )),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => log("Share clicked"),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: theme.colorScheme.secondary),
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.share,
                        size: 20,
                      )),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FutureBuilder(
              future: widget.loadIndicator,
              builder: (context, snapshot) {
                if (widget.article.hasRest){
                  return ListView(
                    children: [
                      imageRoundedAndWithPadding(Image(
                        image: widget.article.article[0].image,
                      )),
                      Text(
                        widget.article.label,
                        style: theme.textTheme.headlineSmall,
                      ),
                      ...widget.article.article.sublist(1).map(
                        (e) {
                          if (e.isImage) {
                            return Image(image: e.image);
                          } else {
                            return Text(e.text!);
                          }
                        },
                      ),
                    ],
                  );
                } else {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )));
  }
}
