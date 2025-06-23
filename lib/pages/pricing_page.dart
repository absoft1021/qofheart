import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/data_controller.dart';

class PricingPage extends StatefulWidget {
  const PricingPage({super.key});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  final controller = Get.lazyPut(() => DataController());
  @override
  void initState() {
    super.initState();
    Get.find<DataController>().allPlans();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Price List',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xFF0E47A1),
                child: Row(children: [
                  const SizedBox(width: 10),
                  Text(
                    'Services',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  const SizedBox(width: 80),
                  Text(
                    'User',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    'Agent',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    'Api',
                    style: GoogleFonts.poppins(color: Colors.white),
                  )
                ]),
              ),
              Expanded(
                child: GetBuilder<DataController>(builder: (controller) {
                  return ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller.plans.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.plans[index]['PlanName']
                                            .toString()
                                            .replaceAll('Data', '\n'),
                                        style: GoogleFonts.poppins(),
                                      ),
                                      Text(
                                        "N${controller.plans[index]['price'].toString()}",
                                        style: GoogleFonts.poppins(),
                                      ),
                                      Text(
                                        "N${controller.plans[index]['reseller'].toString()}",
                                        style: GoogleFonts.poppins(),
                                      ),
                                      Text(
                                        "N${controller.plans[index]['api'].toString()}",
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
