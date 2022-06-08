class Test{
  Test({required this.name, required this.description, required this.taskIds});

  Test.fromFirestore(Map<String, Object?> data)
  :name = data[nameIndifier] as String,
   description = data[descriptionIndifier] as String,
   taskIds = (data[taskIndifier] as List<dynamic>).map((e) => e as String).toList();

  Map<String, Object?> toFirestore(){
    return {
      nameIndifier: name,
      descriptionIndifier: description,
      taskIndifier: taskIds,
    };
  }

  static const String nameIndifier = 'name';
  static const String descriptionIndifier = 'description';
  static const String taskIndifier = 'tasks';

  final String name;
  final String description;
  final List<String> taskIds;
  
}
