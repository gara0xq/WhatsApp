import '../../domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    super.messageId,
    required super.chatId,
    required super.senderId,
    required super.receiverId,
    required super.message,
    required super.messageType,
    super.mediaUrl,
    required super.timestamp,
    required super.status,
    super.isDeleted,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['message_id'],
      chatId: map['chat_id'],
      senderId: map['sender_id'],
      receiverId: map['receiver_id'],
      message: map['message'],
      messageType: map['message_type'],
      mediaUrl: map['media_url'],
      timestamp: DateTime.parse(map['timestamp']),
      status: map['status'],
      isDeleted: map['is_deleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chat_id': chatId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
      'message_type': messageType,
      'media_url': mediaUrl,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'is_deleted': isDeleted,
    };
  }
}
