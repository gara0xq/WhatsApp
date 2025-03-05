import '../../../../core/domain/entities/chat.dart';

import '../repo/chat_repository.dart';

class CreateChatUseCase {
  final ChatRepository _chatRepository;

  CreateChatUseCase(this._chatRepository);

  Future<Chat> call(String user1Id, String user2Id) async {
    return _chatRepository.createChat(user1Id, user2Id);
  }
}
