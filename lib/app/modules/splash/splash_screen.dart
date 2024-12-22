import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_loader.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (context) {
      return const Scaffold(
        backgroundColor: GashopperTheme.appBackGrounColor,
        body: Center(child: CustomLoader()),
      );
    });
  }
}
