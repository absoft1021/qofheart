import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qofheart/controllers/transfer_controller.dart';

class TransferPage extends StatelessWidget {
  TransferPage({super.key});

  final controller = Get.put(TransferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Transfer Bonus'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Visibility(
                visible: false,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    items: controller.list
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      controller.selectedItem = value!;
                    },
                    value: controller.selectedItem,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.bvnController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Enter your amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: Get.width,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.bvnController.text.length < 2) {
                      Get.snackbar('Message', 'Please enter amount');
                    } else {
                      String num = controller.bvnController.text.trim();
                      controller.updateBVN(context, num);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E47A1),
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
