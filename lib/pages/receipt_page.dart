import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/home_controller.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffeff3fa),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(color: Colors.white),
            ),
            ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Center(
                  child: Text(
                    'Receipt',
                    style: GoogleFonts.labrada(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Table(
                  textDirection: TextDirection.ltr,
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(3)
                  },
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      textView('Status'),
                      textView(Get.arguments['status'] ?? '')
                    ]),
                    TableRow(children: [
                      textView('Amount'),
                      textView("NGN${Get.arguments['amount'] ?? ''}"),
                    ]),
                    TableRow(children: [
                      textView('Desc'),
                      textView(Get.arguments['desc'] ?? '')
                    ]),
                    TableRow(children: [
                      textView('Previous\nBalance'),
                      textView("NGN${Get.arguments['newBal'] ?? ''}")
                    ]),
                    TableRow(children: [
                      textView('Old Balance'),
                      textView("NGN ${Get.arguments['oldbal'] ?? ''}")
                    ]),
                    TableRow(children: [
                      textView('Date'),
                      textView(Get.arguments['date'] ?? '')
                    ])
                  ],
                ),
                const SizedBox(height: 20),
                // ElevatedButton(
                //     onPressed: () => Get.find<HomeController>().openUrl('link'),
                //     style: ElevatedButton.styleFrom(
                //         foregroundColor: Colors.white,
                //         backgroundColor: const Color(0xFF0E47A1),
                //         shape: const ContinuousRectangleBorder()),
                //     child: const Text('SHARE'))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget textView(String value) => Container(
        margin: const EdgeInsets.all(10),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      );
}
