import '../repo/search_repository.dart';

class GetChatIdUseCase {
  final SearchRepository _searchRepository;

  GetChatIdUseCase(this._searchRepository);

  Future<String?> call(String user1Id, String user2Id) {
    return _searchRepository.getChatId(user1Id, user2Id);
  }
}
