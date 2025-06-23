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
  List list = [];
  List data = [];

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    list = box.read('profile')['Account'];
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Bank Transfer',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: [
                const SizedBox(height: 20),
                
                for (int i = 0; i < list.length; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.greenAccent[50],
                      border: Border.all(color: const Color(0xFF0E47A1)),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: IconButton(
                              onPressed: () => Get.find<HomeController>()
                                  .copyText(list[i]['AccountNumber']),
                              icon: const Icon(Icons.copy)),
                          title: Text("${list[i]['BankName']}",
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: const Color(0xFF0E47A1),
                                  fontWeight: FontWeight.w600)),
                          subtitle: Text(
                            "${list[i]['AccountNumber']}\n${list[i]['Name']}",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(fontSize: 15),
                          ),
                          trailing: Text(
                            "${list[i]['Charges']}",
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: const Color(0xFF800000)),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
