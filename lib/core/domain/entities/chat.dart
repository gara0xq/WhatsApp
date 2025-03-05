import 'message.dart';
import 'user.dart';

class Chat {
  final String chatId;
  final UserEntity user1Id;
  final UserEntity user2Id;
  final Message? lastMessageId;
  final DateTime? lastUpdated;
  final int countUnseenMessages;

  Chat({
    required this.chatId,
    required this.user1Id,
    required this.user2Id,
    this.lastMessageId,
    this.lastUpdated,
    this.countUnseenMessages = 0,
  });
}
