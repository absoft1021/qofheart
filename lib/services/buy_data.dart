// ignore_for_file: use_build_context_synchronously
import 'package:custom_pin_keyboard/custom_pin_keyboard.dart';
import 'package:qofheart/components/local_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/purchase_controller.dart';

class BuyData extends StatefulWidget {
  const BuyData({super.key});

  @override
  State<BuyData> createState() => _BuyDataState();
}

class _BuyDataState extends State<BuyData> {
  final _amountController = TextEditingController();
  final _planController = TextEditingController();

  final box = GetStorage();
  final data = Get.arguments;

  final controller = Get.find<PurchaseController>();

  List list = [];
  bool isPinVisible = true;

  @override
  void initState() {
    super.initState();
    _planController.text = data['PlanName'];
    _amountController.text = "NGN ${data['price'].toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Buy Data',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset('assets/images/app_icon.png',
                      width: 80, height: 80),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _planController,
                    enabled: false,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _amountController,
                    enabled: false,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () => controller.pickNumber(),
                          icon: const Icon(Icons.perm_contact_cal)),
                      contentPadding: const EdgeInsets.all(15),
                      border: const OutlineInputBorder(),
                      hintText: 'Mobile Number',
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      String num = controller.phoneController.text;
                      String netId = data['NetworkId'].toString();
                      String pId = data['PlanId'].toString();
                      if (num.length < 11) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Enter a valid phone number')));
                      } else {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2.4,
                                  child: CustomPinKeyboard(
                                    length: 4,
                                    buttonBackground: Colors.transparent,
                                    indicatorProgressColor:
                                        const Color(0xFF0E47A1),
                                    indicatorBackground:
                                        const Color(0xFFB5D1D3),
                                    //    verticalSeparator: const Divider(),
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      height: 32 / 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    additionalButton: Image.asset(
                                      'assets/images/fingerprint.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                    onAdditionalButtonPressed: () async {
                                      final isAuthenticated =
                                          await LocalAuthApi.authenticate();
                                      if (isAuthenticated) {
                                        Get.back();
                                        controller.buyData(
                                            context, num, netId, pId, false);
                                      }
                                    },
                                    onCompleted: (passcode) async {
                                      if (passcode == box.read('pin')) {
                                        Get.back();
                                        controller.buyData(
                                            context, num, netId, pId, true);
                                      }
                                    },
                                  ),
                                ),
                              );
                            });
                      }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFF0E47A1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        'Purchase',
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 16),
                      ),
                    ),
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
