import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/core/database_service.dart';
import 'package:lang_app/models/article.dart';
import 'package:lang_app/models/article_tag.dart';
import 'package:lang_app/models/test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var databaseService = DatabaseService();
  var authService = AuthService();
  authService.signInWithEmailAndPassword('nz54ds@gmail.com', 'password');

  String filler =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  Article a = Article("Test", [
    ArticleElement.image(
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg'),
    ArticleElement.text(filler),
    ArticleElement.image(
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg'),
    ArticleElement.text(filler),
    ArticleElement.image(
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg'),
    ArticleElement.text(filler),
    ArticleElement.image(
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg'),
    ArticleElement.text(filler),
  ]);
  for (var i = 0; i < 30; i++) {
    databaseService.sendArticle(a, ArticleCategory.brands);
    databaseService.sendArticle(a, ArticleCategory.forMe);
    databaseService.sendArticle(a, ArticleCategory.something);

    databaseService.sendArticle(a, ArticleCategory.sport);
  }
}
