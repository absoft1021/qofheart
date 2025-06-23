import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AirtimeCashController extends GetxController {
  String number = "";
  final box = GetStorage();

  TextEditingController network = TextEditingController();
  TextEditingController amount = TextEditingController();
  double discount = 0.0;

  void handleChange(String value) {
    discount = (double.parse(value) * 0.85);
    update();
  }
}
