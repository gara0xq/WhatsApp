class UserEntity {
  final String userId;
  final String displayName;
  final String? profilePic;
  final String status;
  final DateTime lastSeen;
  final String publicKey;
  final String? deviceId;

  UserEntity({
    required this.userId,
    required this.displayName,
    this.profilePic,
    this.status = "Hey there! I am using WhatsApp.",
    required this.lastSeen,
    required this.publicKey,
    this.deviceId,
  });
}
