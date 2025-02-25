import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/home_screen.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/add_user_use_case.dart';
import '../../domain/usecases/enter_phone_number_use_case.dart';
import '../../domain/usecases/get_user_use_case.dart';
import '../../domain/usecases/verify_phone_number_use_case.dart';

class AuthProvider extends GetxController {
  final EnterPhoneNumberUseCase enterPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final GetUserUseCase getUserUsseCase;
  final AddUserUseCase addUserUseCase;

  final fomKey = GlobalKey<FormState>();

  String _phoneNumber = '';

  User? _userAuth;

  UserModel? userModel;

  ValueNotifier userNotifier = ValueNotifier<bool>(false);

  AuthProvider()
      : enterPhoneNumberUseCase = EnterPhoneNumberUseCase(AuthRepositoryImpl()),
        verifyPhoneNumberUseCase =
            VerifyPhoneNumberUseCase(AuthRepositoryImpl()),
        getUserUsseCase = GetUserUseCase(AuthRepositoryImpl()),
        addUserUseCase = AddUserUseCase(AuthRepositoryImpl());

  void signInWithPhone(String phoneNumber) {
    if (fomKey.currentState!.validate()) {
      enterPhoneNumberUseCase(phoneNumber);
      Get.toNamed('/verify_number');
      _phoneNumber = phoneNumber;
    }
  }

  Future verifyOtp(String otp) async {
    if (fomKey.currentState!.validate()) {
      _userAuth = await verifyPhoneNumberUseCase.call(otp, _phoneNumber);
      if (_userAuth != null) {
        userModel = await getUserUsseCase(_userAuth!.id);
        log(userModel.toString());
        if (userModel != null) {
          userNotifier.value = true;
          log("user is here");
          Get.offAll(HomeScreen(userId: userModel!.userId));
        }
      } else {
        log('User not found');
      }
    }
  }

  void addUser(String name, String profilePic) {
    log(_userAuth.toString());
    addUserUseCase(_userAuth!.id, name, profilePic);
    Get.offAll(HomeScreen(userId: _userAuth!.id));
  }
}
