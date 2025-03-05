import '../../../chat/domain/repo/chat_repository.dart';

class ListenTypingStatusUseCase {
  final ChatRepository _chatRepository;

  ListenTypingStatusUseCase(this._chatRepository);

  Stream<List<String>> execute(String chatId) {
    return _chatRepository.listenTypingStatus(chatId);
  }
}
