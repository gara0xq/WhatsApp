import 'dart:async';

import 'package:get/get.dart';
import '../../../../core/data/models/message_model.dart';
import '../../../../core/domain/entities/chat.dart';
import '../../domain/usecases/create_chat_use_case.dart';
import '../../data/repo_impl/chat_repository_impl.dart';
import '../../../../core/domain/entities/message.dart';
import '../../domain/usecases/listen_typing_status_use_case.dart';
import '../../domain/usecases/manage_typing_status_use_case.dart';
import '../../domain/usecases/get_messages_use_case.dart';
import '../../domain/usecases/send_message_usecase.dart';

class ChatProvider extends GetxController {
  var isUserTyping = false.obs;
  var messages = <Message>[].obs;
  var typingUsers = <String>[].obs;

  StreamSubscription<List<String>>? _typingSubscription;

  final GetMessagesUseCase _getMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase;

  final ManageTypingStatusUseCase _manageTypingStatus;
  final ListenTypingStatusUseCase _listenTypingStatus;

  final CreateChatUseCase _createChatUseCase;

  ChatProvider()
      : _getMessagesUseCase = GetMessagesUseCase(ChatRepositoryImpl()),
        _sendMessageUseCase = SendMessageUseCase(ChatRepositoryImpl()),
        _manageTypingStatus = ManageTypingStatusUseCase(ChatRepositoryImpl()),
        _listenTypingStatus = ListenTypingStatusUseCase(ChatRepositoryImpl()),
        _createChatUseCase = CreateChatUseCase(ChatRepositoryImpl());

  void updateTyping(bool isTyping) {
    if (isUserTyping.value != isTyping) isUserTyping.value = isTyping;
    update();
  }

  Stream<List<Message>> getMessagesStream(String chatId) {
    return _getMessagesUseCase(chatId);
  }

  void sendMessage(MessageModel message) {
    _sendMessageUseCase(message);
  }

  void startListeningTyping(String chatId) {
    _typingSubscription?.cancel();
    _typingSubscription = _listenTypingStatus.execute(chatId).listen((users) {
      typingUsers.assignAll(users);
    });
  }

  void setTypingStatus(String chatId, String userId) {
    _manageTypingStatus.setTypingStatus(chatId, userId);

    Timer(Duration(seconds: 10), () {
      clearTypingStatus(chatId, userId);
    });
  }

  void clearTypingStatus(String chatId, String userId) {
    _manageTypingStatus.clearTypingStatus(chatId, userId);
  }

  Future<Chat> createChat(
      String user1Id, String user2Id, String message) async {
    final chat = await _createChatUseCase.call(user1Id, user2Id);
    sendMessage(
      MessageModel(
        chatId: chat.chatId,
        senderId: user1Id,
        receiverId: user2Id,
        message: message,
        messageType: "text",
        timestamp: DateTime.now(),
        status: "sent",
      ),
    );
    return chat;
  }

  @override
  void onClose() {
    messages.clear();
    _typingSubscription?.cancel();
    super.onClose();
  }
}
