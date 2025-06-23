import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/home_controller.dart';

class ManualTransfer extends StatefulWidget {
  const ManualTransfer({super.key});

  @override
  State<ManualTransfer> createState() => _ManualTransferState();
}

class _ManualTransferState extends State<ManualTransfer> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Manual Transfer',
            style: GoogleFonts.poppins(fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                'NOTE: The minimum funding for manual transfer is N2,000',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Access Bank',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0E47A1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Daniel Babatunde Emmanuel',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '6101294482',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.find<HomeController>()
                                  .copyText('6101294482');
                            },
                            icon: const Icon(Icons.copy, size: 18),
                            label: const Text('Copy'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final profile = box.read('profile');
                              final contact = (profile != null &&
                                      profile['Contact'] is List &&
                                      profile['Contact'].isNotEmpty)
                                  ? profile['Contact'][0]['call'] ?? ''
                                  : '';

                              if (contact == '') {
                                Get.snackbar("Error", "Contact number not found",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                                return;
                              }

                              Get.defaultDialog(
                                title: "Warning",
                                contentPadding: const EdgeInsets.all(10),
                                content: const Text(
                                  "Your account will be suspended if found that you click on OK while you did not send the money",
                                  textAlign: TextAlign.center,
                                ),
                                onCancel: () => Navigator.pop(context),
                                onConfirm: () {
                                  Navigator.pop(context);
                                  Get.find<HomeController>()
                                      .openUrl("https://wa.me/+234$contact");
                                },
                              );
                            },
                            icon: const Icon(Icons.support_agent, size: 18),
                            label: const Text('Contact Admin'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0E47A1),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}