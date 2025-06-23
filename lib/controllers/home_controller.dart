import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qofheart/pages/airtime_cash.dart';
import 'package:qofheart/pages/electricity_page.dart';
import 'package:qofheart/pages/exam_page.dart';
import 'package:qofheart/services/buy_airtime.dart';
import 'package:qofheart/services/buy_tvsub.dart';
import 'package:qofheart/pages/data/data_network.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final _contactPicker = FlutterNativeContactPicker();
  final phoneController = TextEditingController();

  var phoneNumber = "";
  var position = 0;

  changePosition(int pos) {
    position = pos;
    update();
  }

  void copyText(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    Fluttertoast.showToast(msg: 'copied successfully');
  }

  openUrl(String link) async {
    var url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Failed to lunch $url';
    }
  }

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

  changePage(int position) {
    if (position == 0) {
      Get.to(() => const BuyAirtime());
    } else if (position == 1) {
      Get.to(() => const DataNetwork());
    } else if (position == 2) {
      Get.to(() => const BuyTvsub());
    } else if (position == 3) {
      Get.to(() => ExamPage());
    } else if (position == 4) {
      Get.to(() => const ElectricityPage());
    } else if (position == 5) {
      Get.to(() => AirtimeCash());
    }
  }
}
