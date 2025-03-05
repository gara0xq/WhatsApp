import 'package:supabase_flutter/supabase_flutter.dart';

import '../repo/auth_repository.dart';

class SignupWithEmailUseCase {
  final AuthRepository _authRepository;

  SignupWithEmailUseCase(this._authRepository);

  Future<User?> call(String email, String password) async {
    return await _authRepository.signUpWithEmail(email, password);
  }
}
