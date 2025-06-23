// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:qofheart/pages/history_page.dart';
import 'package:qofheart/pages/home_page.dart';
import 'package:qofheart/pages/more_page.dart';
import 'package:qofheart/resume_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int initialPosition = 0;

  final PageController _controller = PageController(initialPage: 0);

  List<Widget> pages = [
    const HomePage(),
    const HistoryPage(),
    const MorePage()
  ];

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackedPressed() async {
      return await showDialog(
        context: context,
        builder: (builder) => AlertDialog(
          content: const Text('Do you want to exit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: initialPosition,
        backgroundColor: Colors.white,
        elevation: 15,
        //  selectedItemColor: const Color(0xFF041262),
        //  unselectedItemColor: Colors.grey,
        onDestinationSelected: (value) {
          setState(() {
            initialPosition = value;
            _controller.jumpToPage(value);
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(
                Icons.history_rounded,
              ),
              label: 'History'),
          NavigationDestination(
              icon: Icon(
                Icons.settings,
              ),
              label: 'More')
        ],
      ),
      body: FocusDetector(
        onForegroundGained: () => Get.to(() => const ResumePage()),
        child: PopScope(
          canPop: false,
          onPopInvoked: (canpop) => _onBackedPressed(),
          child: PageView(
            controller: _controller,
            children: pages,
            onPageChanged: (value) {
              setState(() {
                initialPosition = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
