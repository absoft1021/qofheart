import 'dart:convert';
import 'package:qofheart/components/abdialog.dart';
import 'package:qofheart/components/loading_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:qofheart/components/app_constants.dart';
import 'package:qofheart/components/local_auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom_pin_keyboard/custom_pin_keyboard.dart';
import 'package:get_storage/get_storage.dart';

class BuydataController extends GetxController with StateMixin {
  final _contactPicker = FlutterNativeContactPicker();
  final phoneController = TextEditingController();

  final box = GetStorage();
  var phoneNumber = "";
  String planId = "";
  var selectedIndex = 0;
  RxInt networkId = 1.obs;
  RxBool isMTN = false.obs;
  var mtnLabels = [];
  List companies = [
    {"id": "1", "title": "MTN", "logo": "assets/images/mtn.jpg"},
    {"id": "2", "title": "AIRTEL", "logo": "assets/images/airtelx.jpg"},
    {"id": "3", "title": "GLO", "logo": "assets/images/glo.jpg"},
    {"id": "4", "title": "9MOBILE", "logo": "assets/images/mobile.jpg"},
  ];
  var position = (-1).obs;

  var plans = [];
  var flist = [];
  List net = [
    'assets/images/mtn.jpg',
    'assets/images/airtelx.jpg',
    'assets/images/glo.jpg',
    'assets/images/mobile.jpg'
  ];
  changePosition(int pos) {
    position.value = pos;
    update();
  }

  var currentPosition = 0;
  bool isLoading = true;

  var network = ['mtn', 'glo', 'etisalat', 'airtel'];
  void filterPlans(String plan) {
    flist = plans.where((category) {
      return category['DataType'].toLowerCase().contains(plan);
    }).toList();
    update();
  }
    // Function to handle purchase
  void handlePurchase(BuildContext context) {
    String phone = phoneController.text;
    String planId = this.planId;
    String netId = networkId.toString();

    // Validate the data plan and phone number
    if (planId.isEmpty) {
      showError(context, 'Choose data plan');
    } else if (phone.length < 11) {
      showError(context, 'Enter valid phone number');
    } else {
      // Show the pin/biometric modal
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
              child: CustomPinKeyboard(
                length: 4,
                buttonBackground: Colors.transparent,
                indicatorProgressColor: AppConstants.primaryColor,
                indicatorBackground: const Color(0xFFB5D1D3),
                textStyle: const TextStyle(
                  fontSize: 20,
                  height: 32 / 24,
                  fontWeight: FontWeight.w600,
                ),
                additionalButton: Image.asset(
                  'assets/images/fingerprint.png',
                  height: 25,
                  width: 25,
                ),
                onAdditionalButtonPressed: () async {
                  final isAuthenticated = await LocalAuthApi.authenticate();
                  if (isAuthenticated) {
                    Get.back();
                    buyData(context, phone, netId, planId, false);
                  }
                },
                onCompleted: (passcode) async {
                  if (passcode == box.read('pin')) {
                    Get.back();
                    buyData(context, phone, netId, planId, false);
                  }
                },
              ),
            ),
          );
        },
      );
    }
  }

  // Other methods like showError and buyData will remain unchanged

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

  Future<void> dataPlans(BuildContext ctx,int netwId, String query) async {
    LoadingDialog(context: ctx).showLoading();
    flist.isNotEmpty ? plans.removeRange(0, plans.length) : null;
    plans.isNotEmpty ? plans.removeRange(0, plans.length) : null;

    String dataPlansUrl = 'https://qofheart.com/api/app/data_plans.php';
    change(null, status: RxStatus.loading());
    try {
      final response = await Dio().get(dataPlansUrl,
          options: Options(headers: {
            'Authorization': "Token ${box.read('token')}",
            'Content-Type': 'application/json'
      }));
      Get.back();    
      Map data = response.data;
      plans = data['plans'];
      mtnLabels = data['Data'];
      change(plans, status: RxStatus.success());
      filterPlans(query);
      update();
    } catch (e) {
      change(plans, status: RxStatus.error());
      throw Exception('failed to fetch');
    }
  }

  void showError(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
      ),
    );
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
        "Authorization": "Token ${box.read('token')}",
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
