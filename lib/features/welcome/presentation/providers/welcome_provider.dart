import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/features/home/presentation/screens/home_screen.dart';
import '../../data/repo_impl/welcome_repository_impl.dart';
import '../../domain/usecases/get_user_prefs_use_case.dart';
import '../../domain/usecases/set_user_prefs_use_case.dart';
import '../../../home/presentation/providers/home_provider.dart';

class WelcomeProvider extends GetxController {
  SetUserPrefsUseCase _setUserPrefsUseCase;
  GetUserPrefsUseCase _getUserPrefsUseCase;
  late SharedPreferences prefs;
  String currentUserId = "";
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  WelcomeProvider()
      : _getUserPrefsUseCase = GetUserPrefsUseCase(WelcomeRepositoryImpl()),
        _setUserPrefsUseCase = SetUserPrefsUseCase(WelcomeRepositoryImpl());

  setUser(String userId) {
    _setUserPrefsUseCase(prefs, userId);
  }

  getUser() {
    currentUserId = _getUserPrefsUseCase(prefs);
  }

  @override
  void onInit() async {
    await initPrefs();
    getUser();

    if (currentUserId != "") {
      Timer(
        Duration(seconds: 10),
        () => Get.offAll(() => HomeScreen(userId: currentUserId)),
      );
    } else {
      Get.offAllNamed('/welcome');
    }
    super.onInit();
  }
}
