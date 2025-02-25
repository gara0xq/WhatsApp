class Media {
  final String mediaId;
  final String messageId;
  final String senderId;
  final String mediaUrl;
  final String mediaType;
  final DateTime uploadedAt;

  Media({
    required this.mediaId,
    required this.messageId,
    required this.senderId,
    required this.mediaUrl,
    required this.mediaType,
    required this.uploadedAt,
  });
}
