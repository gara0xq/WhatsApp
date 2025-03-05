import 'package:shared_preferences/shared_preferences.dart';

abstract class WelcomeRepository {
  Future<void> setUser(SharedPreferences prefs, String userId);
  String getUser(SharedPreferences prefs);
}
