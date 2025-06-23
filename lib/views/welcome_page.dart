import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/views/login_page.dart';
import 'package:qofheart/views/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (pop) async {},
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/welcom.png',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Simplify\nbill payments\nwith ease!',
                    style: GoogleFonts.poppins(
                        fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Enjoy the convenience of purchasing data, airtime, and paying utility bills, all from the comfort of your home.',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E47A1),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => Get.to(() => const RegisterPage()),
                    child: const Text('Register')),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => LoginPage()),
                    child: const Text('Already have an account')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
