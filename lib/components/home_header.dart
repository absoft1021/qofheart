import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qofheart/components/app_constants.dart';
import 'package:qofheart/controllers/account_controller.dart';
import 'package:qofheart/controllers/home_controller.dart';
import 'package:qofheart/pages/add_money_page.dart';
import 'package:qofheart/pages/kyc_page.dart';
import 'package:qofheart/pages/manual_transfer.dart';
import 'package:qofheart/pages/pricing_page.dart';
import 'package:qofheart/pages/transfer_page.dart';
import 'package:qofheart/pages/upgrade_page.dart';

class HomeHeader extends StatelessWidget {
  final AccountController controller = Get.find<AccountController>();
  final HomeController hctrl = Get.find<HomeController>();
  final RxBool isVisible = true.obs;

  HomeHeader({super.key}); // Removed 'const' from constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WalletBalanceSection(
            controller: controller,
            isVisible: isVisible,
            hctrl: hctrl,
          ),
          const SizedBox(height: 16),
          const ActionButtonsRow(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class WalletBalanceSection extends StatelessWidget {
  final AccountController controller;
  final RxBool isVisible;
  final HomeController hctrl;

  const WalletBalanceSection({
    required this.controller,
    required this.isVisible,
    required this.hctrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0E47A1), Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BalanceInfo(isVisible: isVisible, controller: controller),
          Obx(() {
            final account = controller.acct.isNotEmpty ? controller.acct[0] : null;
            final accountNumber = account?['AccountNumber'] as String?;
            final bankName = account?['BankName'] as String?;

            if (accountNumber != null && accountNumber.isNotEmpty) {
              return Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        bankName ?? '',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        accountNumber,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      hctrl.copyText(accountNumber);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account number copied!')),
                      );
                    },
                    icon: const Icon(Icons.copy, color: Colors.white, size: 20),
                  ),
                ],
              );
            }
            return TextButton(
              onPressed: () => Get.to(() => KycPage()),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0E47A1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: Text(
                'Generate Account',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class BalanceInfo extends StatelessWidget {
  final RxBool isVisible;
  final AccountController controller;

  const BalanceInfo({
    required this.isVisible,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wallet Balance',
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Obx(
              () => Text(
                '${AppConstants.naira} ${isVisible.value ? controller.walletBalance.value : "***"}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton(
              onPressed: () => isVisible.toggle(),
              icon: Icon(
                isVisible.value ? Icons.visibility : Icons.visibility_off,
                color: Colors.white70,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Obx(
          () => Text(
            '& bonus ${AppConstants.naira}${controller.walletBonus.value}',
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionButton(
            label: 'Bonus',
            icon: Icons.wallet,
            onTap: () => Get.to(() => TransferPage()),
          ),
          ActionButton(
            label: 'Add Money',
            icon: Icons.monetization_on,
            onTap: () => showFundDialog(context),
          ),
          ActionButton(
            label: 'Upgrade',
            icon: Icons.send_to_mobile,
            onTap: () => Get.to(() => const UpgradePage()),
          ),
          ActionButton(
            label: 'Pricing',
            icon: Icons.storage_rounded,
            onTap: () => Get.to(() => const PricingPage()),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF0E47A1),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showFundDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    constraints: const BoxConstraints(maxHeight: 260),
    builder: (context) => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Fund Your qofheart Wallet',
            style: GoogleFonts.poppins(
              color: const Color(0xFF0E47A1),
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose an option to fund your wallet',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FundOption(
                label: 'Bank Transfer',
                icon: Icons.input,
                onTap: () => Get.to(() => const AddMoneyPage()),
              ),
              FundOption(
                label: 'Manual Transfer',
                icon: Icons.account_balance_wallet_outlined,
                onTap: () => Get.to(() => const ManualTransfer()),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class FundOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const FundOption({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: const Color(0xFF0E47A1)),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0E47A1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}