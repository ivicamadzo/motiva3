import 'package:flutter/material.dart';

import '../../../core/ai/motiva_ai_service.dart';
import '../../../core/storage/local_storage.dart';
import '../../../theme/theme_exports.dart';
import '../data/journal_entry.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  static const _activityLabels = [
    'Прошетка',
    'Дишење',
    'Медитација',
    'Вежбање',
  ];
  static const _moods = ['😟', '😐', '🙂', '😊'];

  late DateTime _selectedDate;
  JournalEntry _entry = JournalEntry.empty(DateTime.now());
  late final TextEditingController _noteController;
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isGeneratingInsight = false;
  String? _aiInsight;

  @override
  void initState() {
    super.initState();
    _selectedDate = _dateOnly(DateTime.now());
    _noteController = TextEditingController();

    _loadEntry();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadEntry() async {
    final saved = await LocalStorage.instance.loadJournalEntry(_selectedDate);
    if (!mounted) return;

    setState(() {
      _entry = saved ?? JournalEntry.empty(_selectedDate);
      _noteController.text = _entry.note;
      _isLoading = false;
    });
  }

  Future<void> _selectDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (selected == null) return;
    setState(() {
      _selectedDate = _dateOnly(selected);
      _isLoading = true;
    });
    await _loadEntry();
  }

  Future<void> _saveEntry() async {
    setState(() => _isSaving = true);

    final entry = JournalEntry(
      date: _selectedDate,
      mood: _entry.mood,
      activities: _entry.activities,
      note: _noteController.text.trim(),
    );

    await LocalStorage.instance.saveJournalEntry(entry);
    if (!mounted) return;

    setState(() {
      _entry = entry;
      _isSaving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Записот е зачуван на уредот.')),
    );
  }

  Future<void> _generateInsight() async {
    setState(() {
      _isGeneratingInsight = true;
      _aiInsight = null;
    });

    try {
      final insight = await MotivaAIService.instance.generateJournalInsight(
        JournalEntry(
          date: _selectedDate,
          mood: _entry.mood,
          activities: _entry.activities,
          note: _noteController.text.trim(),
        ),
      );

      if (!mounted) return;
      setState(() => _aiInsight = insight);
    } finally {
      if (mounted) setState(() => _isGeneratingInsight = false);
    }
  }

  void _setMood(int mood) {
    setState(() {
      _entry = JournalEntry(
        date: _entry.date,
        mood: mood,
        activities: _entry.activities,
        note: _entry.note,
      );
    });
  }

  void _toggleActivity(String activity, bool value) {
    final activities = Map<String, bool>.from(_entry.activities)
      ..[activity] = value;
    setState(() {
      _entry = JournalEntry(
        date: _entry.date,
        mood: _entry.mood,
        activities: activities,
        note: _entry.note,
      );
    });
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}. '
        '${date.month.toString().padLeft(2, '0')}. ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дневник'),
        actions: [
          IconButton(
            onPressed: _selectDate,
            icon: const Icon(Icons.calendar_month_outlined),
            tooltip: 'Избери датум',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _formatDate(_selectedDate),
                      style: MotivaTypography.h2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _sectionTitle('Како се чувствувам?'),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(_moods.length, (index) {
                        final mood = index + 1;
                        return ChoiceChip(
                          label: Text(
                            _moods[index],
                            style: const TextStyle(fontSize: 28),
                          ),
                          selected: _entry.mood == mood,
                          onSelected: (_) => _setMood(mood),
                        );
                      }),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _sectionTitle('Што направив денес?'),
                    const SizedBox(height: AppSpacing.sm),
                    Card(
                      child: Column(
                        children: _activityLabels.map((activity) {
                          return CheckboxListTile(
                            value: _entry.activities[activity] ?? false,
                            title: Text(activity),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value) =>
                                _toggleActivity(activity, value ?? false),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _sectionTitle('Кратка белешка'),
                    const SizedBox(height: AppSpacing.sm),
                    TextField(
                      controller: _noteController,
                      minLines: 3,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        hintText: 'Што сакам да запомнам од денес?',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    FilledButton.icon(
                      onPressed: _isSaving ? null : _saveEntry,
                      icon: const Icon(Icons.save_outlined),
                      label: Text(
                        _isSaving ? 'Се зачувува...' : 'Зачувај запис',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.smart_toy_outlined),
                                const SizedBox(width: AppSpacing.sm),
                                const Expanded(child: Text('Motiva AI')),
                                if (_aiInsight != null)
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Поддршка и идеи за следниот чекор',
                              style: MotivaTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            FilledButton.icon(
                              onPressed: _isGeneratingInsight
                                  ? null
                                  : _generateInsight,
                              icon: const Icon(Icons.auto_awesome_outlined),
                              label: Text(
                                _isGeneratingInsight
                                    ? 'Се генерира...'
                                    : 'Генерирај совет',
                              ),
                            ),
                            if (_aiInsight != null) ...[
                              const SizedBox(height: AppSpacing.md),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(AppSpacing.md),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _aiInsight!,
                                  style: MotivaTypography.body,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title, style: MotivaTypography.h3);
  }
}
