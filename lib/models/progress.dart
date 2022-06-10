class UserProgress {
  UserProgress(this.testStatuses);
  UserProgress.fromFirestore(Map<String, Object?> data)
      : testStatuses = (data.entries.toList()
              ..sort(((a, b) => a.key.compareTo(b.key))))
            .map((e) => e.value as int)
            .toList();
  final List<int> testStatuses;
}
