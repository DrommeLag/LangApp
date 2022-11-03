
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:lang_app/models/event_tag.dart';
import 'package:lang_app/pages/home/article_page.dart';

class EventPage extends ArticlePage {
  EventPage(EventTag tag, {Key? key})
      : super(tag,
            bottom: Row(
              children: [
                const Icon(Icons.event_available_outlined,
                    size: 40, color: Color(0xff0068C9)),
                Text(
                    "${tag.from.day}-${tag.from.month}-${tag.from.year}${(tag.to == null) ? "" : " - ${tag.to!.day}-${tag.to!.month}-${tag.to!.year}"}"),
                const Spacer(),
                const Icon(Icons.place_outlined,
                    size: 40, color: Color(0xff0068C9)),
                Text(tag.place),
              ],
            ),
            key: key);
}
