class JournalEntry {
  const JournalEntry({
    required this.date,
    required this.mood,
    required this.activities,
    required this.note,
  });

  factory JournalEntry.empty(DateTime date) {
    return JournalEntry(
      date: DateTime(date.year, date.month, date.day),
      mood: null,
      activities: const {},
      note: '',
    );
  }

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    final rawActivities = json['activities'];

    final activities = rawActivities is Map
        ? rawActivities.map(
            (key, value) => MapEntry(key.toString(), value == true),
          )
        : <String, bool>{};

    return JournalEntry(
      date: DateTime.parse(json['date'] as String),
      mood: json['mood'] as int?,
      activities: Map<String, bool>.from(activities),
      note: json['note'] as String? ?? '',
    );
  }

  final DateTime date;
  final int? mood;
  final Map<String, bool> activities;
  final String note;

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'mood': mood,
      'activities': activities,
      'note': note,
    };
  }
}
