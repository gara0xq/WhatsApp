import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../../welcome/data/repo_impl/welcome_repository_impl.dart';
import '../../../welcome/domain/usecases/set_user_prefs_use_case.dart';
import '../../../../core/data/models/user_model.dart';
import '../../data/repo_impl/auth_repository_impl.dart';
import '../../domain/usecases/signin_with_email_use_case.dart';
import '../../domain/usecases/signup_with_email_use_case.dart';
import '../../domain/usecases/add_user_use_case.dart';
import '../../domain/usecases/enter_phone_number_use_case.dart';
import '../../domain/usecases/get_user_use_case.dart';
import '../../domain/usecases/verify_phone_number_use_case.dart';

class AuthProvider extends GetxController {
  final EnterPhoneNumberUseCase enterPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final GetUserUseCase getUserUsseCase;
  final AddUserUseCase addUserUseCase;
  final SigninWithEmailUseCase signinWithEmailUseCase;
  final SignupWithEmailUseCase signupWithEmailUseCase;
  final SetUserPrefsUseCase _setUserPrefsUseCase;

  final phoneFomKey = GlobalKey<FormState>();
  final emailFomKey = GlobalKey<FormState>();

  var isLogin = true.obs;
  String _phoneNumber = '';
  late SharedPreferences prefs;
  User? _userAuth;

  UserModel? userModel;

  ValueNotifier userNotifier = ValueNotifier<bool>(false);

  AuthProvider()
      : enterPhoneNumberUseCase = EnterPhoneNumberUseCase(AuthRepositoryImpl()),
        verifyPhoneNumberUseCase =
            VerifyPhoneNumberUseCase(AuthRepositoryImpl()),
        getUserUsseCase = GetUserUseCase(AuthRepositoryImpl()),
        addUserUseCase = AddUserUseCase(AuthRepositoryImpl()),
        signinWithEmailUseCase = SigninWithEmailUseCase(AuthRepositoryImpl()),
        signupWithEmailUseCase = SignupWithEmailUseCase(AuthRepositoryImpl()),
        _setUserPrefsUseCase = SetUserPrefsUseCase(WelcomeRepositoryImpl());

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  setUser(String userId) {
    _setUserPrefsUseCase(prefs, userId);
  }

  void signInWithPhone(String phoneNumber) {
    if (phoneFomKey.currentState!.validate()) {
      enterPhoneNumberUseCase(phoneNumber);
      Get.toNamed('/verify_number');
      _phoneNumber = phoneNumber;
    }
  }

  Future verifyOtp(String otp) async {
    if (phoneFomKey.currentState!.validate()) {
      _userAuth = await verifyPhoneNumberUseCase.call(otp, _phoneNumber);
      if (_userAuth != null) {
        userModel = await getUserUsseCase(_userAuth!.id);
        if (userModel != null) {
          userNotifier.value = true;
          setUser(userModel!.userId);
          Get.offAll(HomeScreen(userId: userModel!.userId));
        }
      }
    }
  }

  void addUser(String name, String profilePic) {
    try {
      addUserUseCase(_userAuth!.id, name, profilePic);
      setUser(_userAuth!.id);
      Get.offAll(HomeScreen(userId: _userAuth!.id));
    } catch (e) {
      log(e.toString());
    }
  }

  authWithEmail(String email, String password) async {
    if (isLogin.value) {
      signInWithEmail(email, password);
    } else {
      signUpWithEmail(email, password);
    }
  }

  void signInWithEmail(String email, String password) async {
    var response = await signinWithEmailUseCase(email, password);
    _userAuth = response;
    setUser(_userAuth!.id);
    // Get.find
    Get.offAll(HomeScreen(userId: _userAuth!.id));
  }

  void signUpWithEmail(String email, String password) async {
    var response = await signupWithEmailUseCase.call(email, password);
    _userAuth = response;
    Get.toNamed('/create_account');
  }
}
