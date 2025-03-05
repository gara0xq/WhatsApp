import '../../../../core/domain/entities/chat.dart';

import '../repo/home_repository.dart';

class ListenToChatsUseCase {
  final HomeRepository _homeRepository;

  ListenToChatsUseCase(this._homeRepository);

  Stream<List<Chat>> call(String currentUserId) {
    return _homeRepository.getChatsStream(currentUserId);
  }
}
