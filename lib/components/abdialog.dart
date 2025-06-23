import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Abdialog {
  showDialog(String content, bool type) {
    Get.dialog(Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          //alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    type ? 'Success' : 'Message',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Get.width - 20,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: type ? Colors.green : Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Close'),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: -30,
              child: CircleAvatar(
                backgroundColor: type ? const Color.fromRGBO(76, 175, 80, 1) : Colors.red,
                maxRadius: 35,
                child: Icon(
                  type ? Icons.check : Icons.close,
                  color: Colors.white,
                  size: 30,
                )
                    .animate(
                      autoPlay: true,
                      onComplete: (controller) => controller.repeat(),
                    )
                    .shake(
                      duration: const Duration(milliseconds: 400),
                    ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
