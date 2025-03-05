import '../../../../core/domain/entities/message.dart';
import '../repo/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);
  Future<void> call(Message message) async {
    return _chatRepository.sendMessage(message);
  }
}
