import 'dart:developer';

import 'package:get/get.dart';
import 'package:whatsapp/src/domain/entities/user.dart';
import 'package:whatsapp/src/domain/usecases/fetch_chats_use_case.dart';
import 'package:whatsapp/src/domain/usecases/listen_to_chats_use_case.dart';
import 'package:whatsapp/src/domain/usecases/reformat_message_datetime_use_case.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/usecases/create_chat_use_case.dart';
import '../../domain/entities/chat.dart';

class HomeProvider extends GetxController {
  final CreateChatUseCase createChatUseCase;
  final FetchChatsUseCase fetchChatsUseCase;
  final ListenToChatsUseCase listenToChatsUseCase;
  final ReformatMessageDatetimeUseCase reformatMessageDatetimeUseCase;

  var chats = <Chat>[].obs;
  final String currentUserId;

  HomeProvider(this.currentUserId)
      : createChatUseCase =
            CreateChatUseCase(HomeRepositoryImpl(currentUserId)),
        fetchChatsUseCase =
            FetchChatsUseCase(HomeRepositoryImpl(currentUserId)),
        listenToChatsUseCase =
            ListenToChatsUseCase(HomeRepositoryImpl(currentUserId)),
        reformatMessageDatetimeUseCase =
            ReformatMessageDatetimeUseCase(HomeRepositoryImpl(currentUserId));

  @override
  void onInit() {
    fetchChats();
    listenToChats();
    super.onInit();
  }

  void createChat(String user1Id, String user2Id) {
    createChatUseCase(user1Id, user2Id);
  }

  void fetchChats() async {
    chats.assignAll(await fetchChatsUseCase(currentUserId));
  }

  void listenToChats() {
    listenToChatsUseCase.call(currentUserId).listen((updatedChats) {
      log(updatedChats.toString());
      chats.assignAll(updatedChats);
    });
  }

  String reformatMessageDateTime(dateTime) {
    return reformatMessageDatetimeUseCase(dateTime);
  }
}
