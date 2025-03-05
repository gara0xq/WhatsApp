import '../../../../core/domain/entities/chat.dart';
import '../repo/home_repository.dart';

class FetchChatsUseCase {
  final HomeRepository _homeRepository;

  FetchChatsUseCase(this._homeRepository);

  Future<List<Chat>> call(String currentUserId) async {
    return _homeRepository.fetchChats(currentUserId);
  }
}
