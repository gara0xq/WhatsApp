import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/data/models/user_model.dart';

abstract class AuthRepository {
  Future<void> signInWithPhone(String phoneNumber);
  Future<User?> verifyOtp(String otp, String phoneNumber);
  Future<UserModel?> getUser(String id);
  Future<void> addUser(String id, String name, String profilePic);
  Future<User?> signUpWithEmail(String email, String password);
  Future<User?> signInWithEmail(String email, String password);
}
