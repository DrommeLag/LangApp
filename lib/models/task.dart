
class Task{
  final String question;
  final String headline;
  final List<String> answers;

  Task(this.question, this.headline, this.answers);
  Task.fromFirebase(Map<String, Object?> data)
    : question = data[questionName] as String,
      headline = data[headlineName] as String,
      answers = (data[answersName] as List<dynamic>).map((e) => e as String).toList();
  
  Map<String, Object?> toFirestore(){
    return {
      questionName: question,
      headlineName: headline,
      answersName: answers,
    };
  }

  static const String questionName = 'question';
  static const String headlineName = 'headline';
  static const String answersName = 'answers';

}
