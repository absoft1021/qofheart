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
          backgroundColor: const Color(0xFFF9F9F9),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    controller.filteredList.value = controller.history
                        .where((item) => item['desc']
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search transaction...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              searchController.clear();
                              controller.filteredList.value = controller.history;
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ),

              // Transactions
              Expanded(
                child: controller.obx(
                  (data) => Obx(
                    () => ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: controller.filteredList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        var item = controller.filteredList[index];
                        return InkWell(
                          onTap: () => Get.to(
                            () => const ReceiptPage(),
                            arguments: item,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "₦${item['amount']}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item['desc'],
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item['date'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  onLoading: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  onEmpty: Center(
                    child: Text(
                      'No transaction record found',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                  onError: (error) => Center(
                    child: Text(
                      'Something went wrong.',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}