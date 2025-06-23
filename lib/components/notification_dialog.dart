import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationDialog {
  final box = GetStorage();

  Future<void> showNotification(BuildContext context, int dur) async {
    await Future.delayed(Duration(seconds: dur));

    final profile = box.read('profile');
    if (profile == null || profile['notifications'] == null) return;

    final List<dynamic> notifications = profile['notifications'];
    if (notifications.isEmpty) return;

    final subject = notifications[0]['subject'] ?? 'No subject';
    final message = notifications[0]['message'] ?? 'No message';

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(fontSize: 15),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}