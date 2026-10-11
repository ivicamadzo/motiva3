import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_support.dart';

class ChatConversation {
  const ChatConversation({
    required this.id,
    required this.title,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final DateTime updatedAt;
}

class ChatMessageRecord {
  const ChatMessageRecord({
    required this.id,
    required this.role,
    required this.text,
    required this.createdAt,
  });

  final String id;
  final String role;
  final String text;
  final DateTime createdAt;
}

class ChatHistoryRepository {
  ChatHistoryRepository._();

  static final ChatHistoryRepository instance = ChatHistoryRepository._();

  bool get isAvailable =>
      FirebaseSupport.isEnabled && FirebaseSupport.auth.currentUser != null;

  CollectionReference<Map<String, dynamic>> _conversations(String uid) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('conversations');

  Future<List<ChatConversation>> loadConversations() async {
    final uid = FirebaseSupport.auth.currentUser?.uid;
    if (!isAvailable || uid == null) return const [];

    final snapshot = await _conversations(
      uid,
    ).orderBy('updatedAt', descending: true).get();

    return snapshot.docs.map((document) {
      final data = document.data();
      return ChatConversation(
        id: document.id,
        title: data['title'] as String? ?? 'Нов разговор',
        updatedAt: _dateFrom(data['updatedAt']),
      );
    }).toList();
  }

  Future<List<ChatMessageRecord>> loadMessages(String conversationId) async {
    final uid = FirebaseSupport.auth.currentUser?.uid;
    if (!isAvailable || uid == null) return const [];

    final snapshot = await _conversations(
      uid,
    ).doc(conversationId).collection('messages').orderBy('createdAt').get();

    return snapshot.docs.map((document) {
      final data = document.data();
      return ChatMessageRecord(
        id: document.id,
        role: data['role'] as String? ?? 'ai',
        text: data['text'] as String? ?? '',
        createdAt: _dateFrom(data['createdAt']),
      );
    }).toList();
  }

  Future<String?> createConversation(String firstMessage) async {
    final uid = FirebaseSupport.auth.currentUser?.uid;
    if (!isAvailable || uid == null) return null;

    final conversation = _conversations(uid).doc();
    final title = firstMessage.trim().replaceAll(RegExp(r'\s+'), ' ');
    await conversation.set({
      'title': title.length > 60 ? '${title.substring(0, 57)}...' : title,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'lastMessage': firstMessage,
    });
    return conversation.id;
  }

  Future<void> addMessage({
    required String conversationId,
    required String role,
    required String text,
  }) async {
    final uid = FirebaseSupport.auth.currentUser?.uid;
    if (!isAvailable || uid == null) return;

    final conversation = _conversations(uid).doc(conversationId);
    final message = conversation.collection('messages').doc();
    final batch = FirebaseFirestore.instance.batch();
    batch.set(message, {
      'role': role,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
    batch.update(conversation, {
      'updatedAt': FieldValue.serverTimestamp(),
      'lastMessage': text,
    });
    await batch.commit();
  }

  DateTime _dateFrom(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return DateTime.fromMillisecondsSinceEpoch(0);
  }
}
