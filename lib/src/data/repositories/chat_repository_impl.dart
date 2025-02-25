import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/message.dart';

import '../../domain/repositories/chat_repository.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  bool _isTyping = false;
  final List<Message> _messages = [];
  final StreamController<List<Message>> _messagesController =
      StreamController.broadcast();
  final supabase = Supabase.instance.client;

  @override
  void setUserTyping(bool isTyping) {
    _isTyping = isTyping;
  }

  @override
  bool isUserTyping() {
    return _isTyping;
  }

  @override
  Stream<List<Message>> fetchMessages(String chatId) {
    return supabase
        .from('messages')
        .stream(primaryKey: ['message_id'])
        .eq('chat_id', chatId)
        .order('timestamp', ascending: true)
        .map(
          (data) => data.map((e) => MessageModel.fromMap(e)).toList(),
        );
  }

  @override
  Future<void> sendMessage(Message message) async {
    _messages.add(message);
    _messagesController.add(_messages);
  }
}
