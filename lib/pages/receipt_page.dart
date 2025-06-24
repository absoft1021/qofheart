import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffeff3fa),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Receipt',
                style: GoogleFonts.labrada(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0E47A1),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2.5),
                      },
                      border: TableBorder.all(color: Colors.grey.shade300),
                      children: [
                        _tableRow('Status', 'Successful'),
                        _tableRow('Amount', 'NGN ${arguments['amount'] ?? ''}'),
                        _tableRow('Desc', arguments['desc'] ?? ''),
                        _tableRow('Previous Balance', 'NGN ${arguments['newBal'] ?? ''}'),
                        _tableRow('Old Balance', 'NGN ${arguments['oldbal'] ?? ''}'),
                        _tableRow('Date', arguments['date'] ?? ''),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Uncomment to use SHARE button
              // ElevatedButton(
              //   onPressed: () => Get.find<HomeController>().openUrl('link'),
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     backgroundColor: const Color(0xFF0E47A1),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              //   ),
              //   child: const Text('SHARE'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _tableRow(String title, String value) {
    return TableRow(
      children: [
        _textCell(title, align: TextAlign.left),
        _textCell(value, align: TextAlign.right),
      ],
    );
  }

  Widget _textCell(String text, {TextAlign align = TextAlign.center}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        textAlign: align,
        style: GoogleFonts.poppins(fontSize: 14),
      ),
    );
  }
}