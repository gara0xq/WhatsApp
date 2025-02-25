import 'package:get/get.dart';

import '../../src/presentation/providers/auth_provider.dart';
 
class GetBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    
  }
}