import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../providers/auth_provider.dart';

class EnterPhoneScreen extends StatelessWidget {
  EnterPhoneScreen({super.key});
  final controller = Get.find<AuthProvider>();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: DropdownButtonFormField<String>(
                value: 'Egypt',
                decoration: InputDecoration(
                  labelText: 'Country',
                  border: UnderlineInputBorder(),
                ),
                items: <String>['USA', 'Canada', 'Mexico', 'Egypt']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      initialValue: "20",
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.add),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Form(
                      key: controller.fomKey,
                      child: TextFormField(
                        controller: phoneNumberController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Phone number',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                controller.signInWithPhone("+20${phoneNumberController.text}");
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
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
