import '../entities/chat.dart';

import '../repositories/home_repository.dart';

class ListenToChatsUseCase {
  final HomeRepository _homeRepository;

  ListenToChatsUseCase(this._homeRepository);

  Stream<List<Chat>> call(String currentUserId) {
    return _homeRepository.getChatsStream(currentUserId);
  }
}