import 'package:flutter/material.dart';

import '../../../core/ai/motiva_ai_service.dart';
import '../../../core/firebase/chat_history_repository.dart';
import '../../../theme/theme_exports.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  bool _isLoadingConversation = false;
  String? _conversationId;

  @override
  void initState() {
    super.initState();
    MotivaAIService.instance.resetWellnessChat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final rawText = _controller.text.trim();
    if (rawText.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': rawText});
      _controller.clear();
      _isLoading = true;
    });

    await _saveMessage('user', rawText);

    try {
      final reply = await MotivaAIService.instance.generateWellnessReply(
        rawText,
      );

      if (!mounted) return;

      setState(() {
        _messages.add({'role': 'ai', 'text': reply});
        _isLoading = false;
      });
      await _saveMessage('ai', reply);
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _messages.add({
          'role': 'ai',
          'text':
              'Обидете се повторно. Јас сум овде да ти помогнам да се почувствуваш малку полесно.',
        });
        _isLoading = false;
      });
    }
  }

  Future<void> _saveMessage(String role, String text) async {
    final repository = ChatHistoryRepository.instance;
    if (!repository.isAvailable) return;

    try {
      if (_conversationId == null) {
        if (role != 'user') return;
        _conversationId = await repository.createConversation(text);
      }
      final conversationId = _conversationId;
      if (conversationId != null) {
        await repository.addMessage(
          conversationId: conversationId,
          role: role,
          text: text,
        );
      }
    } catch (error) {
      debugPrint('Motiva chat history save error: $error');
    }
  }

  Future<void> _startNewConversation() async {
    MotivaAIService.instance.resetWellnessChat();
    setState(() {
      _conversationId = null;
      _messages.clear();
    });
  }

  Future<void> _showHistory() async {
    final repository = ChatHistoryRepository.instance;
    if (!repository.isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Историјата бара најавен корисник.')),
      );
      return;
    }

    try {
      final conversations = await repository.loadConversations();
      if (!mounted) return;

      final selected = await showModalBottomSheet<ChatConversation>(
        context: context,
        isScrollControlled: true,
        builder: (context) =>
            _ConversationHistorySheet(conversations: conversations),
      );
      if (selected != null) await _openConversation(selected);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Историјата не може да се вчита.')),
      );
      debugPrint('Motiva chat history load error: $error');
    }
  }

  Future<void> _openConversation(ChatConversation conversation) async {
    setState(() => _isLoadingConversation = true);
    try {
      final messages = await ChatHistoryRepository.instance.loadMessages(
        conversation.id,
      );
      if (!mounted) return;

      MotivaAIService.instance.restoreWellnessChat(messages);
      setState(() {
        _conversationId = conversation.id;
        _messages
          ..clear()
          ..addAll(
            messages.map(
              (message) => {'role': message.role, 'text': message.text},
            ),
          );
      });
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Разговорот не може да се отвори.')),
      );
      debugPrint('Motiva chat conversation load error: $error');
    } finally {
      if (mounted) setState(() => _isLoadingConversation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motiva AI'),
        actions: [
          IconButton(
            onPressed: _isLoading || _isLoadingConversation
                ? null
                : _showHistory,
            icon: const Icon(Icons.history_rounded),
            tooltip: 'Историја на разговори',
          ),
          IconButton(
            onPressed: _isLoading || _isLoadingConversation
                ? null
                : _startNewConversation,
            icon: const Icon(Icons.add_comment_outlined),
            tooltip: 'Нов разговор',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_isLoadingConversation) const LinearProgressIndicator(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['role'] == 'user';

                  return Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      padding: const EdgeInsets.all(AppSpacing.md),
                      constraints: const BoxConstraints(maxWidth: 320),
                      decoration: BoxDecoration(
                        color: isUser ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        message['text'] ?? '',
                        style: TextStyle(
                          color: isUser ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: LinearProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Што чувствуваш денес?',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton(
                    onPressed: _isLoading ? null : _sendMessage,
                    icon: const Icon(Icons.send_rounded),
                    tooltip: 'Испрати',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConversationHistorySheet extends StatelessWidget {
  const _ConversationHistorySheet({required this.conversations});

  final List<ChatConversation> conversations;

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<ChatConversation>>{};
    for (final conversation in conversations) {
      groups
          .putIfAbsent(_periodFor(conversation.updatedAt), () => [])
          .add(conversation);
    }

    const groupOrder = ['Денес', 'Оваа недела', 'Овој месец', 'Постари'];
    final visibleGroups = groupOrder
        .where((group) => groups[group]?.isNotEmpty ?? false)
        .toList();

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.75,
        child: conversations.isEmpty
            ? const Center(child: Text('Сè уште нема зачувани разговори.'))
            : ListView(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                children: [
                  for (final group in visibleGroups) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.md,
                        AppSpacing.xs,
                      ),
                      child: Text(
                        group,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    for (final conversation in groups[group]!)
                      ListTile(
                        leading: const Icon(Icons.chat_bubble_outline),
                        title: Text(
                          conversation.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(_formatDate(conversation.updatedAt)),
                        onTap: () => Navigator.pop(context, conversation),
                      ),
                  ],
                ],
              ),
      ),
    );
  }

  String _periodFor(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final conversationDay = DateTime(date.year, date.month, date.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));

    if (conversationDay == today) return 'Денес';
    if (!conversationDay.isBefore(weekStart)) return 'Оваа недела';
    if (date.year == now.year && date.month == now.month) return 'Овој месец';
    return 'Постари';
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}.'
      '${date.month.toString().padLeft(2, '0')}.'
      '${date.year}';
}
