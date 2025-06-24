import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/services/sub_services/tvsub_prices.dart';

class BuyTvsub extends StatelessWidget {
  const BuyTvsub({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    List net = [
      {'id': '1', 'title': 'GOTV', 'logo': 'assets/images/gotv.png'},
      {'id': '2', 'title': 'DSTV', 'logo': 'assets/images/dstv.png'},
      {'id': '3', 'title': 'Startimes', 'logo': 'assets/images/startimes.png'},
      {'id': '4', 'title': 'ShowMax', 'logo': 'assets/images/showmax.png'}
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'TV Subscription',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help_outline, color: Colors.black54),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/app_icon.png',
                  height: 70,
                ),
                const SizedBox(height: 10),
                Text(
                  'Select a TV Provider',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemCount: net.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          box.write('tvId', net[index]['title']);
                          Get.to(() => const TvsubPrices(), arguments: [
                            {"logo": net[index]['logo']},
                            {"title": net[index]['title']},
                            {"id": net[index]['id']}
                          ]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                net[index]['logo'],
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  net[index]['title'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}