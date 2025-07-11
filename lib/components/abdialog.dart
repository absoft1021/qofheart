import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Abdialog {
  void showDialog(String content, bool type) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle indicator
            Container(
              width: 50,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            
            // Animated icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: type ? Colors.green[50] : Colors.red[50],
                border: Border.all(
                  color: type ? Colors.green : Colors.red,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  type ? Icons.check_circle_rounded : Icons.error_rounded,
                  size: 48,
                  color: type ? Colors.green : Colors.red,
                )
                    .animate()
                    .scale(
                      duration: 300.ms,
                      curve: Curves.elasticOut,
                    )
                    .then()
                    .shake(
                      hz: 2,
                      duration: 400.ms,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Title
            Text(
              type ? 'Success!' : 'Oops!',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: type ? Colors.green : Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Got it',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
    );
  }
}
