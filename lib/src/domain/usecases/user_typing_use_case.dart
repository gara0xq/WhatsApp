import '../repositories/chat_repository.dart';

class CheckUserTypingUseCase {
  final ChatRepository repository;

  CheckUserTypingUseCase(this.repository);

  bool call() {
    return repository.isUserTyping();
  }
}

class SetUserTypingUseCase {
  final ChatRepository repository;

  SetUserTypingUseCase(this.repository);

  void call(bool isTyping) {
    repository.setUserTyping(isTyping);
  }
}