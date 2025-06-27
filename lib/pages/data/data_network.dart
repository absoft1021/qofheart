import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/pages/data/buydata.dart';

class DataNetwork extends StatelessWidget {
  const DataNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    List net = [
      {'id': 1, 'title': 'MTN', 'logo': 'assets/images/mtn.jpg'},
      {'id': 2, 'title': 'Airtel', 'logo': 'assets/images/airtelx.jpg'},
      {'id': 3, 'title': 'Glo', 'logo': 'assets/images/glo.jpg'},
      {'id': 4, 'title': '9Mobile', 'logo': 'assets/images/mobile.jpg'},
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help_outline, color: Colors.black54),
              ),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              Image.asset('assets/images/app_icon.png', height: 70),
              const SizedBox(height: 10),
              Text(
                'Select Network',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    itemCount: net.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3 / 3.2,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          box.write('logo', net[index]['logo']);
                          box.write('networkId', net[index]['id']);
                          Get.to(() => const Buydata(), arguments: net[index]['id']);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(net[index]['logo']),
                                radius: 32,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                net[index]['title'],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonCode(String text) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0E47A1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      ),
    );
  }
}