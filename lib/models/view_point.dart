class ViewPoint {
  ViewPoint(
      {required this.name,
        required this.description,
        required this.img,
      });

  ViewPoint.fromFirebase(Map<String, Object?> data)
      : name = data[nameRef] as String,
        description = data[descriptionRef] as String,
        img = data[imgRef] as String;

  Map<String, Object?> toFirebase(){
    return {
      nameRef: name,
      descriptionRef: description,
      imgRef: img,
    };
  }

  final String name;
  final String description;
  final String img;

  static const String nameRef = 'name';
  static const String descriptionRef = 'description';
  static const String imgRef = 'img';
}