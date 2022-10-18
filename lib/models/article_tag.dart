class ArticleTag {
  String? id;
  final DateTime publishing;
  final ArticleCategory category;
  final String description;
  final String label;
  final String imageUrl;

  ArticleTag(this.label, this.imageUrl, this.description, this.category, {this.id})
  : publishing = DateTime.now();

  ArticleTag.fromFirestore(Map<String, dynamic> data, this.category)
  : id = data["id"],
    publishing = DateTime.fromMillisecondsSinceEpoch(data["publishing"]),
    label = data["label"],
    imageUrl = data["url"],
    description = data["description"];
    
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = {
      'id': id,
      'publishing': publishing.millisecondsSinceEpoch,
      'label': label,
      'url': imageUrl,
      'description': description
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
