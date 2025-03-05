import '../../domain/entities/media.dart';

class MediaModel extends Media {
  MediaModel({
    required super.mediaId,
    required super.messageId,
    required super.senderId,
    required super.mediaUrl,
    required super.mediaType,
    required super.uploadedAt,
  });

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      mediaId: map['media_id'],
      messageId: map['message_id'],
      senderId: map['sender_id'],
      mediaUrl: map['media_url'],
      mediaType: map['media_type'],
      uploadedAt: DateTime.parse(map['uploaded_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'media_id': mediaId,
      'message_id': messageId,
      'sender_id': senderId,
      'media_url': mediaUrl,
      'media_type': mediaType,
      'uploaded_at': uploadedAt.toIso8601String(),
    };
  }
}
