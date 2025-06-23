import 'package:focus_detector/focus_detector.dart';
import 'package:qofheart/components/notification_dialog.dart';
import 'package:qofheart/pages/kyc_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/components/home_header.dart';
import 'package:qofheart/controllers/account_controller.dart';
import 'package:qofheart/controllers/home_controller.dart';
import 'package:qofheart/pages/whatsapp_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AccountController controller = Get.find<AccountController>();
  final GetStorage box = GetStorage();
  final HomeController homeController = Get.find<HomeController>();

  String? username;
  final List<Map<String, dynamic>> menus = [
    {"id": 1, "title": "Airtime", "icon": Icons.phone},
    {"id": 2, "title": "Data", "icon": Icons.wifi},
    {"id": 3, "title": "Cable", "icon": Icons.tv},
    {"id": 4, "title": "Exam", "icon": Icons.school_outlined},
    {"id": 5, "title": "Electric", "icon": Icons.lightbulb_circle},
    {"id": 6, "title": "to Cash", "icon": Icons.wallet_giftcard},
  ];

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    await controller.userDetails(false);
    final profile = box.read("profile");
    setState(() {
      username = profile?["fname"]?.toString() ?? "User";
    });
    if (mounted) {
      NotificationDialog().showNotification(context, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () => controller.userDetails(false),
        child: FocusDetector(
          onFocusGained: () => controller.userDetails(false),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              HomeHeader(),
              const SizedBox(height: 10),
              _buildHelpSupport(),
              const SizedBox(height: 16),
              _buildMenuGrid(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0E47A1),
      titleSpacing: 0,
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: Image.asset('assets/images/user.png', height: 24),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username ?? "User",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              'Welcome to Qofheart',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Get.to(() => const WhatsappPage()),
          icon: const Icon(Icons.support_agent, color: Colors.white, size: 24),
        ),
        IconButton(
          onPressed: () => controller.userDetails(true),
          icon: const Icon(Icons.refresh, color: Colors.white, size: 24),
        ),
      ],
    );
  }

  Widget _buildHelpSupport() {
    return GetBuilder<AccountController>(
      builder: (ctrl) => GestureDetector(
        onTap: () => Get.to(() => const WhatsappPage()),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green[50],
                child: const Icon(Icons.chat, color: Colors.green, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Help & Support',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Contact us anytime',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: menus.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) => _buildMenuItem(menus[index], index),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> menu, int index) {
    return GestureDetector(
      onTap: () => homeController.changePage(index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFF0E47A1).withOpacity(0.1),
              child: Icon(menu['icon'], color: const Color(0xFF0E47A1), size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              menu['title'],
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}