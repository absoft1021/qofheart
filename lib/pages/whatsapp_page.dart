import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/home_controller.dart';

class WhatsappPage extends StatelessWidget {
  const WhatsappPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfff4f6fa),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Support Page',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help_outline_rounded, color: Colors.black54),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Icon(
                  Icons.support_agent_rounded,
                  size: 100,
                  color: Colors.blue.shade700,
                ),
                const SizedBox(height: 10),
                Text(
                  'How can we help you?',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Our customer care center is available 24/7 to assist with your questions and concerns.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _supportCard(
                      icon: Icons.phone_in_talk_rounded,
                      label: 'Contact',
                      color: Colors.green,
                      onTap: () {
                        Get.find<HomeController>().openUrl("https://wa.me/+2348069714782");
                      },
                    ),
                    _supportCard(
                      icon: Icons.group_rounded,
                      label: 'WhatsApp Group',
                      color: Colors.teal,
                      onTap: () {
                        Get.find<HomeController>().openUrl(
                            'https://chat.whatsapp.com/G9XJgQrAZkwEADjB7dpUNE');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _supportCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}