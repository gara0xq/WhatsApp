import '../repo/auth_repository.dart';

class AddUserUseCase {
  final AuthRepository _authRepository;

  AddUserUseCase(this._authRepository);

  Future<void> call(String id, String name, profilePic) async {
    await _authRepository.addUser(id, name, profilePic);
  }
}
