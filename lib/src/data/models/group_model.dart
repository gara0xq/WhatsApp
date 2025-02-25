import '../../domain/entities/group.dart';

class GroupModel extends Group {
  GroupModel({
    required super.groupId,
    required super.groupName,
    required super.adminId,
    super.groupIcon,
    required super.createdAt,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      groupId: map['group_id'],
      groupName: map['group_name'],
      adminId: map['admin_id'],
      groupIcon: map['group_icon'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'group_id': groupId,
      'group_name': groupName,
      'admin_id': adminId,
      'group_icon': groupIcon,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
