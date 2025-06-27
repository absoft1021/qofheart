// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';
import 'package:qofheart/components/abdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qofheart/components/loading_dialog.dart';

class PurchaseController extends GetxController {
  final box = GetStorage();
  bool isLoading = true;
  RxBool isVisible = true.obs;

  final phoneController = TextEditingController();
  final _contactPicker = FlutterNativeContactPicker();
  var phoneNumber = "";

  pickNumber() async {
    Contact? contact = await _contactPicker.selectContact();

    String phone = contact
        .toString()
        .substring(contact.toString().indexOf('['), contact.toString().length);
    phoneNumber = phone
        .replaceAll(' ', '')
        .replaceAll('+234', '0')
        .replaceAll('[', '')
        .replaceAll(']', '');
    phoneController.text = phoneNumber;
    update();
  }

  Future<void> buyAirtime(
      BuildContext context, String phone, String netId, String amount) async {
    LoadingDialog(context: context).showLoading();
    String airtimeUrl = 'https://www.qofheart.com/api/airtime/';
    final response = await http.post(
      Uri.parse(airtimeUrl),
      body: jsonEncode(
        {
          "phone": phone,
          "network": netId,
          "amount": amount,
        },
      ),
      headers: {
          "Authorization": "Token ${box.read('token') ?? ''}",
          "Content-Type": "application/json",
        },
    );
    Get.back();
    Map data = jsonDecode(response.body);
    if (data["status"] == "success") {
      Abdialog().showDialog('You have purchased N$amount to $phone successfully', true);
    } else {
      Abdialog().showDialog(data['msg'], false);
    }
  }

  Future<void> buyData(BuildContext context, String phone, String netId,
      String plan, bool ported) async {
    LoadingDialog(context: context).showLoading();
    String dataUrl = 'https://www.qofheart.com/api/data/';
    final response = await http.post(
      Uri.parse(dataUrl),
      body: json.encode({
        "phone": phone,
        "network": netId,
        "plan": plan,
        "ported_number": ported
      }),
      headers: {
        "Token": box.read("token"),
        "Content-Type": "application/json",
      },
    );
    Get.back();
    Map data = jsonDecode(response.body);
    if (data["status"] == "success") {
      Abdialog().showDialog(data['msg'], true);
    } else {
      Abdialog().showDialog(data['msg'], false);
    }
  }
}
