import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/auth/presentation/screens/enter_email_screen.dart';
import 'core/getx_services/bindings.dart';
import 'features/auth/presentation/screens/create_account_screen.dart';
import 'features/auth/presentation/screens/enter_phone_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/welcome/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/verify_number_screen.dart';
import 'features/welcome/presentation/screens/welcome_screen.dart';
import 'core/utils/themes.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://ouohxutacmmwegxqgqaf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im91b2h4dXRhY21td2VneHFncWFmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkxNjAyMTksImV4cCI6MjA1NDczNjIxOX0.V77kwLESi5H_xa5cTXqp49AXsPAurrafbFe-8nfFmY4',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialBinding: GetBindings(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/welcome', page: () => WelcomeScreen()),
        GetPage(name: '/enter_phone', page: () => EnterPhoneScreen()),
        GetPage(name: '/enter_email', page: () => EnterEmailScreen()),
        GetPage(name: '/verify_number', page: () => VerifyNumberScreen()),
        GetPage(name: '/create_account', page: () => CreateAccountScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
