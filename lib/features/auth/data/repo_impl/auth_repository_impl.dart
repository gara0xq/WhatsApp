import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/data/models/user_model.dart';
import '../../domain/repo/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final supabase = Supabase.instance.client;

  String? userId;

  @override
  Future<void> signInWithPhone(String phoneNumber) async {
    await supabase.auth.signInWithOtp(phone: phoneNumber);
  }

  @override
  Future<User?> verifyOtp(String otp, String phoneNumber) async {
    try {
      final response = await supabase.auth.verifyOTP(
        type: OtpType.sms,
        token: otp,
        phone: phoneNumber,
      );

      if (response.user != null) {
        userId = response.user!.id;
      }

      return response.user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel?> getUser(String id) async {
    final user = await supabase.from('users').select().eq('user_id', id);

    if (user.isEmpty) {
      return null;
    } else {
      return UserModel.fromMap(user.first);
    }
  }

  @override
  Future<void> addUser(String id, String name, String profilePic) async {
    final newUser = UserModel(
      userId: id,
      displayName: name,
      lastSeen: DateTime.now(),
      publicKey: "",
      profilePic: profilePic,
    );
    await supabase.from('users').insert(newUser.toMap());
  }

  @override
  Future<User?> signUpWithEmail(String email, String password) async {
    var response = await supabase.auth.signUp(email: email, password: password);

    return response.user;
  }

  @override
  Future<User?> signInWithEmail(String email, String password) async {
    var response = await supabase.auth
        .signInWithPassword(email: email, password: password);
    return response.user;
  }
}
