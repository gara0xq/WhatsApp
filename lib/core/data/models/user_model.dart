import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.userId,
    required super.displayName,
    super.profilePic,
    super.status,
    required super.lastSeen,
    required super.publicKey,
    super.deviceId,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'],
      displayName: map['display_name'],
      profilePic: map['profile_pic'],
      status: map['status'],
      lastSeen: DateTime.parse(map['last_seen']),
      publicKey: map['public_key'],
      deviceId: map['device_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'display_name': displayName,
      'profile_pic': profilePic,
      'status': status,
      'last_seen': lastSeen.toIso8601String(),
      'public_key': publicKey,
      'device_id': deviceId,
    };
  }
}
