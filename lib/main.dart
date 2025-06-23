import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qofheart/all_controller_binding.dart';
import 'package:qofheart/resume_page.dart';
import 'package:qofheart/views/welcome_page.dart';
//import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Upgrader.clearSavedSettings();
  await GetStorage.init();
  runApp(const MyApp());

  // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // OneSignal.initialize("ec86aa78-82d2-4cb1-8a0d-a33801342f04");
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return GetMaterialApp(
      initialBinding: AllControllerBinding(),
      title: 'qofheart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // Set Scaffold background to white
      ),
      home:
          box.read('phone') == null ? const WelcomePage() : const ResumePage(),
    );
  }
}
