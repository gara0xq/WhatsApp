import 'package:supabase_flutter/supabase_flutter.dart';

import '../repo/auth_repository.dart';

class SigninWithEmailUseCase {
  final AuthRepository _authRepository;

  SigninWithEmailUseCase(this._authRepository);

  Future<User?> call(String email, String password) async {
    return await _authRepository.signInWithEmail(email, password);
  }
}
