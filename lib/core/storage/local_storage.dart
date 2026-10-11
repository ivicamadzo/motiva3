import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/journal/data/journal_entry.dart';

class LocalStorage {
  LocalStorage._();

  static final LocalStorage instance = LocalStorage._();
  static const _journalPrefix = 'journal_';

  Future<SharedPreferences> get _preferences async {
    return SharedPreferences.getInstance();
  }

  Future<void> saveJournalEntry(JournalEntry entry) async {
    final preferences = await _preferences;
    await preferences.setString(
      _journalKey(entry.date),
      jsonEncode(entry.toJson()),
    );
  }

  Future<JournalEntry?> loadJournalEntry(DateTime date) async {
    final preferences = await _preferences;
    final raw = preferences.getString(_journalKey(date));

    if (raw == null) {
      return null;
    }

    return JournalEntry.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  String _journalKey(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    return '$_journalPrefix${day.year.toString().padLeft(4, '0')}-'
        '${day.month.toString().padLeft(2, '0')}-'
        '${day.day.toString().padLeft(2, '0')}';
  }
}
