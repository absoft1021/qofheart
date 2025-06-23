// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:qofheart/components/loading_dialog.dart';

class ElectricController extends GetxController {
  final box = GetStorage();
  RxBool isVisible = false.obs;

  Future<void> checkElectric(BuildContext context, String id, String mnum,
      String mtype, String phone, String amount) async {
    LoadingDialog(context: context).showLoading();
    String airtimeUrl =
        'https://www.qofheart.com/api/validate-electricity/';
    final response = await http.post(
      Uri.parse(airtimeUrl),
      body: jsonEncode(
          {"disco_id": id, "meter_number": mnum, "meter_type": mtype}),
      headers: {
        "Token": box.read("token"),
      },
    );
    Map data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data['status'] == 'success') {
        buyElectric(context, id, mnum, mtype, phone, amount);
      }
    } else {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: "Error Message",
        desc: data['msg'],
        dismissOnBackKeyPress: true,
        btnCancelText: 'close',
        btnCancelOnPress: () => Get.close(1),
      ).show();
    }
  }

  Future<void> buyElectric(BuildContext context, String id, String mnum,
      String mtype, String phone, String amount) async {
    String cableUrl = 'https://www.qofheart.com/api/electricity/';
    final response = await http.post(
      Uri.parse(cableUrl),
      body: jsonEncode({
        "disco_id": id,
        "meter_number": mnum,
        "meter_type": mtype,
        "phone": phone,
        "amount": amount
      }),
      headers: {
        "Token": box.read("token"),
      },
    );
    Map data = jsonDecode(response.body);
    Get.back();
    if (response.statusCode == 200) {
      if (data['status'] == 'success') {
        // LoadingDialog().cornfirm(context, plan, price);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: "Purchase Successful",
          autoDismiss: true,
          desc: data['msg'],
          dismissOnBackKeyPress: true,
          btnOkText: 'Ok',
          btnOkOnPress: () => Get.close(1),
        ).show();
      }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: "Error Message",
        desc: data['msg'],
        autoDismiss: true,
        btnCancelText: 'close',
        btnCancelOnPress: () => Get.close(1),
      ).show();
    }
  }
}
