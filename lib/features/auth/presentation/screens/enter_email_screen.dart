import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../providers/auth_provider.dart';

class EnterEmailScreen extends StatelessWidget {
  EnterEmailScreen({super.key});
  final authProvider = Get.find<AuthProvider>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              Text(
                'Enter your phone number',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26),
              ),
              Text(
                'WhatsApp will need to verify your phone number. Carrier SMS charges may apply. What\'s my number?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Container(
                width: double.infinity,
                height: 60,
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary.withAlpha(70),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => authProvider.isLogin.value = true,
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              child: Text("Login"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => authProvider.isLogin.value = false,
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              child: Text("Sign Up"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnimatedAlign(
                      duration: Duration(milliseconds: 200),
                      alignment: authProvider.isLogin.value
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        width: 165,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                            authProvider.isLogin.value ? "Login" : "Sign Up"),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: authProvider.emailFomKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.length < 8) {
                          return 'Please enter your passwrd';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    if (!authProvider.isLogin.value)
                      TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value!.length < 8) {
                            return 'Please enter your passwrd';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      "Signin with Phone",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  authProvider.authWithEmail(
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    authProvider.isLogin.value ? 'Login' : 'Create an account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
