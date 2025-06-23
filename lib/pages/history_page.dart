import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/history_controller.dart';
import 'package:qofheart/pages/receipt_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final controller = Get.put(HistoryController());
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.getHistoryX();
    controller.filteredList.value = controller.history;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   automaticallyImplyLeading: false,
          //   title: Text(
          //     'Transaction History',
          //     style: GoogleFonts.poppins(fontSize: 15),
          //   ),
          //   centerTitle: true,
          // ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: TextFormField(
                  onChanged: (value) {
                    controller.filteredList.value = controller.history
                        .where((item) => item['desc'].contains(value))
                        .toList();
                  },
                  decoration: InputDecoration(
                    hintText: 'Transaction History',
                    contentPadding: const EdgeInsets.all(8),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                        onPressed: () {
                          searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.close)),
                  ),
                  style: GoogleFonts.aBeeZee(fontSize: 15),
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              controller.obx(
                  (data) => Expanded(
                        child: Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.filteredList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = controller.filteredList[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.5, 0.5),
                                        blurRadius: .5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: InkWell(
                                  onTap: () => Get.to(() => const ReceiptPage(),
                                      arguments:
                                          controller.filteredList[index]),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 5,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.green
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10))),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "N${item['amount']}",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.9,
                                            child: Text(
                                              item['desc'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                          Text(
                                            item['date'],
                                            style: GoogleFonts.poppins(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  onLoading: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  onEmpty: Center(
                    child: Text(
                      'No transaction record found',
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                  ), onError: (error) {
                return Center(
                  child: Text(
                    'No transaction record found',
                    style: GoogleFonts.poppins(fontSize: 20),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
