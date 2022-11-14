import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lang_app/models/article_tag.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArticleHeadline extends StatelessWidget {
  const ArticleHeadline(this.feedback, this.post, this.underImage, {Key? key})
      : super(key: key);

  final Function() feedback;

  final ArticleTag post;

  final Widget? underImage;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AppLocalizations local = AppLocalizations.of(context)!;

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
        if (underImage != null) ...[
          underImage!,
          Divider(
            color: Theme.of(context).colorScheme.secondary,
            thickness: 1,
            height: 2,
          )
        ],
        const SizedBox(
          height: 20,
        ),
        Text(
          post.description.substring(0, post.description.indexOf(' ', 200) - 1),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
        ),
        Text.rich(
          TextSpan(
              text: local.readMore,
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
