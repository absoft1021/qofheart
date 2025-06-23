import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/views/main_page.dart';

class PinCode extends StatelessWidget {
  PinCode({super.key});
  final box = GetStorage();
  final formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  final _cpinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Icon(Icons.lock, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    'SET PIN CODE',
                    style: GoogleFonts.poppins(fontSize: 25),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _pinController,
                    maxLength: 4,
                    obscureText: true,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      label: Text('PIN'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    validator: (value) =>
                        value!.length < 4 ? 'PIN must be 4 number' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _cpinController,
                    maxLength: 4,
                    obscureText: true,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      label: Text('Confirm PIN'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    validator: (value) => value! != _pinController.text
                        ? 'pin do not match'
                        : null,
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(OxFF0E47A1),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            box.write('pin', _pinController.text);
                            FocusScope.of(context).unfocus();
                            Get.to(() => const MainPage());
                            // Get.find<AccountController>().update();
                          }
                        },
                        child: const Text('SET PIN')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
