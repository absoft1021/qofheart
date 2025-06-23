import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/data_controller.dart';
import 'package:qofheart/services/buy_data.dart';

class DataPrices extends StatefulWidget {
  const DataPrices({super.key});

  @override
  State<DataPrices> createState() => _DataPricesState();
}

class _DataPricesState extends State<DataPrices> {
  final controller = Get.put(DataController());
  final mtn = ['SME', 'Cooperate', 'SME2'];
  final netId = Get.arguments[0]['id'];
  final logo = GetStorage().read('logo');
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.dataPlans(netId, controller.network[netId - 1]);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(360),
                    child: Image.asset(
                      logo,
                      scale: 3.5,
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'qofheart',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(OxFF0E47A1),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 30,
                  child: FlutterToggleTab(
                    width: MediaQuery.of(context).size.width / 4,
                    borderRadius: 10,
                    labels: mtn,
                    selectedBackgroundColors: const [Color(OxFF0E47A1)],
                    selectedTextStyle: GoogleFonts.poppins(color: Colors.white),
                    unSelectedTextStyle: GoogleFonts.poppins(),
                    selectedIndex: currentIndex,
                    selectedLabelIndex: (index) {
                      setState(() {
                        currentIndex = index;
                        if (netId == 1) {
                          final types = ['mtnsme', 'mtncg', 'direct'];
                          controller.filterPlans(types[index]);
                        }
                      });
                    },
                    isScroll: false,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GetBuilder<DataController>(
                    builder: (controller) {
                      return controller.obx(
                        onLoading: const CircularProgressIndicator(),
                        onError: (error) => Text(error.toString()),
                        (data) => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.flist.length,
                          itemBuilder: (context, index) {
                            final plan = controller.flist[index];
                            return InkWell(
                              onTap: () => Get.to(() => const BuyData(), arguments: plan),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      plan['PlanName'],
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFAFAFA),
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "\u20A6${plan['price']}",
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 15),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
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