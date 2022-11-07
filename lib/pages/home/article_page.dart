import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lang_app/core/database_service.dart';
import 'package:lang_app/models/article.dart';
import 'package:lang_app/models/article_tag.dart';
import 'package:lang_app/pages/templates/gradients.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage(this.tag, {this.bottom, Key? key})
      : article = DatabaseService().getArticle(tag.id!),
        super(key: key);

  final Future<Article> article;

  final ArticleTag tag;

  final Widget? bottom;

  @override
  State<StatefulWidget> createState() => _ArticlePage();
}

class _ArticlePage extends State<ArticlePage> {
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
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      Image(image: NetworkImage(widget.tag.imageUrl)),
                      MarkdownBody(data: (snapshot.data as Article?)!.data),
                      if (widget.bottom != null) widget.bottom!
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
