import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DataController extends GetxController with StateMixin {
  final box = GetStorage();
  var currentPosition = 0;
  bool isLoading = true;
  var flist = [];
  var plans = [];

  var network = ['mtn', 'glo', 'etisalat', 'airtel'];

void filterPlans(String planType) {
  flist = plans.where((category) {
    return category['DataType'].toString().toLowerCase() == planType.toLowerCase();
  }).toList();
}

Future<void> dataPlans(int networkId, String query) async {
  plans.clear();
  flist.clear();

  String dataPlansUrl = 'https://qofheart.com/api/app/data_plans.php?dataNetwork=$networkId';
  change(null, status: RxStatus.loading());

  try {
    final response = await http.get(
      Uri.parse(dataPlansUrl),
      headers: {
        'Authorization': "Token ${box.read('token')}",
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      // Convert to list of maps
      plans = List<Map<String, dynamic>>.from(result['plans']);

      // Optional: filter only those that match the given query
      filterPlans(query);

      change(flist, status: RxStatus.success());
      update();
    } else {
      change([], status: RxStatus.error('Failed to fetch'));
    }
  } catch (e) {
    change([], status: RxStatus.error(e.toString()));
  }
}

  Future<void> allPlans() async {
    String loginUrl = 'https://qofheart.com/api/app/data_plans.php';
    final response = await http.get(
      Uri.parse(loginUrl),
      headers: {'Authorization': "Token ${box.read('token')}", 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      Map data = result;
      isLoading = false;
      plans = data['plans'];
      update();
    } else {
      throw Exception('failed to fetch');
    }
  }

  Future<void> cablePlans(String cId) async {
    plans.removeRange(0, plans.length);
    String cableUrl = 'https://qofheart.com/api/app/cables.php?cableProvider=$cId';
    final response = await http.get(
      Uri.parse(cableUrl),
      headers: {'Authorization': "Token ${box.read('token')}", 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      isLoading = false;
      plans = result;
      update();
    } else {
      throw Exception('failed to fetch');
    }
  }

  Future<void> smileBundle() async {
    plans.removeRange(0, plans.length);
    String loginUrl = 'https://qofheart.com/api/smile/smile_plan.php';
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Authorization': "Token ${box.read('token')}", 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      Map data = result;
      isLoading = false;
      plans = data['plans'];
      update();
    } else {
      throw Exception('failed to fetch');
    }
  }

  updatePosition(int pos) {
    currentPosition = pos;
  }
}
