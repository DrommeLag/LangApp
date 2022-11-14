import 'package:flutter/material.dart';
import 'package:lang_app/models/article_tag.dart';
import 'package:lang_app/pages/home/headline_widget_template.dart';

class ArticleWidget extends ArticleHeadline {
  const ArticleWidget(Function() feedback, ArticleTag post, {Key? key}) : super(feedback,post, null, key: key);
}
