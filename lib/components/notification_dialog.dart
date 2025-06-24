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

    final String subject = notifications[0]['subject'] ?? 'No subject';
    final String message = notifications[0]['message'] ?? 'No message';

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            subject,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Close',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0E47A1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}