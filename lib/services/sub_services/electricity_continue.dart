// ignore_for_file: use_build_context_synchronously

import 'package:custom_pin_keyboard/custom_pin_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/components/local_auth_api.dart';
import 'package:qofheart/controllers/electric_controller.dart';

class ElectricityContinue extends StatefulWidget {
  const ElectricityContinue({super.key});

  @override
  State<ElectricityContinue> createState() => _ElectricityContinue();
}

class _ElectricityContinue extends State<ElectricityContinue> {
  final controller = Get.find<ElectricController>();
  final _meterController = TextEditingController();
  final _amountController = TextEditingController();
  final _phoneController = TextEditingController();
  final datas = Get.arguments;
  final box = GetStorage();

  final items = ['prepaid', 'postpaid'];
  String selectedItem = 'prepaid';
  String planTitle = '';

  @override
  void initState() {
    super.initState();
    planTitle = datas[1]['title'];
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Buy Electricity',
              style: TextStyle(fontSize: 15),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/electricity_illus.png',
                    fit: BoxFit.fill,
                    height: 100,
                    width: 200,
                  ),
                  const SizedBox(height: 5),
                  Text(planTitle, style: GoogleFonts.poppins()),
                  const SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: items
                        .map(
                          (String value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() {
                      selectedItem = value!;
                    }),
                    value: selectedItem,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        label: Text(
                          'Select meter type',
                          style: GoogleFonts.poppins(),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _meterController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        label: Text('Meter Number'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        label: Text('Amount'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        label: Text('Phone Number'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(OxFF0E47A1),
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: () {
                        if (_meterController.text.length < 8) {
                          Get.snackbar(
                              'Error Message', 'enter a valid meter number');
                        } else if (_amountController.text.isEmpty) {
                          Get.snackbar('Error Message', 'enter amount');
                        }
                        if (_phoneController.text.length < 11) {
                          Get.snackbar(
                              'Error Message', 'enter a valid phone number');
                        } else {
                          controller.isVisible.value = true;
                          customDialog(context);
                        }
                      },
                      child: Text(
                        'CONTINUE',
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
                        Get.find<ElectricController>().isVisible.value = false;
                        controller.checkElectric(
                          context,
                          datas[0]['id'].toString(),
                          _meterController.text,
                          selectedItem,
                          _phoneController.text,
                          _amountController.text,
                        );
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
          Get.find<ElectricController>().isVisible.value = false;
          final isAuthenticated = await LocalAuthApi.authenticate();
          if (isAuthenticated) {
            controller.checkElectric(
              context,
              datas[0]['id'].toString(),
              _meterController.text,
              selectedItem,
              _phoneController.text,
              _amountController.text,
            );
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
            borderRadius: const BorderRadius.all(
              Radius.circular(80),
            ),
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
