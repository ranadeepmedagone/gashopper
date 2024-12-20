import 'package:flutter/material.dart';
import 'package:gashopper/app/data/models/login_otp_request.dart';
import 'package:gashopper/app/data/services/dialog_services.dart';
import 'package:get/get.dart';

import '../../data/api/dio_helpers.dart';
import '../scanner/scanner_screen.dart';

class RegistrationController extends GetxController {
  bool isMobileFlow = false;

  DioHelper get dioHelper => Get.find<DioHelper>();

  DialogService get dialogService => Get.find<DialogService>();

  final TextEditingController emailTextEditingController = TextEditingController();

  final TextEditingController otpController = TextEditingController();

  final String referenceNumber = '';

  LoginOTPRequest? loginOTPRequest;

  Token? token;

  bool isEnterEmailLoading = false;

  bool isVerifyOTPLoading = false;

  void toggleMobileFlow() {
    isMobileFlow = false;
    update();
  }

  Future<void> enterEmail() async {
    try {
      isEnterEmailLoading = true;
      update();

      final response = await dioHelper.requestOtp(emailTextEditingController.text);

      if (response.statusCode == 200 && response.data != null) {
        final otpResponse = LoginOTPRequest.fromJson(response.data);

        loginOTPRequest = otpResponse;
      } else {
        await dialogService.showErrorDialog(
          title: 'Error',
          description: 'Failed to send OTP. Please try again.',
          buttonText: 'OK',
        );
      }
    } catch (e) {
      await dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
    } finally {
      isEnterEmailLoading = false;
      isMobileFlow = false;
    }
    update();
  }

  Future<void> verifyOtp() async {
    try {
      isVerifyOTPLoading = true;
      update();

      final response = await dioHelper.verifyOtp(
        email: emailTextEditingController.text,
        otp: int.parse(otpController.text),
        referenceNumber: loginOTPRequest?.referenceNumber ?? '',
      );

      if (response.statusCode == 200 && response.data != null) {
        final tokenResponse = Token.fromJson(response.data);

        token = tokenResponse;
      } else {
        await dialogService.showErrorDialog(
          title: 'Error',
          description: 'Failed to verify OTP. Please try again.',
          buttonText: 'OK',
        );
      }
    } catch (e) {
      await dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
    } finally {
      isVerifyOTPLoading = false;

      isMobileFlow = false;

      Get.to(() => ScanerScreen());
    }
    update();
  }
}
