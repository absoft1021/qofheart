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
          appBar: AppBar(
            title: Text(
              'Support Page',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.help_outline_rounded))
            ],
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/illu_customer_care.png',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 5),
                Text(
                  'How can we help you?',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Our Customer interaction center offers you 24/7 real-time information and assistance on all your enquiries and queries',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.find<HomeController>().openUrl(
                            "https://wa.me/+${box.read('profile')['Contact'][0]['call']}");
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/group.jpg',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Contact',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.find<HomeController>()
                          .openUrl(box.read('profile')['Contact'][0]['Group']),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/group.jpg',
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Whatsapp Group',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
