import '../../../../core/domain/entities/user.dart';

abstract class SearchRepository {
  Future<List<UserEntity>> fetchUsers();
  Future<String?> getChatId(String user1Id, String user2Id);
}
