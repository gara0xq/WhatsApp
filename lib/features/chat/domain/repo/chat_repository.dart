import '../../../../core/domain/entities/chat.dart';

import '../../../../core/domain/entities/message.dart';

abstract class ChatRepository {
  Stream<List<Message>> fetchMessages(String chatId);
  Future<void> sendMessage(Message message);
  Future<void> setTypingStatus(String chatId, String userId);
  Future<void> clearTypingStatus(String chatId, String userId);
  Stream<List<String>> listenTypingStatus(String chatId);
  Future<Chat> createChat(String user1Id, String user2Id);
}
