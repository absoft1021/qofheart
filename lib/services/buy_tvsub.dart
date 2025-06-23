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
      {'id': 1, 'title': 'DSTV', 'logo': 'assets/images/dstv.png'},
      {'id': 2, 'title': 'GOTV', 'logo': 'assets/images/gotv.png'},
      {'id': 3, 'title': 'Startimes', 'logo': 'assets/images/startimes.png'},
      {'id': 4, 'title': 'ShowMax', 'logo': 'assets/images/showmax.png'}
    ];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help_outline_sharp),
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //menu items here
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/app_icon.png',
                    height: 80,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Select a Network Provider',
                    style: GoogleFonts.poppins(),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: net.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          box.write('tvId', net[index]['title']);
                          Get.to(() => const TvsubPrices(), arguments: [
                            {"logo": net[index]['logo']},
                            {"title": net[index]['title']}
                          ]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                net[index]['logo'],
                                height: 50,
                                width: 50,
                              ),
                              Text(
                                net[index]['title'],
                                style: GoogleFonts.poppins(),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
