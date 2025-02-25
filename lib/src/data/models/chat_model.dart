import '../../domain/entities/chat.dart';

class ChatModel extends Chat {
  ChatModel({
    required super.chatId,
    required super.user1Id,
    required super.user2Id,
    super.lastMessageId,
    super.lastUpdated,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chat_id'],
      user1Id: map['user1_id'],
      user2Id: map['user2_id'],
      lastMessageId: map['last_message_id'],
      lastUpdated: DateTime.parse(map['last_updated']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chat_id': chatId,
      'user1_id': user1Id,
      'user2_id': user2Id,
      'last_message_id': lastMessageId,
      'last_updated': lastUpdated.toString(),
    };
  }
}
