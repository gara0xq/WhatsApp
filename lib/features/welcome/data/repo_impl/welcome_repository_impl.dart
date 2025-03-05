import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repo/welcome_repository.dart';

class WelcomeRepositoryImpl implements WelcomeRepository {
  @override
  String getUser(SharedPreferences prefs) {
    return prefs.getString("userId") ?? "";
  }

  @override
  Future<void> setUser(SharedPreferences prefs, String userId) async {
    await prefs.setString("userId", userId);
  }
}
