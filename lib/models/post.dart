import 'package:flutter/rendering.dart';

class Post {
  final String label;
  final String shortDescription;
  final ImageProvider image;

  Post(this.label, this.shortDescription, this.image);
}