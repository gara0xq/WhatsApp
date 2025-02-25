import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<void> signInWithPhone(String phoneNumber);
  Future<User?> verifyOtp(String otp, String phoneNumber);
  Future<UserModel?> getUser(String id);
  Future<void> addUser(String id, String name, String profilePic);
}
