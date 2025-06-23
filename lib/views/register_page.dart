import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/components/loading_dialog.dart';
import 'package:qofheart/controllers/account_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController(); // Changed from _nameController
  final _lastNameController = TextEditingController(); // Added Last Name controller
  final _emailController = TextEditingController();
  final _stateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  final _cpassController = TextEditingController();
  final _pinController = TextEditingController();
  bool isChecked = true;

  void showSnack(String msg) {
    Get.snackbar("Error Message", msg, margin: const EdgeInsets.all(10));
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.grey[600]),
      hintText: hint,
      hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.grey),
      contentPadding: const EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF0E47A1)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFFFAFAFA)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Create Your Account',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 10),
                  Text('Fill in the details below to get started.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey,
                      )),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: _firstNameController, // Changed from _nameController
                    decoration: inputDecoration('First Name', Icons.person), // Changed label
                    validator: (value) =>
                        value!.length < 2 ? 'First Name should be at least 2 characters' : null, // Adjusted validation
                  ),
                  const SizedBox(height: 20),

                  TextFormField( // Added Last Name field
                    controller: _lastNameController,
                    decoration: inputDecoration('Last Name', Icons.person),
                    validator: (value) =>
                        value!.length < 2 ? 'Last Name should be at least 2 characters' : null,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration('Email Address', Icons.email),
                    validator: (value) =>
                        !GetUtils.isEmail(value!) ? 'Invalid email address' : null,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _stateController,
                    decoration: inputDecoration('State', Icons.location_on),
                    validator: (value) =>
                        value!.isEmpty ? 'State is required' : null,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: inputDecoration('Phone Number', Icons.phone),
                    validator: (value) =>
                        value!.length < 10 ? 'Invalid phone number' : null,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _passController,
                    obscureText: true,
                    decoration: inputDecoration('Password', Icons.lock),
                    validator: (value) =>
                        value!.length < 6 ? 'Password should be at least 6 characters' : null,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _cpassController,
                    obscureText: true,
                    decoration: inputDecoration('Confirm Password', Icons.lock),
                    validator: (value) =>
                        value != _passController.text ? 'Passwords do not match' : null,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration('Pin Number (4 digits)', Icons.pin),
                    maxLength: 4,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) =>
                        value!.length != 4 ? 'Pin must be 4 digits' : null,
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (val) => setState(() => isChecked = val!),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'I agree to the Terms & Conditions and Privacy Policy.',
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (!isChecked) {
                          showSnack('Please accept the terms and conditions');
                          return;
                        }
                        LoadingDialog(context: context).showLoading();
                        Get.find<AccountController>().register(
                          context,
                          _firstNameController.text, // Changed from _nameController
                          _lastNameController.text, // Added last name
                          _emailController.text,
                          _phoneController.text,
                          _passController.text,
                          _cpassController.text,
                          _stateController.text,
                          _pinController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E47A1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
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