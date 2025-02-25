import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../providers/auth_provider.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final controller = Get.find<AuthProvider>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                controller.addUser(nameController.text, "");
              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
