import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/home_controller.dart';

class AddMoneyPage extends StatefulWidget {
  const AddMoneyPage({super.key});

  @override
  State<AddMoneyPage> createState() => _AddMoneyPageState();
}

class _AddMoneyPageState extends State<AddMoneyPage> {
  List<dynamic> list = [];
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    final profile = box.read('profile');
    if (profile != null && profile['bank_details'] is List) {
      list = (profile['bank_details'] as List).where((item) {
        final acc = item['AccountNumber'];
        return acc != null && acc.toString().trim().isNotEmpty;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0E47A1),
          title: Text(
            'Bank Transfer',
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: list.isEmpty
            ? Center(
                child: Text(
                  "No bank details available.",
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final item = list[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: const Color(0xFF0E47A1), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.account_balance, color: Color(0xFF0E47A1)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item['BankName'] ?? 'Unknown Bank',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0E47A1),
                                ),
                              ),
                            ),
                            Text(
                              item['Charges'] ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.red[700],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Account Number:",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item['AccountNumber'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Get.find<HomeController>()
                                  .copyText(item['AccountNumber']),
                              icon: const Icon(Icons.copy, color: Colors.blue),
                              tooltip: "Copy Account Number",
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Account Name:",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['Name'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}