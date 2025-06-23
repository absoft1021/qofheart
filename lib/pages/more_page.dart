import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/components/pin_code.dart';
import 'package:qofheart/controllers/account_controller.dart';
import 'package:qofheart/pages/profile_page.dart';
import 'package:qofheart/pages/referral_page.dart';
import 'package:qofheart/pages/upgrade_page.dart';
import 'package:qofheart/pages/pricing_page.dart';
import 'package:qofheart/views/welcome_page.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountController>();
    List menus = [
      {
        "id": 1,
        "title": "Upgrade Account",
        "sub": "To be our merchant Agent",
        "icon": Icons.send
      },
      {
        "id": 2,
        "title": "Refer a Friend",
        "sub": "Earn money you invite friend to qofheart",
        "icon": Icons.share
      },
      {
        "id": 3,
        "title": "Our Pricing",
        "sub": "To view an qofheart Pricing",
        "icon": Icons.list
      },
      {
        "id": 4,
        "title": "Change Pin",
        "sub": "Protect yourself from intruders",
        "icon": Icons.security
      },
      // {
      //   "id": 6,
      //   "title": "Your current version is: 9",
      //   "sub": "About us and many more about",
      //   "icon": Icons.help_outline_outlined
      // },
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              ListTile(
                onTap: () => Get.to(() => ProfilePage()),
                leading:
                    CircleAvatar(child: Image.asset('assets/images/user.png')),
                title: Text(
                  controller.user['fname'].toString() ?? 'User',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Account Details',
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: menus.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      if (index == 0) {
                        Get.to(() => const UpgradePage());
                      } else if (index == 1) {
                        Get.to(() => const ReferralPage());
                      } else if (index == 2) {
                        Get.to(() => const PricingPage());
                      } else if (index == 3) {
                        Get.to(() => PinCode());
                      }
                    },
                    leading: Icon(
                      menus[index]['icon'],
                      color: const Color(0xFF0E47A1),
                    ),
                    title: Text(
                      menus[index]['title'],
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      menus[index]['sub'],
                      style: GoogleFonts.poppins(
                          fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => const WelcomePage());
                },
                child: Center(
                  child: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
