import '../entities/message.dart';

abstract class ChatRepository {
  void setUserTyping(bool isTyping);
  bool isUserTyping();
  Stream<List<Message>> fetchMessages(String chatId);
  Future<void> sendMessage(Message message);
}