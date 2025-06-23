import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/services/sub_services/electricity_continue.dart';

class ElectricityPage extends StatefulWidget {
  const ElectricityPage({super.key});

  @override
  State<ElectricityPage> createState() => _ElectricityPageState();
}

class _ElectricityPageState extends State<ElectricityPage> {
  List comp = [
    {
      "id": "1",
      "title": "Kano Electric",
      "sub": "Postpaid and Prepaid KEDCO",
      "state": "KEDCO",
      "logo": "assets/images/kedco.jpg"
    },
    {
      "id": "2",
      "title": "Ikeja Electric",
      "sub": "Postpaid and Prepaid IKEDC",
      "state": "IKEDC",
      "logo": "assets/images/ikeja.jpg"
    },
    {
      "id": "3",
      "title": "Eko Electric",
      "sub": "Postpaid and Prepaid EKEDC",
      "state": "EKEDC",
      "logo": "assets/images/eko.jpg"
    },
    {
      "id": "4",
      "title": "Port Harcourt Electric",
      "sub": "Postpaid and Prepaid PHED",
      "state": "PHED",
      "logo": "assets/images/port.jpg"
    },
    {
      "id": "5",
      "title": "Jos Electric",
      "sub": "Postpaid and Prepaid JED",
      "state": "JED",
      "logo": "assets/images/jos.jpg"
    },
    {
      "id": "6",
      "title": "Ibadan Electric",
      "sub": "Postpaid and Prepaid IBEDC",
      "state": "IBEDC",
      "logo": "assets/images/ibedc.jpg"
    },
    {
      "id": "7",
      "title": "Kaduna Electric",
      "sub": "Postpaid and Prepaid KAEDCO",
      "state": "KAEDCO",
      "logo": "assets/images/kaduna.jpg"
    },
    {
      "id": "8",
      "title": "Enugu Electric",
      "sub": "Postpaid and Prepaid BEBC",
      "state": "BEBC",
      "logo": "assets/images/enugu.jpg"
    },
    {
      "id": "9",
      "title": "Abuja Electric",
      "sub": "Postpaid and Prepaid AEDC",
      "state": "BENIN",
      "logo": "assets/images/abuja.jpg"
    },
    {
      "id": "10",
      "title": "Benin Electric",
      "sub": "Postpaid and Prepaid BEDC",
      "state": "BEDC",
      "logo": "assets/images/becd.jpg"
    },
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Buy Electricity',
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comp.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () =>
                          Get.to(() => const ElectricityContinue(), arguments: [
                        {"id": comp[index]['id']},
                        {"title": comp[index]['title']}
                      ]),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            Image.asset(
                              comp[index]['logo'],
                              height: 40,
                              width: 50,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    comp[index]['title'],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    comp[index]['sub'].toString(),
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
