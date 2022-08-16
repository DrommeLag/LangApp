import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/models/post.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(this.feedback, this.post, {Key? key}) : super(key: key);

  final Function() feedback;

  final Post post;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          post.label,
          textAlign: TextAlign.start,
          style: theme.textTheme.headlineSmall!
              .copyWith(color: theme.colorScheme.primaryContainer),
        ),
        SizedBox(
          height: 20,
        ),
        Image(
          image: post.image,
        ),
        SizedBox(
          height: 20,
        ),
        Text(post.shortDescription),
        Text.rich(
          TextSpan(
              text: 'Read more',
              style: theme.textTheme.bodyLarge!
                  .copyWith(color: theme.colorScheme.primary),
              recognizer: TapGestureRecognizer()..onTap = feedback),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
