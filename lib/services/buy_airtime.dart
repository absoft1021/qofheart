// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:custom_pin_keyboard/custom_pin_keyboard.dart';
import 'package:qofheart/components/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/components/local_auth_api.dart';
import 'package:qofheart/controllers/bottom_controller.dart';
import 'package:qofheart/controllers/home_controller.dart';
import 'package:qofheart/controllers/purchase_controller.dart';

class BuyAirtime extends StatefulWidget {
  const BuyAirtime({super.key});

  @override
  State<BuyAirtime> createState() => _BuyAirtimeState();
}

class _BuyAirtimeState extends State<BuyAirtime> {
  final box = GetStorage();

  bool isLoading = true;

  final controller = Get.find<PurchaseController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final controllerx = Get.put(BottomController());

  List list = [];

  bool isPinVisible = true;

  List net = [
    'assets/images/mtn.jpg',
    'assets/images/airtelx.jpg',
    'assets/images/glo.jpg',
    'assets/images/mobile.jpg'
  ];

  var prices = [
    "${AppConstants.naira}50",
    "${AppConstants.naira}100",
    "${AppConstants.naira}200",
    "${AppConstants.naira}400",
    "${AppConstants.naira}500",
    "${AppConstants.naira}1000"
  ];

  String networkId = "1";

  bool isBottomSheetVisible = false;

  final _amountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xffeff3fa),
          appBar: AppBar(
            title: Text(
              'Buy Airtime',
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 120,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Select Network Provider',
                                  style: GoogleFonts.poppins(
                                      color: const Color(OxFF0E47A1),
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: net.length,
                                  itemBuilder: (context, index) {
                                    return GetBuilder<HomeController>(
                                        builder: (controller) {
                                      return InkWell(
                                        onTap: () {
                                          controller.changePosition(index);
                                          networkId = (index + 1).toString();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          width: 70,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border:
                                                  index == controller.position
                                                      ? Border.all()
                                                      : null,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0xffeff3fa),
                                                  blurRadius: 1,
                                                  offset: Offset(1, 1),
                                                )
                                              ],
                                              color: Colors.grey[100]),
                                          child: CircleAvatar(
                                            backgroundImage:
                                                AssetImage(net[index]),
                                          ),
                                        ),
                                      );
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Phone Number start here
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: GetBuilder<PurchaseController>(builder: (_) {
                        return TextFormField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () => controller.pickNumber(),
                                icon: const Icon(Icons.contact_emergency)),
                            contentPadding: const EdgeInsets.all(15),
                            border: InputBorder.none,
                            hintText: 'Mobile Number',
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    //Default Prices Gridview Here
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: prices.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 2),
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xffeff3fa),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffeff3fa),
                                blurRadius: 1,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              _amountController.text = prices[index];
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  prices[index].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Elevatad button and Amount Row here
                    Container(
                      height: 60,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: _amountController,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(fontSize: 18),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                border: InputBorder.none,
                                hintText: 'Amount',
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(OxFF0E47A1),
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            onPressed: () {
                              String phone = controller.phoneController.text;
                              if (_amountController.text.isEmpty) {
                                AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.rightSlide,
                                        title: "Warning",
                                        desc: "enter amount")
                                    .show();
                              } else if (phone.length < 11) {
                                errorDialog(context, "Phone Number not valid");
                              } else {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      String phoneNum = controller
                                          .phoneController.text
                                          .trim();
                                      String amount = _amountController.text
                                          .toString()
                                          .replaceAll(AppConstants.naira, '');
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.4,
                                          child: CustomPinKeyboard(
                                            length: 4,
                                            buttonBackground:
                                                Colors.transparent,
                                            indicatorProgressColor:
                                                const Color(OxFF0E47A1),
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
                                            onAdditionalButtonPressed:
                                                () async {
                                              final isAuthenticated =
                                                  await LocalAuthApi
                                                      .authenticate();
                                              if (isAuthenticated) {
                                                Get.back();
                                                controller.buyAirtime(
                                                  context,
                                                  phoneNum,
                                                  networkId,
                                                  amount,
                                                );
                                              }
                                            },
                                            onCompleted: (passcode) async {
                                              if (passcode == box.read('pin')) {
                                                Get.back();
                                                controller.buyAirtime(
                                                  context,
                                                  phoneNum,
                                                  networkId,
                                                  amount,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    });
                              }
                            },
                            child: const Text('Buy'),
                          ),
                          const SizedBox(width: 10)
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  errorDialog(BuildContext dcontext, String msg) {
    return AwesomeDialog(
      context: dcontext,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: "Warning",
      desc: msg,
      btnCancelText: 'Close',
      btnCancelOnPress: () => Get.close(0),
    ).show();
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
                        controller.isVisible.value = false;
                        controller.buyAirtime(
                          context,
                          controller.phoneController.text.trim(),
                          networkId,
                          _amountController.text
                              .toString()
                              .replaceAll(AppConstants.naira, ''),
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
          controller.isVisible.value = false;
          final isAuthenticated = await LocalAuthApi.authenticate();
          if (isAuthenticated) {
            controller.buyAirtime(
              context,
              controller.phoneController.text.trim(),
              networkId,
              _amountController.text
                  .toString()
                  .replaceAll(AppConstants.naira, ''),
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
