class ExamPage extends StatelessWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final quantityController = TextEditingController();
    String msg = 'Sorry this service is temporarily not available';
    List<String> net = [
      'assets/images/waec_ic.png',
      'assets/images/neco_ic.png',
      'assets/images/nabteb_ic.png',
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF041262)),
      child: Scaffold(
        backgroundColor: const Color(0xfff1f8ff),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            'Buy Exam',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF041262),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.help_outline_sharp, color: Color(0xFF041262)),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Select Exam Type',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: GetBuilder<HomeController>(builder: (controller) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: net.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final isSelected = index == controller.position;
                      return GestureDetector(
                        onTap: () => controller.changePosition(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 90,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: isSelected
                                ? Border.all(color: const Color(0xFF041262), width: 2)
                                : null,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          child: Image.asset(net[index]),
                        ),
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 30),
              Text(
                'Enter Quantity',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'e.g. 1',
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (quantityController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Choose quantity'),
                        ),
                      );
                      return;
                    }

                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2.4,
                            child: CustomPinKeyboard(
                              length: 4,
                              buttonBackground: Colors.transparent,
                              indicatorProgressColor: const Color(0xFF041262),
                              indicatorBackground: const Color(0xFFB5D1D3),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              additionalButton: Image.asset(
                                'assets/images/fingerp.png',
                                height: 25,
                                width: 25,
                              ),
                              onAdditionalButtonPressed: () async {
                                final isAuthenticated = await LocalAuthApi.authenticate();
                                if (isAuthenticated) {
                                  Get.back();
                                  LoadingDialog().showLoading();
                                  await Future.delayed(const Duration(seconds: 5));
                                  Get.back();
                                  Abdialog().showDialog(msg, false);
                                }
                              },
                              onCompleted: (passcode) async {
                                if (passcode == box.read('pin')) {
                                  Get.back();
                                  LoadingDialog().showLoading();
                                  await Future.delayed(const Duration(seconds: 5));
                                  Get.back();
                                  Abdialog().showDialog(msg, false);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF041262),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Purchase',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}