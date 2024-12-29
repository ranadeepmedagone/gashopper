import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../../routes/app_pages.dart';

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
        // debugPrint('Valid token found, navigating to home');
        Get.offAllNamed(Routes.scannerScreen);
      } else {
        // debugPrint('No valid token, navigating to registration');
        Get.offAllNamed(Routes.registrationScreen);
      }
    } catch (e) {
      // debugPrint('Error during auth check: $e');
      // On error, safely navigate to registration
      Get.offAllNamed(Routes.registrationScreen);
    }
  }
}
