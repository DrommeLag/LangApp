class UserProgress {
  const UserProgress(this.testStatuses);
  UserProgress.fromFirestore(Map<String, Object?> data)
      : testStatuses = (data.entries.toList()
              ..sort(((a, b) => a.key.compareTo(b.key))))
            .map((e) => e.value as int)
            .toList();

  Map<String, Object?> toFirestore() {
    return testStatuses
        .asMap()
        .map((key, value) => MapEntry(key.toString(), value));
  }

  final List<int> testStatuses;

  static const UserProgress template = UserProgress([0, -1, -1, -1, -1, -1]);
}
