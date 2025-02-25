import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../providers/auth_provider.dart';

class VerifyNumberScreen extends StatelessWidget {
  VerifyNumberScreen({super.key});
  final controller = Get.find<AuthProvider>();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 180,
          child: Pinput(
            length: 6,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            showCursor: true,
            controller: otpController,
            separatorBuilder: (index) =>
                index == 2 ? SizedBox(width: 30) : SizedBox(width: 10),
            onCompleted: (String pin)async {
              await controller.verifyOtp(otpController.text);
              if (!controller.userNotifier.value) {
                Get.offAllNamed('/create_account');
              }
            },
            defaultPinTheme: PinTheme(
              height: 50,
              width: 50,
              textStyle: TextStyle(fontSize: 20, color: Colors.white),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 2)),
              ),
            ),
            pinAnimationType: PinAnimationType.slide,
          ),
        ),
      ),
    );
  }
}
