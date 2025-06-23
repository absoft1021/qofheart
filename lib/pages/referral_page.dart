import 'package:qofheart/components/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/home_controller.dart';

class ReferralPage extends StatefulWidget {
  const ReferralPage({super.key});

  @override
  State<ReferralPage> createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  final box = GetStorage();
  late String phone;
  late String msd;

  @override
  void initState() {
    super.initState();
    phone = box.read('profile')['PhoneNumber'];
    msd =
        """Hi,My%20name%20is%20${box.read('profile')['Name']}.%20I%20am%20inviting%20%20to%20join%20the%20best%20Data%20application%20,%20Download%20the%20qofheart%20App%20on%20PlayStore%20to%20enjoy%20the%20following%20services:
        \n
*%20Internet%20Data
*%20Mobile%20Airtime
*%20Tv%20Subscription
*%20Electricity%20Bills
*%20Exam%20ePin
*%20Smile%20Bundle
*%20Data%20Card
*%20Airtime%20to%20Cash\n
And%20you%20can%20Earn%20N30,000%20or%20more%20by%20referring%20your%20family%20and%20friends

To%20Download%20the%20app%20from%20PlayStore,%20click%20the%20below%20link%20to%20start%20enjoying:

https://play.google.com/store/apps/details?id=qofheart.com.ng

And%20use%20$phone%20as%20your%20Referral%20code

""";
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20),
                color: const Color(OxFF0E47A1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/earn_ilu.png',
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/earn_ilu.png',
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/earn_ilu.png',
                          height: 40,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Card(
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/money_ilu.png',
                            height: 40,
                          ),
                          title: Text(
                            'Share your referral link and invite your friends via SMS/Email/Whatsapp. You can earn upto N20,000',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ), //card items start here
              const SizedBox(height: 10),
              cardItems(
                  '${AppConstants.naira}${box.read('profile')["Bonus"] == "" ? "0" : box.read('profile')["Bonus"]}',
                  'You can earned the above Bonus',
                  '',
                  'assets/images/earn_ilu.png'),
              cardItems('${box.read('profile')["PhoneNumber"]}',
                  'Your invitation code', '', 'assets/images/earn_ilu.png'),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(OxFF0E47A1),
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      onPressed: () {
                        Get.find<HomeController>()
                            .openUrl('https://wa.me/?text=$msd');
                      },
                      child: const Text(
                        'Invite Code',
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardItems(String title, String sub, String trail, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: Image.asset(
            image,
            height: 40,
          ),
          title: Text(
            title,
            style:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 11,
            ),
          ),
          trailing: Text(
            trail,
            style: GoogleFonts.poppins(
              color: Colors.red,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}
