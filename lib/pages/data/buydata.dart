import 'package:qofheart/pages/data/buydata_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Buydata extends StatefulWidget {
  const Buydata({super.key});

  @override
  State<Buydata> createState() => _BuydataState();
}

class _BuydataState extends State<Buydata> {
  final c = Get.put(BuydataController());
  var args = Get.arguments;

  @override
  void initState() {
    super.initState();
    c.dataPlans(context, args, "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F5FA),
      appBar: AppBar(
        title: Text(
          'Buy Data',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PLAN TYPE
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Plan Type', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  GetBuilder<BuydataController>(
                    builder: (c) {
                      if (c.mtnLabels.isEmpty) {
                        return Text("No options available", style: TextStyle(color: Colors.grey));
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(c.mtnLabels.length, (index) {
                            final item = c.mtnLabels[index];
                            final isSelected = c.selectedIndex == index;

                            return GestureDetector(
                              onTap: () {
                                String value = item['Type'].toString();
                                c.filterPlans(value.toLowerCase());
                                c.selectedIndex = index;
                                c.update();
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF0E47A1) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF0E47A1) : Colors.grey.shade400,
                                  ),
                                ),
                                child: Text(
                                  item['Name']?.toString() ?? '',
                                  style: GoogleFonts.poppins(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// DATA PLAN
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Data Plan', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  GetBuilder<BuydataController>(
                    builder: (c) {
                      return DropdownMenu<Map>(
                        width: Get.width - 56,
                        hintText: 'Select Data Plan',
                        dropdownMenuEntries: c.flist.map<DropdownMenuEntry<Map>>((item) {
                          return DropdownMenuEntry<Map>(
                            value: item, // Store the whole plan item
                            label: item['PlanName'],
                            trailingIcon: Text(
                              "NGN${item['price']}",
                              style: GoogleFonts.poppins(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onSelected: (value) {
                          // Save PlanId and PlanName
                          c.planId = value?['PlanId'].toString() ?? '';
                          c.planName = value?['PlanName'].toString() ?? '';
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// PHONE NUMBER
            Text('Phone Number', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextFormField(
                controller: c.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter number',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () => c.pickNumber(),
                    icon: const Icon(Icons.contact_phone, color: Color(0xFF0E47A1)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// PURCHASE BUTTON
            GestureDetector(
              onTap: () {
                c.handlePurchase(context);
              },
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF0E47A1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Purchase',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}