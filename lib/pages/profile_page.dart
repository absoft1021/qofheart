import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final profile = box.read('profile') ?? {};

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF0E47A1)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0E47A1),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Profile',
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: const AssetImage('assets/images/user.png'),
                    radius: 50,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "User Status: ${profile['UserType'] ?? ''}",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4F21F3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildDetailCard('First Name', profile['fname']),
            _buildDetailCard('Last Name', profile['lname']),
            _buildDetailCard('Phone', profile['phone']),
            _buildDetailCard('Email', profile['email']),
            _buildDetailCard('Join Date', profile['JoinDate']),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String? value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          SizedBox(
            width: 180,
            child: Text(
              value ?? '',
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}