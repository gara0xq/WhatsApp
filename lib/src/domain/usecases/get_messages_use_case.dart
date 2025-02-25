import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository _repository;

  GetMessagesUseCase(this._repository);

  Stream<List<Message>> call(String chatId) {
    return _repository.fetchMessages(chatId);
  }
}