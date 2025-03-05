import '../../../../core/domain/entities/message.dart';
import '../../../chat/domain/repo/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository _chatRepository;

  GetMessagesUseCase(this._chatRepository);

  Stream<List<Message>> call(String chatId) {
    return _chatRepository.fetchMessages(chatId);
  }
}
