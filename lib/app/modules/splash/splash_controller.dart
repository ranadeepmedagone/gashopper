import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../registration/registration_screen.dart';
import '../scanner/scanner_screen.dart';

class SplashController extends GetxController {
  final authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      // Add initial delay for animation if needed
      await Future.delayed(const Duration(seconds: 2));

      // Wait for service to be ready
      while (!authService.isInitialized || !authService.isBoxReady) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      if (authService.hasToken) {
        debugPrint('Valid token found, navigating to home');
        Get.offAll(() => ScanerScreen());
      } else {
        debugPrint('No valid token, navigating to registration');
        Get.offAll(() => const RegistrationScreen());
      }
    } catch (e) {
      debugPrint('Error during auth check: $e');
      // On error, safely navigate to registration
      Get.offAll(() => const RegistrationScreen());
    }
  }
}
