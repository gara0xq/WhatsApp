import 'package:get/get.dart';
import '../../domain/usecases/fetch_chats_use_case.dart';
import '../../domain/usecases/listen_to_chats_use_case.dart';
import '../../domain/usecases/reformat_message_datetime_use_case.dart';
import '../../data/repo_impl/home_repository_impl.dart';
import '../../../../core/domain/entities/chat.dart';

class HomeProvider extends GetxController {
  final FetchChatsUseCase fetchChatsUseCase;
  final ListenToChatsUseCase listenToChatsUseCase;
  final ReformatMessageDatetimeUseCase reformatMessageDatetimeUseCase;

  var chats = <Chat>[].obs;
  final String currentUserId;

  HomeProvider(this.currentUserId)
      : fetchChatsUseCase =
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

  void fetchChats() async {
    chats.assignAll(await fetchChatsUseCase(currentUserId));
  }

  void listenToChats() {
    listenToChatsUseCase.call(currentUserId).listen((updatedChats) {
      chats.assignAll(updatedChats);
    });
  }

  String reformatMessageDateTime(dateTime) {
    return reformatMessageDatetimeUseCase(dateTime);
  }
}
