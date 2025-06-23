import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/controllers/home_controller.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    List net = [
      'assets/images/waec_ic.png',
      'assets/images/neco_ic.png',
      'assets/images/nabteb_ic.png'
    ];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfff1f8ff),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Buy Exam Pin',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.help_outline_sharp),
              )
            ],
          ),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value:
                const SystemUiOverlayStyle(statusBarColor: Color(OxFF0E47A1)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: net.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GetBuilder<HomeController>(
                                  builder: (controller) {
                                return InkWell(
                                  onTap: () => controller.changePosition(index),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 100,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: index == controller.position
                                            ? Border.all()
                                            : null,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 1,
                                            offset: Offset(1, 1),
                                          )
                                        ],
                                        color: Colors.white),
                                    child: Image.asset(net[index]),
                                  ),
                                );
                              });
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    color: Colors.white,
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    width: double.infinity,
                    child: const Text(
                      '\tType',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        suffix: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.keyboard_arrow_down)),
                        border: const OutlineInputBorder(),
                        label: const Text('Quantity'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(OxFF0E47A1),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        onPressed: () {},
                        child: const Text('CONTINUE')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
