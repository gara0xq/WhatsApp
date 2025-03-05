import '../../domain/entities/group_member.dart';

class GroupMemberModel extends GroupMember {
  GroupMemberModel({
    required super.groupId,
    required super.userId,
    required super.joinedAt,
  });

  factory GroupMemberModel.fromMap(Map<String, dynamic> map) {
    return GroupMemberModel(
      groupId: map['group_id'],
      userId: map['user_id'],
      joinedAt: DateTime.parse(map['joined_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'group_id': groupId,
      'user_id': userId,
      'joined_at': joinedAt.toIso8601String(),
    };
  }
}
