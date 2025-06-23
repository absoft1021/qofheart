import 'package:qofheart/components/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/account_controller.dart';
import 'package:qofheart/controllers/upgrade_controller.dart';
import 'package:qofheart/pages/pricing_page.dart';

class UpgradePage extends StatefulWidget {
  const UpgradePage({super.key});

  @override
  State<UpgradePage> createState() => _UpgradePageState();
}

class _UpgradePageState extends State<UpgradePage> {
  final controller = Get.put(UpgradeController());
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Upgrage Account',
              style: TextStyle(fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wallet Balance',
                        style: GoogleFonts.poppins(),
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<AccountController>(builder: (controller) {
                        return Text(
                          '${AppConstants.naira}${controller.walletBalance.value}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    'You Are Currently Running On User Package',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  'Upgrade Your Account And Enjoy More Discount',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.defaultDialog(
                        title: "Notice",
                        contentPadding: const EdgeInsets.all(10),
                        content: const Text(
                          "Do you want to upgrade your account to Agent?",
                          textAlign: TextAlign.center,
                        ),
                        onCancel: () => Navigator.pop(context),
                        onConfirm: () {
                          Navigator.pop(context);
                          controller.upgrage(context, "agent");
                        },
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(OxFF0E47A1),
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'AGENT PACKAGE \n${AppConstants.naira}1000',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Notice",
                            contentPadding: const EdgeInsets.all(10),
                            content: const Text(
                              "Do you want to upgrade your account to Api?",
                              textAlign: TextAlign.center,
                            ),
                            onCancel: () => Navigator.pop(context),
                            onConfirm: () {
                              Navigator.pop(context);
                              controller.upgrage(context, "api");
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'API AGENT \n${AppConstants.naira}1500',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Get.to(() => const PricingPage()),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Benefit of Agent'),
                      Text('Benefit of API')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
