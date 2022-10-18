/// 
/// IMPORTANT: image and label must be in first 350 symbols
/// 
class Article {
  final String? id;
  final String _data;
  late final DateTime publishing;

  String get data => _data;

  Article(this._data) : id = null;

  Article.fromFirebase(Map<String, dynamic> json, this.id)
      : _data = json["data"];


  Map<String, dynamic> toFirebase() {
    Map<String, dynamic> map = {};
    map["data"] = data;
    return map;
  }

}
