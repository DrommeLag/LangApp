import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/core/database_service.dart';
import 'package:lang_app/models/article.dart';
import 'package:lang_app/models/article_tag.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var databaseService = DatabaseService();
  var authService = AuthService();
  authService.signInWithEmailAndPassword('nz54ds@gmail.com', 'password');

  String filler = 
"""
![](https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516_960_720.jpg)
# Label

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eu nibh eu nisl vehicula placerat. Nullam eu placerat purus. Nulla efficitur libero tempor ante porta, ut dignissim nisl malesuada. Nullam facilisis congue nibh, vel blandit nunc finibus eget. Quisque vitae dui pretium, pharetra lorem non, placerat nulla. Aliquam erat volutpat. Fusce quis sollicitudin nibh. Praesent sit amet luctus dui. Ut pharetra sapien eget leo mattis, eget ornare est pretium. Etiam eget mollis sem. Nunc arcu ante, fringilla eget hendrerit et, euismod sed odio. Donec convallis in dolor quis tempus. Proin ornare vulputate purus vitae vehicula.

Cras tempus sit amet sapien eu hendrerit. Nulla fermentum euismod tellus, ac tristique felis molestie ut. Quisque id dui sollicitudin purus lobortis rutrum vel nec risus. Morbi dignissim, purus ut accumsan imperdiet, erat metus dignissim libero, sed eleifend urna tortor ac arcu. Sed lobortis sem ac facilisis commodo. Nunc vel porttitor lorem. Sed a feugiat magna, at fringilla urna. Donec et mi id ex suscipit elementum a et elit. Donec sit amet tellus non dui venenatis sodales ac ut ligula. Fusce ac ipsum consectetur risus posuere sollicitudin. Nunc nec est ut ipsum bibendum efficitur. Sed tempor sapien vitae sagittis accumsan. Pellentesque vitae condimentum ipsum. Nam consequat nisi non nulla dapibus consectetur.

## Sublabel
![](https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516_960_720.jpg)

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eu nibh eu nisl vehicula placerat. Nullam eu placerat purus. Nulla efficitur libero tempor ante porta, ut dignissim nisl malesuada. Nullam facilisis congue nibh, vel blandit nunc finibus eget. Quisque vitae dui pretium, pharetra lorem non, placerat nulla. Aliquam erat volutpat. Fusce quis sollicitudin nibh. Praesent sit amet luctus dui. Ut pharetra sapien eget leo mattis, eget ornare est pretium. Etiam eget mollis sem. Nunc arcu ante, fringilla eget hendrerit et, euismod sed odio. Donec convallis in dolor quis tempus. Proin ornare vulputate purus vitae vehicula.

Cras tempus sit amet sapien eu hendrerit. Nulla fermentum euismod tellus, ac tristique felis molestie ut. Quisque id dui sollicitudin purus lobortis rutrum vel nec risus. Morbi dignissim, purus ut accumsan imperdiet, erat metus dignissim libero, sed eleifend urna tortor ac arcu. Sed lobortis sem ac facilisis commodo. Nunc vel porttitor lorem. Sed a feugiat magna, at fringilla urna. Donec et mi id ex suscipit elementum a et elit. Donec sit amet tellus non dui venenatis sodales ac ut ligula. Fusce ac ipsum consectetur risus posuere sollicitudin. Nunc nec est ut ipsum bibendum efficitur. Sed tempor sapien vitae sagittis accumsan. Pellentesque vitae condimentum ipsum. Nam consequat nisi non nulla dapibus consectetur. 

## Sublabel
![](https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516_960_720.jpg)

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eu nibh eu nisl vehicula placerat. Nullam eu placerat purus. Nulla efficitur libero tempor ante porta, ut dignissim nisl malesuada. Nullam facilisis congue nibh, vel blandit nunc finibus eget. Quisque vitae dui pretium, pharetra lorem non, placerat nulla. Aliquam erat volutpat. Fusce quis sollicitudin nibh. Praesent sit amet luctus dui. Ut pharetra sapien eget leo mattis, eget ornare est pretium. Etiam eget mollis sem. Nunc arcu ante, fringilla eget hendrerit et, euismod sed odio. Donec convallis in dolor quis tempus. Proin ornare vulputate purus vitae vehicula.

Cras tempus sit amet sapien eu hendrerit. Nulla fermentum euismod tellus, ac tristique felis molestie ut. Quisque id dui sollicitudin purus lobortis rutrum vel nec risus. Morbi dignissim, purus ut accumsan imperdiet, erat metus dignissim libero, sed eleifend urna tortor ac arcu. Sed lobortis sem ac facilisis commodo. Nunc vel porttitor lorem. Sed a feugiat magna, at fringilla urna. Donec et mi id ex suscipit elementum a et elit. Donec sit amet tellus non dui venenatis sodales ac ut ligula. Fusce ac ipsum consectetur risus posuere sollicitudin. Nunc nec est ut ipsum bibendum efficitur. Sed tempor sapien vitae sagittis accumsan. Pellentesque vitae condimentum ipsum. Nam consequat nisi non nulla dapibus consectetur. 
""";

String desc =  """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas eu nibh eu nisl vehicula placerat. Nullam eu placerat purus. Nulla efficitur libero tempor ante porta, ut dignissim nisl malesuada. Nullam facilisis congue nibh, vel blandit nunc finibus eget. Quisque vitae dui pretium, pharetra lorem non, placerat nulla. Aliquam erat volutpat. Fusce quis sollicitudin nibh. Praesent sit amet luctus dui. Ut pharetra sapien eget leo mattis, eget ornare est pretium. Etiam eget mollis sem. Nunc arcu ante, fringilla eget hendrerit et, euismod sed odio. Donec convallis in dolor quis tempus. Proin ornare vulputate purus vitae vehicula.
Cras tempus sit amet sapien eu hendrerit. Nulla fermentum euismod tellus, ac tristique felis molestie ut. Quisque id dui sollicitudin purus lobortis rutrum vel nec risus. Morbi dignissim, purus ut accumsan imperdiet, erat metus dignissim libero, sed eleifend urna tortor ac arcu. Sed lobortis sem ac facilisis commodo. Nunc vel porttitor lorem. Sed a feugiat magna, at fringilla urna. Donec et mi id ex suscipit elementum a et elit. Donec sit amet tellus non dui venenatis sodales ac ut ligula. Fusce ac ipsum consectetur risus posuere sollicitudin. Nunc nec est ut ipsum bibendum efficitur. Sed tempor sapien vitae sagittis accumsan. Pellentesque vitae condimentum ipsum. Nam consequat nisi non nulla dapibus consectetur. 
""";
  Article a = Article(filler);
  for (var i = 0; i < 30; i++) {
    databaseService.sendArticle(a, ArticleTag("Label $i", "https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516_960_720.jpg", desc, ArticleCategory.brands));
    databaseService.sendArticle(a, ArticleTag("Label $i", "https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516_960_720.jpg", desc, ArticleCategory.forMe));
    databaseService.sendArticle(a, ArticleTag("Label $i", "https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516_960_720.jpg", desc, ArticleCategory.something));
    databaseService.sendArticle(a, ArticleTag("Label $i", "https://cdn.pixabay.com/photo/2014/06/03/19/38/board-361516_960_720.jpg", desc, ArticleCategory.sport));
  }
}
