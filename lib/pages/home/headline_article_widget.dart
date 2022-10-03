import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/models/article.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget(this.feedback, this.post, {Key? key}) : super(key: key);

  final Function() feedback;

  final Article post;

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
          image: post.article[0].image,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(post.article[1].text!
            .substring(0, post.article[1].text!.indexOf(' ', 200) - 1)),
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
