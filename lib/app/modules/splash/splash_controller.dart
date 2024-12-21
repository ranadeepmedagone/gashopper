import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../registration/registration_screen.dart';
import '../scanner/scanner_screen.dart';

class SplashController extends GetxController {
  final _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final hasValidToken = _authService.hasToken;
      debugPrint('Checking auth - Has valid token: $hasValidToken');

      if (hasValidToken) {
        Get.offAll(() => ScanerScreen());
      } else {
        Get.offAll(() => const RegistrationScreen());
      }
    } catch (e) {
      debugPrint('Error in auth check: $e');
      Get.offAll(() => const RegistrationScreen());
    }
  }
}
