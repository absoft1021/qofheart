import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset('assets/images/user.png', height: 100, width: 100),
              const SizedBox(height: 10),
              Text(
                "User Status: ${box.read('profile')['UserType']}",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4F21F3)),
              ),
              const SizedBox(height: 15),
              const Divider(
                height: 10,
                color: Colors.grey,
              ),
              const SizedBox(height: 15),
              userDetails(context, 'First Name', 'fname'),
              const SizedBox(height: 15),
              userDetails(context, 'Last Name', 'lname'),
              const SizedBox(height: 15),
              userDetails(context, 'Phone', 'phone'),
              const SizedBox(height: 15),
              userDetails(context, 'Email', 'email'),
              const SizedBox(height: 15),
              userDetails(context, 'JoinDate', 'JoinDate'),
              const SizedBox(height: 15),
              const Divider(
                height: 10,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userDetails(BuildContext context, String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                '$key:',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      box.read('profile')[value] ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
