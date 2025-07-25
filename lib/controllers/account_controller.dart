import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:qofheart/components/pin_code.dart';
import 'package:qofheart/views/login_page.dart';
import 'package:qofheart/views/main_page.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountController extends GetxController {
  final box = GetStorage();

  var acct = [].obs;
  RxString walletBalance = "0.0".obs;
  RxString walletBonus = "0".obs;
  RxString kyc = "1".obs;
  RxString userName = "".obs;
  Map user = {};
  
  openUrl(String link) async {
    var url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Failed to lunch $url';
    }
  }

  Future<void> login(BuildContext context, String phone, String password) async {
    const url = 'https://www.qofheart.com/api/app/app_login.php';

    try {
      final res = await http.post(Uri.parse(url), body: {
        "phone": phone,
        "password": password,
      });

      Get.back();

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        if (data['status'] == "fail") {
          Get.snackbar('Error', data['msg'], margin: const EdgeInsets.all(10));
          return;
        }

        user = data['user'];
        kyc.value = user['kyc'].toString() ?? '';
        walletBalance.value = user['balance'].toString();
        walletBonus.value = user['bonus'].toString();

        box.write('profile', user);
        box.write('token', user['token']);
        box.write('phone', phone);
        box.write('password', password);
        acct.value = user['bank_details'];

        update();
        
        String? savedPin = box.read('pin');
        
        if (savedPin == null || savedPin.toString().isEmpty) {
          Get.to(() => PinCode()); // Ask to set PIN
        } else {
          Get.to(() => MainPage()); // Go to main app
        }
        
      } else {
        Get.snackbar('Error', 'Server error', margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  Future<void> register(BuildContext context, String fname, String lname, String email, String phone,
      String password, String cpassword, String state, String pin) async {
    const url = 'https://www.qofheart.com/api/app/app_register.php';

    try {
      final res = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          "fname": fname,
          "lname": lname,
          "email": email,
          "phone": phone,
          "password": password,
          "cpassword": cpassword,
          "state": state,
          "referal": "",
          "account": "",
          "transpin": pin
        }),
      );

      Get.back();

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final dialogType = data['status'] == "success" ? DialogType.success : DialogType.error;

        AwesomeDialog(
									  context: context,
									  dialogType: dialogType,
									  animType: AnimType.rightSlide,
									  title: data['status'] == "success" ? "Registered" : "Error Message",
									  desc: data['msg'],
								  btnOkText: data['status'] == "success" ? "Login" : "OK",
								  btnCancelText: "Close",
								  btnOkOnPress: data['status'] == "success"
								      ? () => Get.to(() => LoginPage())
								      : null,
								  btnCancelOnPress: () {},
								).show();
      } else {
        Get.snackbar('Message', res.body);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  Future<void> userDetails(bool isRefresh) async {
    const url = 'https://qofheart.com/api/app/user_details.php';

    try {
      final res = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': "Bearer ${box.read('token')}" ?? '',
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        if (data['status'] == "fail") {
          Get.snackbar('Error', data['msg'], margin: const EdgeInsets.all(10));
          return;
        }

        user = data['user'];
        kyc.value = user['kyc'].toString() ?? '';
        walletBalance.value = user['balance'].toString();
        walletBonus.value = user['bonus'].toString();

        box.write('profile', user);
        box.write('token', user['token']);
        box.write('phone', user['phone']);
        //box.write('password', password);
        acct.value = user['bank_details'];

        update();
        if (isRefresh) {
          Fluttertoast.showToast(
            msg: 'Account updated successfully',
            gravity: ToastGravity.TOP,
          );
        }

        update();
      } else {
        Get.snackbar('Error', 'An error occurred', margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}