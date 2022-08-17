import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lang_app/models/article.dart';
import 'package:lang_app/pages/templates/gradients.dart';
import 'package:collection/collection.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({Key? key, required this.article}) : super(key: key) {
    loadIndicator = article.loadRestText();
  }
  late Future<void> loadIndicator;

  final Article article;

  @override
  State<StatefulWidget> createState() => _ArticlePage();
}

class _ArticlePage extends State<ArticlePage> {
  late List<String> _textsAndImagesUrls;

  bool _isArticlePresent = false;

  @override
  void initState() {
    super.initState();
    _loadAndFormPage();
  }

  _loadAndFormPage() async {
    await widget.loadIndicator;
    _textsAndImagesUrls = _encodeText(widget.article.text);
    setState(() {
      _isArticlePresent = true;
    });
  }

  Widget imageRoundedAndWithPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ClipRRect(
        child: child,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    late Widget body;
    if (_isArticlePresent) {
      body = ListView(
        children: [
          imageRoundedAndWithPadding(Image(
            image: widget.article.image,
          )),
          Text(
            widget.article.label,
            style: theme.textTheme.headlineSmall,
          ),
          Text.rich(
            TextSpan(
              children: _textsAndImagesUrls.mapIndexed((index, element) {
                if (index % 2 == 0) {
                  //Even is text
                  return TextSpan(text: element);
                } else {
                  //Odd is image url
                  return WidgetSpan(
                      child:
                          imageRoundedAndWithPadding(Image.network(element)));
                }
              }).toList(),
            ),
          ),
        ],
      );
    } else {
      body = Container(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: theme.colorScheme.secondary),
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_back, size: 20,)
                ),),
                Spacer(),
                GestureDetector(
                  onTap: () => log("Share clicked"),
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: theme.colorScheme.secondary),
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: Icon(Icons.share, size: 20,)
                ),),
              ],
            ),
            decoration: BoxDecoration(
                gradient: backgroundGradient,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
          ),
        ),
        body: Padding(
          child: body,
          padding: EdgeInsets.symmetric(horizontal: 30),
        ));
  }

  // Even - text, Odd - image url
  List<String> _encodeText(text) {
    var regexOfImageUrl = RegExp(r"(.+?)((\\img\[(\S+?)\])|(\z))");

    List<String?> textAndImages = List.empty(growable: true);

    regexOfImageUrl.allMatches(text).forEach((e) {
      //Text
      textAndImages.add(e.group(1)!);

      //Image url
      textAndImages.add(e.group(4));
    });

    textAndImages.removeLast();

    return textAndImages.map((e) => e!).toList();
  }
}
