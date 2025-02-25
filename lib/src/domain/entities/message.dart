class Message {
  final String messageId;
  final String chatId;
  final String senderId;
  final String receiverId;
  final String message;
  final String messageType;
  final String? mediaUrl;
  final DateTime timestamp;
  final String status;
  final bool isDeleted;

  Message({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.messageType,
    this.mediaUrl,
    required this.timestamp,
    required this.status,
    this.isDeleted = false,
  });
}
