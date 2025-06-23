// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:qofheart/components/loading_dialog.dart';

class UpgradeController extends GetxController {
  final box = GetStorage();

  Future<void> upgrage(BuildContext context, String type) async {
    LoadingDialog(context: context).showLoading();
    String upgrageUrl = 'https://www.qofheart.com/auth/upgradeuser.php';
    final response = await http.post(
      Uri.parse(upgrageUrl),
      body: jsonEncode({"type": type}),
      headers: {
        "Token": box.read("token"),
      },
    );
    Map data = jsonDecode(response.body);
    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      if (data['success'] == '1') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: "Purchase Successful",
          autoDismiss: true,
          desc: data['msg'],
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "Error Message",
          autoDismiss: true,
          desc: data['msg'],
        ).show();
      }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: "Error Message",
        autoDismiss: true,
        desc: data['msg'],
      ).show();
    }
  }
}
