import '../repositories/auth_repository.dart';

class EnterPhoneNumberUseCase {
  final AuthRepository _authRepository;

  EnterPhoneNumberUseCase(this._authRepository);

  Future<void> call(String phoneNumber) async {
    await _authRepository.signInWithPhone(phoneNumber);
  }
}
