import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../providers/welcome_provider.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final welcomeProvider = Get.find<WelcomeProvider>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/images/whatsapp_logo.svg',
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          width: 100,
        ),
      ),
    );
  }
}
