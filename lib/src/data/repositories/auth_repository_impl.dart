import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

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
        log(userId.toString());
      }

      return response.user;
    } catch (e) {
      log(e.toString());
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
}
