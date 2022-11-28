import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'article_tag.dart';

class EventTag extends ArticleTag {
  final DateTime from;
  final DateTime? to;
  final String place;

  EventTag(
      String label, String imageUrl, String description, this.from, this.to, this.place,
      {String? id})
      : super(label, imageUrl, description, ArticleCategory.event, id: id);

  EventTag.fromFirestore(Map<String, dynamic> data)
      : from = (data["from"] as Timestamp).toDate(),
        to = (data["to"] as Timestamp?)?.toDate(),
        place = data["place"],
        super.fromFirestore(data, ArticleCategory.event);

  @override
  Map<String, dynamic> toFirestore() {
    var data = super.toFirestore();
    data["from"] = from;
    if (to != null) {
      data["to"] = to!;
    }
    data["place"] = place;
    return data;
  }
}
