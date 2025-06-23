import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationDialog {
  final box = GetStorage();

  showNotification(BuildContext context, int dur) async {
    await Future.delayed(Duration(seconds: dur));
    // ignore: use_build_context_synchronously
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Notification',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold,),
                ),
                const SizedBox(height: 10),
                Text(
                  box.read('profile')['Notification'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 15),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () => Get.close(0), child: const Text('close'),)
              ],
            ),
          ),
        );
      },
    );
  }
}
