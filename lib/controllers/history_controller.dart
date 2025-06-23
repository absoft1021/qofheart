import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryController extends GetxController with StateMixin {
  var isLoading = true;
  final searchController = TextEditingController();
  List history = [];
  RxList filteredList = [].obs;

  var msg = '';
  final box = GetStorage();

  void getHistoryX() async {
    String loginUrl = 'https://qofheart.com/api/app/fetch_transactions.php';
    change(null, status: RxStatus.loading());
    final response = await http.get(
      Uri.parse(loginUrl),
      headers: {'Authorization': "Token ${box.read('token')}", 'Content-Type': 'application/json'},
    );

    var result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Map data = result;

      if (data['success'] == 'success') {
        history = data['data'];
        if (history.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          filteredList.value = history;
          change(history, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.empty());
      }
    } else {
      change(null, status: RxStatus.error());
      throw Exception("fail to fetched");
      //change(null, status: RxStatus.error());
    }
  }
}
