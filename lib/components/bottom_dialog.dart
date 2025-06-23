// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/components/local_auth_api.dart';
import 'package:qofheart/controllers/network_controller.dart';
import 'package:qofheart/views/main_page.dart';

class BottomDialog extends StatefulWidget {
  const BottomDialog({super.key});

  @override
  State<BottomDialog> createState() => _BottomDialogWidgetState();
}

class _BottomDialogWidgetState extends State<BottomDialog> {
  final box = GetStorage();
  String enteredPin = '';
  List list = [];
  bool isPinVisible = true;

  /// this widget will be use for each digit
  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (enteredPin.length < 4) {
              enteredPin += number.toString();

              if (enteredPin.length == 4) {
                if (enteredPin == box.read('pin')) {
                  if (Get.find<NetworkController>().connectionStatus == 1) {
                    Get.to(() => const MainPage());
                  } else {
                    Get.snackbar('', 'No network available');
                  }
                } else {
                  enteredPin = '';
                  Get.snackbar(
                    'Error Message',
                    'Incorrect pin',
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  );
                }
              }
            }
          });
        },
        child: Text(
          number.toString(),
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Image.asset(
                  'assets/images/user.png',
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  "Hi, ${box.read('profile')['Name']}",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "You can use the fingerprint \nsensor to login",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              /// pin code area
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) {
                    return Container(
                      margin: const EdgeInsets.all(6.0),
                      width: isPinVisible ? 30 : 16,
                      height: isPinVisible ? 30 : 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: index < enteredPin.length
                            ? isPinVisible
                                ? Colors.grey
                                : CupertinoColors.activeBlue
                            : CupertinoColors.activeBlue.withOpacity(0.1),
                      ),
                      child: isPinVisible && index < enteredPin.length
                          ? Center(
                              child: Text(
                                "*",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : null,
                    );
                  },
                ),
              ),
              // Numbers row start here
              for (var i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (index) => numButton(1 + 3 * i + index),
                    ).toList(),
                  ),
                ),

              /// 0 digit with back remove
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextButton(onPressed: null, child: SizedBox()),
                    numButton(0),
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            if (enteredPin.isNotEmpty) {
                              enteredPin = enteredPin.substring(
                                  0, enteredPin.length - 1);
                            }
                          },
                        );
                      },
                      child: const Icon(
                        Icons.backspace,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),

              buildAuthenticate(context),

              /// reset button
              // TextButton(
              //   onPressed: () {
              //     setState(() {
              //       enteredPin = '';
              //       list.clear();
              //     });
              //   },
              //   child: const Text(
              //     'Reset',
              //     style: TextStyle(
              //       fontSize: 20,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              //fingerprint start here
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            Fluttertoast.showToast(
                msg: 'Access Granted', backgroundColor: Colors.blue);
            Get.to(() => const MainPage());
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
