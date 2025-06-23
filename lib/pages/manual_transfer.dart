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
  List<dynamic> list = [];
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    final profile = box.read('profile');
    if (profile != null && profile['Manual'] is List) {
      list = profile['Manual'];
    }
  }

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
            for (int i = 0; i < list.length; i++)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent[50],
                  border: Border.all(color: const Color(0xFF0E47A1)),
                ),
                child: ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      final accountNumber = list[i]['AccountNumber'] ?? '';
                      Get.find<HomeController>().copyText(accountNumber);
                    },
                  ),
                  title: Text(
                    list[i]['BankName'] ?? 'Unknown Bank',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF0E47A1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    "${list[i]['AccountNumber'] ?? 'N/A'}\n${list[i]['Name'] ?? ''}",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E47A1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text('I HAVE SENT THE MONEY'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}