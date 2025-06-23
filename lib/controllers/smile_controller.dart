// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:qofheart/components/loading_dialog.dart';

class SmileController extends GetxController {
  final box = GetStorage();
  RxBool isVisible = true.obs;

  Future<void> buySmile(BuildContext context, String phone, String id) async {
    LoadingDialog(context: context).showLoading();
    String smileUrl = 'https://www.qofheart.com/api/smile/';
    final response = await http.post(
      Uri.parse(smileUrl),
      body: jsonEncode(
          {"phone": phone, "smileid": id, "account_type": "PhoneNumber"}),
      headers: {
        "Token": box.read("token"),
      },
    );
    Map data = jsonDecode(response.body);
    Get.back();

    if (response.statusCode == 200) {
      if (data['status'] == 'success') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "Purchase Successful",
          dismissOnBackKeyPress: true,
          desc: data['msg'],
          btnOkText: 'Ok',
          btnOkOnPress: () => Get.close(1),
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "Error Message",
          dismissOnBackKeyPress: true,
          desc: data['msg'],
          btnCancelText: 'Close',
          btnCancelOnPress: () => Get.close(1),
        ).show();
      }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: "Error Message",
        dismissOnBackKeyPress: true,
        desc: data['msg'],
        btnCancelText: 'Close',
        btnCancelOnPress: () => Get.close(1),
      ).show();
    }
  }
}
