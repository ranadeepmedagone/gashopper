import 'package:flutter/material.dart';
import 'package:gashopper/app/data/models/login_otp_request.dart';
import 'package:gashopper/app/data/services/dialog_service.dart';
import 'package:gashopper/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../data/api/dio_helpers.dart';
import '../../data/services/auth_service.dart';

class RegistrationController extends GetxController {
  // Dependencies
  final DioHelper _dioHelper = Get.find<DioHelper>();
  final DialogService _dialogService = Get.find<DialogService>();
  final _authService = Get.find<AuthService>();

  // Controllers
  final emailTextEditingController = TextEditingController();
  final otpController = TextEditingController();

  // State variables
  bool isEmailFlow = true;
  bool isEnterEmailLoading = false;
  bool isVerifyOTPLoading = false;
  LoginOTPRequest? loginOTPRequest;
  Token? token;
  FocusNode? emailFocusNode = FocusNode();

  bool get isEmailValid => emailTextEditingController.text.trim().isNotEmpty;
  bool get isOtpValid => otpController.text.trim().isNotEmpty;

  @override
  void onInit() {
    super.onInit();

    // Add listeners to controllers
    emailTextEditingController.addListener(_onEmailChanged);
    otpController.addListener(_onOtpChanged);
  }

  void _onEmailChanged() {
    update(); // Trigger UI update when email changes
  }

  void _onOtpChanged() {
    update(); // Trigger UI update when OTP changes
  }

  void toggleEmailFlow() {
    isEmailFlow = false;
    update();
  }

  // This method is called when user clicks on enter email button
  Future<void> enterEmail() async {
    emailFocusNode?.unfocus();

    if (!isEmailValid) return;

    if (emailTextEditingController.text.contains('@') == false) {
      await _showError('Please enter a valid email');
      return;
    }

    try {
      isEnterEmailLoading = true;
      update();

      final response = await _dioHelper.requestOtp(emailTextEditingController.text.trim());

      if (response.data == null || response.statusCode != 200) {
        await _showError('Failed to send OTP. Please try again.');
        return;
      }

      loginOTPRequest = LoginOTPRequest.fromJson(response.data);
      isEmailFlow = false;
    } catch (e) {
      await _showError(e.toString());
    } finally {
      isEnterEmailLoading = false;
      update();
    }
  }

  // This method is called when user clicks on verify otp button
  Future<void> verifyOtp() async {
    if (!isOtpValid) return;

    if (int.parse(otpController.text.trim()) < 6) {
      await _showError('Please enter a valid OTP');
      return;
    }

    try {
      isVerifyOTPLoading = true;
      update();

      final response = await _dioHelper.verifyOtp(
        email: emailTextEditingController.text.trim(),
        otp: int.parse(otpController.text.trim()),
        referenceNumber: loginOTPRequest?.referenceNumber ?? '',
      );

      if (response.statusCode != 200 || response.data == null) {
        await _showError('Failed to verify OTP. Please try again.');
        return;
      }

      token = Token.fromJson(response.data);

      if (token == null) return;

      await _authService.saveToken(token!);

      Get.offAllNamed(Routes.scannerScreen);
    } catch (e) {
      await _showError(e.toString());
    } finally {
      isVerifyOTPLoading = false;
      update();
    }
  }

  Future<void> _showError(String message) async {
    await _dialogService.showErrorDialog(
      title: 'Erro',
      description: message,
      buttonText: 'OK',
    );
  }

  @override
  void onClose() {
    emailTextEditingController.removeListener(_onEmailChanged);
    otpController.removeListener(_onOtpChanged);
    emailTextEditingController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
