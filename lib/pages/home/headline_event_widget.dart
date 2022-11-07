import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:lang_app/models/event_tag.dart';
import 'package:lang_app/pages/home/headline_widget_template.dart';

class EventWidget extends ArticleHeadline {
  EventWidget(Function() feedback, EventTag post, {Key? key})
      : super(
            feedback,
            post,
            Row(
              children: [
                const Icon(Icons.event_available_outlined,
                    size: 40, color: Color(0xff0068C9)),
                Text(generateTimeDiffText(post.from, post.to)),
                const Spacer(),
                const Icon(Icons.place_outlined,
                    size: 40, color: Color(0xff0068C9)),
                Text(post.place),
              ],
            ),
            key: key);
}

String generateTimeDiffText(DateTime from, DateTime? to) {
  DateTime now = DateTime.now();
  bool showYear = from.year != now.year;
  String toString = '';
  if (to != null) {
    showYear = showYear || now.year != to.year;

    toString = ' - ${to.day}.${to.month}';
    if (showYear) {
      toString += '.${to.year}';
    }
  }

  String fromString = '${from.day}.${from.month}';
  if (showYear) {
    fromString += '.${from.year}';
  }

  return fromString + toString;
}
