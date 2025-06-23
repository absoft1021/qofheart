// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:qofheart/components/loading_dialog.dart';

class KycController extends GetxController {
  final bvnController = TextEditingController();
  final box = GetStorage();

  var list = ['BVN', 'NIN'];
  String selectedItem = 'BVN';

  Future<void> updateBVN(BuildContext context, String num) async {
    LoadingDialog(context: context).showLoading();
    String url = 'https://www.qofheart.com/api/kyc/';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({"id": num}),
      headers: {
        "Token": box.read("token"),
        "Content-Type": "application/json",
      },
    );
    debugPrint(response.body);
    Map data = jsonDecode(response.body);
    Get.back();

    if (response.statusCode == 200) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: "Verification Successful",
        dismissOnBackKeyPress: true,
        desc: data['msg'],
        btnOkText: 'Ok',
        btnOkOnPress: () => Get.close(0),
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: "Message",
        dismissOnBackKeyPress: true,
        desc: data['msg'],
        btnCancelText: 'Close',
        btnCancelOnPress: () => Get.close(0),
      ).show();
    }
  }
}
