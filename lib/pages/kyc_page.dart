import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qofheart/controllers/kyc_controller.dart';

class KycPage extends StatelessWidget {
  KycPage({super.key});

  final controller = Get.put(KycController());

  final List<String> idTypes = ['BVN', 'NIN'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KYC Verification'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0E47A1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Verify Your Identity",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Choose an ID type and provide the required number.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 30),

                // ID Type Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select ID Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.credit_card),
                  ),
                  value: controller.selectedItem,
                  items: idTypes
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedItem = value;
                    }
                  },
                ),
                const SizedBox(height: 20),

                // ID Number Input
                TextField(
                  controller: controller.bvnController,
                  keyboardType: TextInputType.number,
                  maxLength: controller.selectedItem == 'BVN' ? 11 : 11,
                  decoration: InputDecoration(
                    labelText: '${controller.selectedItem} Number',
                    hintText: 'Enter your ${controller.selectedItem}',
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.perm_identity),
                  ),
                ),
                const SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.verified_user),
                    label: const Text('Verify'),
                    onPressed: () {
                      final idNumber = controller.bvnController.text.trim();
                      final selected = controller.selectedItem;

                      if (idNumber.length != 11) {
                        Get.snackbar(
                          'Invalid $selected',
                          '$selected must be 11 digits.',
                          backgroundColor: Colors.red.shade100,
                          colorText: Colors.red.shade900,
                        );
                      } else {
                        controller.updateBVN(context, idNumber);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E47A1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}