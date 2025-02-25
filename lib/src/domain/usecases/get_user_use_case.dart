import '../../data/models/user_model.dart';

import '../repositories/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository _authRepository;

  GetUserUseCase(this._authRepository);

  Future<UserModel?> call(String userId) async {
    return await _authRepository.getUser(userId);
  }
}
