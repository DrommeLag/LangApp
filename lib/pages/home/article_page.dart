import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lang_app/core/database_service.dart';
import 'package:lang_app/models/article.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:collection/collection.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({Key? key, required String id})
      : article = DatabaseService().getArticle(id),
        super(key: key);

  final Future<Article> article;

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
              future: widget.article,
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return ListView(children: [MarkdownBody(data: (snapshot.data as Article?)!.data)],);
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
