class Group {
  final String groupId;
  final String groupName;
  final String adminId;
  final String? groupIcon;
  final DateTime createdAt;

  Group({
    required this.groupId,
    required this.groupName,
    required this.adminId,
    this.groupIcon,
    required this.createdAt,
  });
}
