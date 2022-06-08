class News {
  News(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.url,
      });

  News.fromFirebase(Map<String, Object?> data)
  : title = data[titleRef] as String,
    subtitle = data[subtitleRef] as String,
    url = data[urlRef] as String,
    icon = data[iconRef] as String;

  Map<String, Object?> toFirebase(){
    return {
      titleRef: title,
      subtitleRef: subtitle,
      urlRef: url,
      iconRef: icon,
    };
  }

  final String title;
  final String subtitle;
  final String url;
  //final String text;
  final String icon;

  static const String titleRef = 'title';
  static const String subtitleRef = 'subtitle';
  static const String urlRef = 'url';
  static const String iconRef = 'icon';
}
