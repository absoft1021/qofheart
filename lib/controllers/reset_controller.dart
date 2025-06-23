// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:qofheart/components/loading_dialog.dart';

class ResetController extends GetxController {
  final box = GetStorage();

  Future<void> reset(BuildContext context, String email) async {
    LoadingDialog(context: context).showLoading();
    String passUrl = 'https://www.qofheart.com/auth/forgot_password.php';
    final response =
        await http.post(Uri.parse(passUrl), body: jsonEncode({"Email": email}));
    Map data = jsonDecode(response.body);
    Get.back();
    if (response.statusCode == 200) {
      if (data['success'] == '1') {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: "Email Sent",
                desc: data['msg'],
                dismissOnBackKeyPress: true)
            .show();
      }
    } else {
      Get.back();
      AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: "Error Message",
              desc: data['msg'],
              dismissOnBackKeyPress: true)
          .show();
    }
  }
}
