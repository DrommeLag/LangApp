import 'package:flutter/rendering.dart';

class Article {
  final String label;
  final String shortDescription;
  final ImageProvider image;

  final Future<String> Function() _getRestText;

  String? restText;

  String get text => shortDescription + ((restText == null) ? '' : restText!);

  Future<void> loadRestText() async{
    await _getRestText().then((value) => restText = value);
  }

  Article(this.label, this.shortDescription, this.image, this._getRestText);
}