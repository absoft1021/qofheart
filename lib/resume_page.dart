import 'package:qofheart/views/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/components/local_auth_api.dart';
import 'package:qofheart/views/main_page.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageWidgetState();
}

class _ResumePageWidgetState extends State<ResumePage> {
  final box = GetStorage();
  String enteredPin = '';
  List list = [];
  bool isPinVisible = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white, actions: [
          PopupMenuButton(
              color: Colors.white,
              itemBuilder: (itemBuilder) => [
                    PopupMenuItem(
                        child: InkWell(
                      onTap: () => Get.to(LoginPage()),
                      child: const Row(
                        children: [
                          Icon(Icons.logout, size: 20, color: Colors.red),
                          SizedBox(width: 10),
                          Text(
                            "Logout",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ))
                  ])
        ]),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                  "Hi, ${box.read('profile')['fname']}",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "You can also use the fingerprint to login",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 14,
                    color: const Color(0xFF09575F),
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
                      width: isPinVisible ? 20 : 16,
                      height: isPinVisible ? 20 : 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: index < enteredPin.length
                            ? isPinVisible
                                ? Colors.grey
                                : CupertinoColors.activeBlue
                            : CupertinoColors.activeBlue.withOpacity(0.1),
                      ),
                      child: isPinVisible && index < enteredPin.length
                          ? Center(
                              child: Text(
                                "",
                                style: GoogleFonts.aBeeZee(
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
              const SizedBox(height: 2),
              // last row containing fingerprint, 0 and backspace
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 15, left: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[100],
                      ),
                      child: InkWell(
                        onTap: () async {
                          final isAuthenticated =
                              await LocalAuthApi.authenticate();

                          if (isAuthenticated) {
                            Fluttertoast.showToast(
                                msg: 'Access Granted',
                                backgroundColor: Colors.blue);
                            Get.to(() => const MainPage());
                          }
                        },
                        child: Image.asset(
                          'assets/images/fingerprintx.png',
                          height: 30,
                          width: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      padding: const EdgeInsets.only(right: 4),
                      child: numButton(0),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[100],
                      ),
                      child: TextButton(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // this widget will be use for each digit
  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[100],
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              if (enteredPin.length < 4) {
                enteredPin += number.toString();

                if (enteredPin.length == 4) {
                  if (enteredPin == box.read('pin')) {
                    Get.to(() => const MainPage());
                  } else {
                    enteredPin = '';
                    Get.snackbar(
                      'Error Message',
                      'Incorrect pin',
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                    );
                  }
                }
              }
            });
          },
          child: Text(
            number.toString(),
            style: GoogleFonts.aBeeZee(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
