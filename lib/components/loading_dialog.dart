import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingDialog {
  final BuildContext context;
  LoadingDialog({required this.context});

  void showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return Center(
            child: const CircleAvatar(
              maxRadius: 30,
              backgroundImage: AssetImage("assets/images/app_icon.png"),
            )
                .animate(
                  autoPlay: true,
                  onComplete: (controller) => controller.repeat(),
                )
                .shimmer(
                  duration: const Duration(milliseconds: 700),
                ),
          );
        });
  }
}
