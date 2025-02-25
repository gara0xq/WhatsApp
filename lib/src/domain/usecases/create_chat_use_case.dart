import '../repositories/home_repository.dart';

class CreateChatUseCase {
  final HomeRepository _homeRepository;

  CreateChatUseCase(this._homeRepository);

  Future<void> call(String user1Id, String user2Id) async {
    return _homeRepository.createChat(user1Id, user2Id);
  }
}