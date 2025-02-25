import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';

import '../../domain/entities/message.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/group.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final supabase = Supabase.instance.client;
  final _chatStreamController = StreamController<List<Chat>>.broadcast();
  HomeRepositoryImpl(userId) {
    listenToChatUpdates(userId);
  }
  @override
  Stream<List<Group>> getGroubs(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<void> createChat(String user1Id, String user2Id) async {
    await supabase.from('chats').insert({
      'user1_id': user1Id,
      'user2_id': user2Id,
    });
  }

  @override
  Future<List<Chat>> fetchChats(String currentUserId) async {
    try {
      final response = await supabase
          .from('chats')
          .select()
          .or('user1_id.eq.$currentUserId,user2_id.eq.$currentUserId')
          .order('last_updated', ascending: true);
      List<Chat> chatList = [];

      for (var chat in response) {
        String oppositeUserId = (chat['user1_id'] == currentUserId)
            ? chat['user2_id']
            : chat['user1_id'];

        chatList.add(
          Chat(
            chatId: chat['chat_id'],
            user1Id: await getUser(oppositeUserId),
            user2Id: await getUser(currentUserId),
            lastMessageId: await getLastMessage(chat['last_message_id']),
            countUnseenMessages: await getCountUnseenMessages(chat['chat_id']),
          ),
        );
      }

      return chatList;
    } catch (e) {
      Get.snackbar("Error", "Failed to load chats: $e");
      log("Failed to load chats: $e");
      return [];
    }
  }

  @override
  Stream<List<Chat>> getChatsStream(String userId) {
    return _chatStreamController.stream;
  }

  void listenToChatUpdates(String currentUserId) {
    supabase
        .channel('public:chats')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'chats',
          callback: (payload) async {
            log("Chat updated: ${payload.newRecord}");
            fetchChats(currentUserId);
            _chatStreamController.add(await fetchChats(currentUserId));
          },
        )
        .subscribe();
  }

  @override
  String reFormatMessageDateTime(dateTime) {
    String today = DateFormat('d/M/yy').format(DateTime.now());
    String yesterday = DateFormat('d/M/yy').format(
      DateTime.now().add(Duration(days: -1)),
    );

    String date = DateFormat('d/M/yy').format(dateTime);
    date = today == date
        ? DateFormat('h:mm a').format(dateTime)
        : date == yesterday
            ? "Yesterday"
            : today;

    return date;
  }

  Future<UserEntity> getUser(String userId) async {
    final userResponse =
        await supabase.from('users').select().eq('user_id', userId).single();
    return UserModel.fromMap(userResponse);
  }

  Future<Message> getLastMessage(String messageId) async {
    final lastMessageResponse = await supabase
        .from('messages')
        .select()
        .eq('message_id', messageId)
        .single();
    return MessageModel.fromMap(lastMessageResponse);
  }

  Future<int> getCountUnseenMessages(String chatId) async {
    final response = await supabase
        .from('messages')
        .select()
        .eq('chat_id', chatId)
        .or('status.eq.sent,status.eq.delivered')
        .count();
    return response.count;
  }
}
