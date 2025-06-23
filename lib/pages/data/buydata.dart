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
  final Map<String, dynamic> args = Get.arguments;

  @override
  void initState() {
    super.initState();
    final id = args['id'];
    c.networkId.value = id;

    if (id == 1) {
      c.dataPlans(context, 1, "mtnsme");
    } else if (id == 2) {
      c.dataPlans(context, 2, "glo");
    } else if (id == 3) {
      c.dataPlans(context, 3, "etisalat");
    } else if (id == 4) {
      c.dataPlans(context, 4, "airtel");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F5FA),
      appBar: AppBar(
        title: Text('Buy Data', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          const SizedBox(height: 15),

          // Plan Type Toggle Buttons (Dynamically from API)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plan Type',
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                GetBuilder<BuydataController>(
                  builder: (c) {
                    if (c.mtnLabels.isEmpty) {
                      return Text("No options available", style: TextStyle(color: Colors.grey));
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ToggleButtons(
                        isSelected: List.generate(
                          c.mtnLabels.length,
                          (index) => c.selectedIndex == index,
                        ),
                        children: c.mtnLabels
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  item['Name']?.toString() ?? '',
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                        onPressed: (index) {
                          String value = c.mtnLabels[index]['Type'].toString();
                          c.filterPlans(value.toLowerCase());
                          c.selectedIndex = index; // Update the selected index
                          c.update(); // Call update to refresh the GetBuilder
                        },
                        borderRadius: BorderRadius.circular(8),
                        selectedColor: Colors.white,
                        fillColor: const Color(0xFF0E47A1),
                        color: const Color(0xFF0E47A1).withOpacity(0.8),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Data Plan Selection Section (Filtered Plans)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Plan',
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),

                GetBuilder<BuydataController>(builder: (_) {
                  return DropdownMenu(
                    width: Get.width - 40,
                    hintText: 'Select Data Plan',
                    dropdownMenuEntries: c.flist.map((item) {
                      return DropdownMenuEntry(
                        value: item['PlanId'],
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
                    onSelected: (value) => c.planId = value.toString(),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Phone Number Input
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: c.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  onPressed: () => c.pickNumber(),
                  icon: const Icon(Icons.contact_phone),
                  color: const Color(0xFF0E47A1),
                ),
                border: const UnderlineInputBorder(),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Purchase Button
          InkWell(
            onTap: () {
              c.handlePurchase(context);
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF0E47A1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Purchase',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}