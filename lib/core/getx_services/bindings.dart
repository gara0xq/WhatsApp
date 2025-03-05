import 'package:get/get.dart';
import '../../features/home/presentation/providers/home_provider.dart';
import '../../features/welcome/presentation/providers/welcome_provider.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';

class GetBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.lazyPut<WelcomeProvider>(() => WelcomeProvider(), fenix: true);
  }
}
