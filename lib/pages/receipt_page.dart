import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';

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
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0E47A1),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _receiptItem(Icons.verified, "Status", arguments['status'] == 1 ? "failed" : "Successful", arguments['status'] == 1 ? Colors.red : Colors.green),
                      _receiptItem(Icons.attach_money, "Amount", "NGN ${arguments['amount'] ?? ''}"),
                      _receiptItem(Icons.description_outlined, "Description", arguments['desc'] ?? ''),
                      _receiptItem(Icons.account_balance_wallet_outlined, "Old Balance", "NGN ${arguments['oldbal'] ?? ''}"),
                      _receiptItem(Icons.savings_outlined, "New Balance", "NGN ${arguments['newbal'] ?? ''}"),
                      _receiptItem(Icons.calendar_today_outlined, "Date", arguments['date'] ?? ''),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _generateAndSharePDF(arguments),
                icon: const Icon(Icons.share),
                label: const Text('Share Receipt'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E47A1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _receiptItem(IconData icon, String label, String value, [Color color = Colors.black87]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF0E47A1), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
                const SizedBox(height: 4),
                Text(value, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateAndSharePDF(Map<String, dynamic> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Payment Receipt", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.blue)),
                pw.SizedBox(height: 20),
                _pdfRow("Status", "Successful"),
                _pdfRow("Amount", "NGN ${data['amount'] ?? ''}"),
                _pdfRow("Description", data['desc'] ?? ''),
                _pdfRow("Old Balance", "NGN ${data['oldbal'] ?? ''}"),
                _pdfRow("New Balance", "NGN ${data['newbal'] ?? ''}"),
                _pdfRow("Date", data['date'] ?? ''),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/receipt.pdf");
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(file.path)], text: "Here's your receipt");
  }

  pw.Widget _pdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text("$label: ", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Expanded(child: pw.Text(value)),
        ],
      ),
    );
  }
}