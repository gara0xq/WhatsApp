import '../entities/chat.dart';
import '../repositories/home_repository.dart';

class FetchChatsUseCase {
  final HomeRepository _homeRepository;

  FetchChatsUseCase(this._homeRepository);

  Future<List<Chat>> call(String currentUserId) async {
    return _homeRepository.fetchChats(currentUserId);
  }
}