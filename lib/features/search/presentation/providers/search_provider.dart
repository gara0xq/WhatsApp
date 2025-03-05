import 'package:get/get.dart';
import '../../domain/usecases/get_chat_id_use_case.dart';
import '../../data/repo_impl/search_repository_impl.dart';
import '../../domain/usecases/get_users_use_case.dart';
import '../../../../core/domain/entities/user.dart';

class SearchProvider extends GetxController {
  final GetUsersUseCase _getUsersUseCase;
  final GetChatIdUseCase _getChatIdUseCase;
  final String userId;
  SearchProvider({required this.userId})
      : _getUsersUseCase = GetUsersUseCase(SearchRepositoryImpl()),
        _getChatIdUseCase = GetChatIdUseCase(SearchRepositoryImpl());

  List<UserEntity> users = [];
  RxList<UserEntity> filterdUsers = <UserEntity>[].obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  fetchUsers() async {
    users = await _getUsersUseCase.call();
    filterdUsers.value = users.where((e) => e.userId != userId).toList();
  }

  filterUsers(String searchText) {
    filterdUsers.value = users
        .where((e) =>
            e.userId != userId &&
            e.displayName.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  Future<String?> getChatId(String user1Id, String user2Id) async {
    final x = await _getChatIdUseCase(user1Id, user2Id);
    return x;
  }
}
