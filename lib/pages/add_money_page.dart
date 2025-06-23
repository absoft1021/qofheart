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
      list = profile['bank_details'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bank Transfer',
            style: GoogleFonts.poppins(fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          children: [
            const SizedBox(height: 20),
            for (int i = 0; i < list.length; i++)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent[50],
                  border: Border.all(color: const Color(0xFF0E47A1)),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: IconButton(
                        onPressed: () => Get.find<HomeController>()
                            .copyText(list[i]['AccountNumber'] ?? ''),
                        icon: const Icon(Icons.copy),
                      ),
                      title: Text(
                        "${list[i]['BankName'] ?? 'Unknown Bank'}",
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
                      trailing: Text(
                        "${list[i]['Charges'] ?? ''}",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF800000),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}