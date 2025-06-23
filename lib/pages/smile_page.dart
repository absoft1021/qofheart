import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/data_controller.dart';
import 'package:qofheart/services/buy_smile.dart';

class SmilePage extends StatefulWidget {
  const SmilePage({super.key});

  @override
  State<SmilePage> createState() => _PricingPageState();
}

class _PricingPageState extends State<SmilePage> {
  final controller = Get.lazyPut(() => DataController());
  @override
  void initState() {
    super.initState();
    Get.find<DataController>().smileBundle();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Buy Smile Voice',
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<DataController>(
                    builder: (controller) {
                      return
                         ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.plans.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () => Get.to(() => const BuySmile(),
                                      arguments: controller.plans[index]),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/smile_ic.png',
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.fill,
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Text(
                                                controller.plans[index]
                                                        ['PlanName']
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "N${controller.plans[index]['price'].toString()}",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
