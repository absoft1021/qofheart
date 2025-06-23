import 'package:get/get.dart';
import 'package:qofheart/controllers/account_controller.dart';
import 'package:qofheart/controllers/airtime_cash_controller.dart';
import 'package:qofheart/controllers/data_controller.dart';
import 'package:qofheart/controllers/electric_controller.dart';
import 'package:qofheart/controllers/history_controller.dart';
import 'package:qofheart/controllers/home_controller.dart';
//import 'package:qofheart/controllers/network_controller.dart';
import 'package:qofheart/controllers/purchase_controller.dart';
import 'package:qofheart/controllers/reset_controller.dart';
import 'package:qofheart/controllers/smile_controller.dart';
import 'package:qofheart/controllers/tvsub_controller.dart';
import 'package:qofheart/controllers/upgrade_controller.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(AccountController());
    Get.put(DataController());
    Get.put(PurchaseController());
    Get.put(TvsubController());
    Get.put(ElectricController());
    Get.put(SmileController());
    Get.lazyPut(() => UpgradeController());
    Get.put(HistoryController());
    Get.lazyPut(() => ResetController());
 //   Get.put(NetworkController());
    Get.put(AirtimeCashController());
  }
}
