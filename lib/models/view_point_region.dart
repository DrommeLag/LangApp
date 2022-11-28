class ViewPointRegion {
  ViewPointRegion(
      {required this.items
      });

  ViewPointRegion.fromFirebase(Map<String, Object?> data)
      : items = data[itemsRef] as List<dynamic>;

  Map<String, Object?> toFirebase(){
    return {
      itemsRef: items
    };
  }

  final List<dynamic> items;

  static const String itemsRef = 'id';
}