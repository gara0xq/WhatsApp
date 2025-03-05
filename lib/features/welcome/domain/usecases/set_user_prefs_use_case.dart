import 'package:shared_preferences/shared_preferences.dart';

import '../repo/welcome_repository.dart';

class SetUserPrefsUseCase {
  final WelcomeRepository _welcomeRepository;

  SetUserPrefsUseCase(this._welcomeRepository);

  Future<void> call(SharedPreferences prefs, String userId) async {
    return _welcomeRepository.setUser(prefs, userId);
  }
}
