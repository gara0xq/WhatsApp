import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/user_typing_use_case.dart';
import '../../domain/usecases/get_messages_use_case.dart';
import '../../domain/usecases/send_message_usecase.dart';

class ChatProvider extends GetxController {
  final supabase = Supabase.instance.client;
  @override
  void onInit() {
    // signInWithPhone("+201200019283");
    super.onInit();
  }

  Future<void> signInWithPhone(String phoneNumber) async {
    await supabase.auth.signInWithOtp(phone: phoneNumber);
  }

  final CheckUserTypingUseCase checkUserTypingUseCase;
  final SetUserTypingUseCase setUserTypingUseCase;

  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  var isUserTyping = false.obs;
  var messages = <Message>[].obs;

  ChatProvider()
      : checkUserTypingUseCase = CheckUserTypingUseCase(ChatRepositoryImpl()),
        setUserTypingUseCase = SetUserTypingUseCase(ChatRepositoryImpl()),
        getMessagesUseCase = GetMessagesUseCase(ChatRepositoryImpl()),
        sendMessageUseCase = SendMessageUseCase(ChatRepositoryImpl());

  void updateTyping(bool isTyping) {
    setUserTypingUseCase(isTyping);
    isUserTyping.value = isTyping;
  }

  Stream<List<Message>> getMessagesStream(String chatId) {
    return getMessagesUseCase(chatId);
  }

  void sendMessage(Message message) {
    sendMessageUseCase(message);
  }
}
