import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
