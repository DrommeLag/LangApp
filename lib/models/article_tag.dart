class ArticleTag {
  final String id;
  final DateTime publishing;
  final ArticleCategory category;

  ArticleTag(this.id, this.publishing, this.category);

  ArticleTag.fromFirestore(Map<String, dynamic> data, this.category)
  : id = data["id"],
    publishing = DateTime.fromMillisecondsSinceEpoch(data["publishing"]);
    
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = {
      'id': id,
      'publishing': publishing.millisecondsSinceEpoch
    };
    return map;
  }
  }

enum ArticleCategory {
  forMe('For me'),
  something('Something'),
  brands('Brands'),
  media('Media'),
  sport('Sport');

  const ArticleCategory(this.name);

  final String name;
}
