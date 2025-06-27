import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import 'package:qofheart/components/pin_code.dart';
import 'package:qofheart/controllers/account_controller.dart';
import 'package:qofheart/pages/pricing_page.dart';
import 'package:qofheart/pages/upgrade_page.dart';
import 'package:qofheart/pages/profile_page.dart';
import 'package:qofheart/views/welcome_page.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  void shareReferralLink() {
    const message =
        "🎉 Join me on Qofheart and earn rewards! Download now:\n https://qofheart.com/mobile/register/ 👈";
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountController>();

    final List menus = [
      {
        "id": 1,
        "title": "Email",
        "sub": "dddaniel2580@gmail.com",
        "icon": Icons.email,
        "onTap": () {},
      },
      {
        "id": 2,
        "title": "Refer a Friend",
        "sub": "Earn money when you invite a friend to Qofheart",
        "icon": Icons.share,
        "onTap": shareReferralLink,
      },
      {
        "id": 3,
        "title": "Our Pricing",
        "sub": "View Qofheart Pricing plans",
        "icon": Icons.list,
        "onTap": () => Get.to(() => const PricingPage()),
      },
      {
        "id": 4,
        "title": "Change PIN",
        "sub": "Protect yourself from intruders",
        "icon": Icons.security,
        "onTap": () => Get.to(() => PinCode()),
      },
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF3F6FA),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: ListTile(
                  onTap: () => Get.to(() => ProfilePage()),
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade200,
                    child: Image.asset('assets/images/user.png'),
                  ),
                  title: Text(
                    controller.user['fname']?.toString() ?? 'User',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Account Details',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
              const SizedBox(height: 20),
              ...menus.map((menu) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 1.5,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: menu['onTap'],
                    leading: Icon(menu['icon'], color: const Color(0xFF0E47A1)),
                    title: Text(
                      menu['title'],
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      menu['sub'],
                      style: GoogleFonts.poppins(
                          fontSize: 11, fontWeight: FontWeight.w400),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              }).toList(),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Get.offAll(() => const WelcomePage());
                },
                child: Center(
                  child: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}