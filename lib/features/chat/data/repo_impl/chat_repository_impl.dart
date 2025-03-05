import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/data/models/chat_model.dart';
import '../../../../core/domain/entities/chat.dart';
import '../../../../core/domain/entities/message.dart';

import '../../domain/repo/chat_repository.dart';
import '../../../../core/data/models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final supabase = Supabase.instance.client;

  bool isTyping = false;
  final List<Message> _messages = [];
  final StreamController<List<Message>> _messagesController =
      StreamController.broadcast();

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
    final MessageModel messageModel = MessageModel(
      chatId: message.chatId,
      senderId: message.senderId,
      receiverId: message.receiverId,
      message: message.message,
      messageType: message.messageType,
      timestamp: message.timestamp,
      status: message.status,
    );
    final response =
        await supabase.from('messages').insert(messageModel.toMap());
  }

  @override
  Future<void> setTypingStatus(String chatId, String userId) async {
    final response = await Supabase.instance.client
        .from('chats')
        .select('typing_users')
        .eq('chat_id', chatId)
        .single();

    List<String> typingUsers =
        List<String>.from(response['typing_users'] ?? []);

    if (!typingUsers.contains(userId)) {
      typingUsers.add(userId);
    }

    await Supabase.instance.client
        .from('chats')
        .update({'typing_users': typingUsers}).eq('chat_id', chatId);
  }

  @override
  Future<void> clearTypingStatus(String chatId, String userId) async {
    final response = await Supabase.instance.client
        .from('chats')
        .select('typing_users')
        .eq('chat_id', chatId)
        .single();

    List<String> typingUsers =
        List<String>.from(response['typing_users'] ?? []);

    typingUsers.remove(userId);

    await Supabase.instance.client
        .from('chats')
        .update({'typing_users': typingUsers}).eq('chat_id', chatId);
  }

  @override
  Stream<List<String>> listenTypingStatus(String chatId) {
    return Supabase.instance.client
        .from('chats')
        .stream(primaryKey: ['chat_id'])
        .eq('chat_id', chatId)
        .map((data) => List<String>.from(data.first['typing_users'] ?? []));
  }

  @override
  Future<Chat> createChat(String user1Id, String user2Id) async {
    final response = await supabase.from('chats').insert({
      'user1_id': await supabase.from('users').select().eq("user_id", user1Id),
      'user2_id': await supabase.from('users').select().eq("user_id", user2Id),
      'last_message_id': "db18582b-ad39-4e41-8bee-630cda5f9499",
    });
    return ChatModel.fromMap(response);
  }
}
