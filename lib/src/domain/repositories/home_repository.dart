import '../entities/chat.dart';
import '../entities/group.dart';

abstract class HomeRepository {
  Stream<List<Group>> getGroubs(String userId);
  Future<void> createChat(String user1Id, String user2Id);
  Future<List<Chat>> fetchChats(String currentUserId);
  Stream<List<Chat>> getChatsStream(String userId);
  String reFormatMessageDateTime(dateTime);
}
