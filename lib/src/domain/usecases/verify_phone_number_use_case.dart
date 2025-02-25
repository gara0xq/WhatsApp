import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/auth_repository.dart';

class VerifyPhoneNumberUseCase {
  final AuthRepository _authRepository;

  VerifyPhoneNumberUseCase(this._authRepository);

  Future<User?> call(String otp, String phoneNumber) async {
    return _authRepository.verifyOtp(otp, phoneNumber);
  }
}