import '../repo/chat_repository.dart';

class ManageTypingStatusUseCase {
  final ChatRepository _chatRepository;

  ManageTypingStatusUseCase(this._chatRepository);

  Future<void> setTypingStatus(String chatId, String userId) async {
    await _chatRepository.setTypingStatus(chatId, userId);
  }

  Future<void> clearTypingStatus(String chatId, String userId) async {
    await _chatRepository.clearTypingStatus(chatId, userId);
  }
}
