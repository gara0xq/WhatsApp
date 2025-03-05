import '../../../../core/domain/entities/user.dart';
import '../repo/search_repository.dart';

class GetUsersUseCase {
  final SearchRepository _searchRepository;

  GetUsersUseCase(this._searchRepository);

  Future<List<UserEntity>> call() {
    return _searchRepository.fetchUsers();
  }
}
