import 'package:flutter/rendering.dart';

class Article {
  static const imageRegex = r"((\\img\[(\S+?)\])|(\z))([^\\]*)";

  static const imageRegexUrlGroupIndex = 3;

  static const imageRegexTextGroupIndex = 5;

  static var regex = RegExp(imageRegex);

  final String label;
  late final DateTime publishing;
  final String? id;

  bool _hasRest = false;

  //FIRST ALWAYS MUST BE IMAGE
  List<ArticleElement> _article = [];

  Article(this.label ,List<ArticleElement> elements) : id = null {
    _article = elements;
  }

  Article.fromFirebase(Map<String, dynamic> json, this.id)
      : label = json["label"]! {
    _processText(json["short_article"]!);
  }
  List<ArticleElement> get article => _article;

  bool get hasRest => _hasRest;

  String get restText {
    return _article.sublist(2).map((e) {
      if (e.isImage) {
        return '\\img[${e.url}]';
      } else {
        return e.text;
      }
    }).join();
  }

  giveRestText(String restText) {
    _processText(restText);
    _hasRest = true;
  }

  Map<String, dynamic> toFirebase() {
    Map<String, dynamic> map = {};
    map["label"] = label;
    map["short_article"] = '\\img[${_article[0].url}]${_article[1].text!}';
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$label ${_article[0]}';
  }

  _processText(String text) {
    regex.allMatches(text).forEach((element) {
      String image = element.group(3)!;
      _article.add(ArticleElement.image(image));
      String? bufText = element.group(5);
      if (bufText != null && bufText.isNotEmpty) {
        _article.add(ArticleElement.text(bufText));
      }
    });
  }
}

class ArticleElement {
  final bool isImage;

  final String? url;
  final String? text;

  ArticleElement.image(String _url)
      : isImage = true,
        url = _url,
        text = null;

  ArticleElement.text(String articleText)
      : isImage = false,
        text = articleText,
        url = null;

  ImageProvider get image => NetworkImage(url!);
  
  @override
  String toString() {
    // TODO: implement toString
    if(isImage){
      return 'url: $url';
    }
    return '$text';
  }
}
