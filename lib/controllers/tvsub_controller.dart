// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:qofheart/components/loading_dialog.dart';

class TvsubController extends GetxController {
  final box = GetStorage();
  RxBool isVisible = true.obs;

  Future<void> checkTv(BuildContext context, String provider, String price,
      String plan, String icu, String phone) async {
    LoadingDialog(context: context).showLoading();
    String airtimeUrl = 'https://www.qofheart.com/api/validate-cable/';
    final response = await http.post(
      Uri.parse(airtimeUrl),
      body: jsonEncode({"provider": provider, "iucnumber": icu}),
      headers: {
        "Token": box.read("token"),
      },
    );
    Map data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data['status'] == 'success') {
        buyTVPLAN(context, provider, icu, plan, phone);
      }
    } else {
      Get.back();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: "Error Message",
        dismissOnBackKeyPress: true,
        desc: data['msg'],
        btnCancelText: 'close',
        btnCancelOnPress: () => Get.close(1),
      ).show();
    }
  }

  Future<void> buyTVPLAN(BuildContext context, String provider, String icu,
      String plan, String phone) async {
    String cableUrl = 'https://www.qofheart.com/api/cable/';
    final response = await http.post(
      Uri.parse(cableUrl),
      body: jsonEncode({
        "provider": provider,
        "iucnumber": icu,
        "plan": plan,
        "phone": phone
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
          dismissOnBackKeyPress: true,
          desc: data['msg'],
          btnOkText: 'ok',
          btnOkOnPress: () => Get.close(1),
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
        btnCancelText: 'close',
        btnCancelOnPress: () => Get.close(1),
      ).show();
    }
  }
}
