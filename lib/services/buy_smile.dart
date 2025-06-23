// ignore_for_file: use_build_context_synchronously

import 'package:custom_pin_keyboard/custom_pin_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/components/local_auth_api.dart';
import 'package:qofheart/controllers/smile_controller.dart';

class BuySmile extends StatefulWidget {
  const BuySmile({super.key});

  @override
  State<BuySmile> createState() => _BuySmile();
}

class _BuySmile extends State<BuySmile> {
  final controller = Get.put(SmileController());
  final box = GetStorage();

  final _planController = TextEditingController();
  final _phoneController = TextEditingController();
  final _priceController = TextEditingController();
  final _validityController = TextEditingController();

  final datas = Get.arguments;

  @override
  void initState() {
    super.initState();
    _planController.text = datas['PlanName'];
    _priceController.text = "NGN ${datas['price']}";
    _validityController.text = datas['Validity'];
    _phoneController.text = "234";
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
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/smile_voice.jpg',
                    fit: BoxFit.contain,
                    height: 100,
                    width: 200,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _planController,
                    enabled: false,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    enabled: false,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _validityController,
                    enabled: false,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        label: Text('Phone Number'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(OxFF0E47A1),
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: () {
                        if (_phoneController.text.length < 11) {
                          Get.snackbar('Error Message', 'Invalid Phone Number');
                        } else {
                          controller.isVisible.value = true;
                          customDialog(context);
                        }
                      },
                      child: Text(
                        'BUY',
                        style: GoogleFonts.poppins(),
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

  void customDialog(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      constraints:
          BoxConstraints(maxWidth: Get.width, maxHeight: Get.height / 1.5),
      context: context,
      builder: (context) {
        return Obx(
          () => Visibility(
            visible: controller.isVisible.value,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "Enter your transaction pin",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: CustomPinKeyboard(
                    buttonBackground: Colors.transparent,
                    onCompleted: (passcode) async {
                      if (passcode == box.read('pin')) {
                        Get.find<SmileController>().isVisible.value = false;
                        controller.buySmile(context, _phoneController.text,
                            datas['PlanId'].toString());
                      } else {
                        Get.snackbar('Error Message', 'Incorrect pincode');
                      }
                    },
                    additionalButton: const Icon(Icons.clear),
                    textStyle: GoogleFonts.poppins(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                buildAuthenticate(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          Get.find<SmileController>().isVisible.value = false;
          final isAuthenticated = await LocalAuthApi.authenticate();
          if (isAuthenticated) {
            controller.buySmile(
                context, _phoneController.text, datas['PlanId'].toString());
          }
        },
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      GestureDetector(
        onTap: onClicked,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(80)),
          ),
          child: Image.asset(
            'assets/images/fingerprint.png',
            height: 50,
            width: 50,
            color: Colors.grey,
          ),
        ),
      );
}
