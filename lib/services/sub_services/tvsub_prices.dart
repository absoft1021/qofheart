import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/data_controller.dart';
import 'package:qofheart/services/sub_services/tvsub_continue.dart';

class TvsubPrices extends StatefulWidget {
  const TvsubPrices({super.key});

  @override
  State<TvsubPrices> createState() => _PricingPageState();
}

class _PricingPageState extends State<TvsubPrices> {
  final box = GetStorage();
  final controller = Get.lazyPut(() => DataController());
  String netId = Get.arguments[1]['title'].toString();
  @override
  void initState() {
    super.initState();
    Get.find<DataController>().cablePlans(box.read('tvId'));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Buy Cables Sub',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<DataController>(
                    builder: (controller) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.plans.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => const TvsubContinue(), arguments: [
                                {"prov": controller.plans[index]['provider']},
                                {
                                  "price": controller.plans[index]['price'],
                                },
                                {
                                  "plan": controller.plans[index]['PlanId'],
                                },
                                {
                                  "planName": controller.plans[index]
                                      ['PlanName']
                                }
                              ]);
                            },
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
                                    Get.arguments[0]['logo'],
                                    height: 40,
                                    width: 50,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Text(
                                          controller.plans[index]['PlanName']
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
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
