import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/services/sub_services/data_prices.dart';

class DataNetwork extends StatelessWidget {
  const DataNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    List net = [
      {'id': 1, 'title': 'MTN', 'logo': 'assets/images/mtn.jpg'},
      {'id': 2, 'title': 'Glo', 'logo': 'assets/images/glo.jpg'},
      {'id': 3, 'title': '9Mobile', 'logo': 'assets/images/mobile.jpg'},
      {'id': 4, 'title': 'Airtel', 'logo': 'assets/images/airtelx.jpg'},
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
                    height: 100,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Select Network Provider',
                    style: GoogleFonts.poppins(),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: net.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            box.write('logo', net[index]['logo']);
                            box.write('networkId', net[index]['id']);
                            Get.to(() => (const DataPrices()), arguments: [
                              {"id": net[index]['id']}
                            ]);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(net[index]['logo']),
                                  radius: 30,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  net[index]['title'],
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return BottomSheet(
                          onClosing: () {},
                          builder: ((context) {
                            return SingleChildScrollView(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      'Checking Data Balance Codes',
                                      style: GoogleFonts.poppins(),
                                    ),
                                    const SizedBox(height: 10),
                                    buttonCode('MTN SME *461*4#'),
                                    const SizedBox(height: 10),
                                    buttonCode('MTN CG *460*260#'),
                                    const SizedBox(height: 10),
                                    buttonCode('AIRTEL *323#'),
                                    const SizedBox(height: 10),
                                    buttonCode('GLO *323#'),
                                    const SizedBox(height: 10),
                                    buttonCode('9MOBILE *228#'),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      })
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  color: const Color(OxFF0E47A1),
                  child: Text(
                    'CLICK TO VIEW CODES FOR CHECKING BALANCE',
                    style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.white,
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

  Widget buttonCode(String text) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(OxFF0E47A1),
          foregroundColor: Colors.white,
        ),
        child: Text(text),
      ),
    );
  }
}
