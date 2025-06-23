import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:qofheart/models/history_model.dart';

class ApiService extends GetConnect {
  final box = GetStorage();

  Future<List<HistoryModel>> getHistory() async {
    String url = 'https://www.qofheart.com/auth/history.php';
    final response = await post(
      Uri.parse(url),
      headers: {'Token': box.read('token')},
    );

    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['order'];
      return result.map((e) => HistoryModel.fromJson(e)).toList();
    } else {
      throw Exception('failed to fetch data');
    }
  }
}
