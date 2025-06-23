import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/reset_controller.dart';

class ForgorPssword extends StatefulWidget {
  const ForgorPssword({super.key});

  @override
  State<ForgorPssword> createState() => _ForgorPsswordState();
}

class _ForgorPsswordState extends State<ForgorPssword> {
  final controller = Get.put(ResetController());
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'forgot password',
          style: GoogleFonts.poppins(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        children: [
          Center(
              child: Text(
            'Reset your password',
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 25),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.all(15),
              label: Text('Email address'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 55,
            width: Get.width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E47A1),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () {
                  if (!_emailController.text.isEmail) {
                    Get.snackbar('Error Message', 'Enter correct email address',
                        snackPosition: SnackPosition.TOP);
                  } else {
                    controller.reset(context, _emailController.text);
                  }
                },
                child: const Text('RESET')),
          ),
        ],
      ),
    );
  }
}
