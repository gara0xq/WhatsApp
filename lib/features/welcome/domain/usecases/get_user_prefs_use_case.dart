import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/features/welcome/domain/repo/welcome_repository.dart';

class GetUserPrefsUseCase {
  final WelcomeRepository _welcomeRepository;

  GetUserPrefsUseCase(this._welcomeRepository);

  String call(SharedPreferences prefs) {
    return _welcomeRepository.getUser(prefs);
  }
}
