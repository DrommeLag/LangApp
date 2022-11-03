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
                const Icon(Icons.event_available_outlined, size: 40, color: Color(0xff0068C9)),
                Text("${post.from.day}-${post.from.month}-${post.from.year}${(post.to == null)
                        ? ""
                        : " - ${post.to!.day}-${post.to!.month}-${post.to!.year}"}"),
                const Spacer(),
                const Icon(Icons.place_outlined, size: 40,color: Color(0xff0068C9) ),
                Text(post.place),
              ],
            ),
            key: key);
}
