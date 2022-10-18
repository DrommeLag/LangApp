import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/models/article.dart';
import 'package:lang_app/models/article_tag.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget(this.feedback, this.post, {Key? key}) : super(key: key);

  final Function() feedback;

  final ArticleTag post;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(post.label,
            textAlign: TextAlign.start, style: theme.textTheme.headlineSmall),
        const SizedBox(
          height: 20,
        ),
        Image(
          image: NetworkImage(post.imageUrl),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(post.description
            .substring(0, post.description.indexOf(' ', 200) - 1)),
        Text.rich(
          TextSpan(
              text: 'Read more',
              style: theme.textTheme.bodyLarge!
                  .copyWith(color: theme.colorScheme.primary),
              recognizer: TapGestureRecognizer()..onTap = feedback),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
