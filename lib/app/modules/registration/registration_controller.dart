import 'dart:async';

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
  bool isResendOTPLoading = false;
  LoginOTPRequest? loginOTPRequest;
  Token? token;
  FocusNode? emailFocusNode = FocusNode();

  bool get isEmailValid => emailTextEditingController.text.trim().isNotEmpty;
  bool get isOtpValid => otpController.text.trim().isNotEmpty;

  // Add these variables for otp timer
  int otpTimer = 45;
  Timer? timer;
  String? otpError;
  String? emailErrorMessage;
  bool canResendOtp = false;

  @override
  void onInit() {
    super.onInit();
    emailTextEditingController.addListener(_onEmailChanged);
    otpController.addListener(_onOtpChanged);
    startOtpTimer();
  }

  void _onEmailChanged() {
    update(); // Trigger UI update when email changes
  }

  void _onOtpChanged() {
    update(); // Trigger UI update when OTP changes
  }

  void toggleEmailFlow() {
    isEmailFlow = false;
    startOtpTimer();
    update();
  }

  // This method is called when user clicks on enter email button
  Future<(bool, String?)> enterEmail() async {
    emailFocusNode?.unfocus();

    emailErrorMessage = null;
    update();

    if (!isEmailValid) {
      emailErrorMessage = 'Email is required';
      update();
      return (false, 'Email is required');
    }

    if (!emailTextEditingController.text.contains('@')) {
      emailErrorMessage = 'Please enter a valid email';
      update();
      return (false, 'Invalid email format');
    }

    try {
      isEnterEmailLoading = true;
      update();

      final (response, errorMessage) =
          await _dioHelper.requestOtp(emailTextEditingController.text.trim());

      if (errorMessage != null || response?.data == null) {
        emailErrorMessage = errorMessage ?? 'Failed to send OTP. Please try again.';
        update();
        return (false, errorMessage ?? 'Failed to send OTP. Please try again.');
      }

      loginOTPRequest = LoginOTPRequest.fromJson(response.data);
      isEmailFlow = false;
      startOtpTimer();

      return (true, null);
    } catch (e) {
      await _showError(e.toString());
      return (false, e.toString());
    } finally {
      isEnterEmailLoading = false;
      update();
    }
  }

  // This method is called when user clicks on verify otp button
  Future<void> verifyOtp() async {
    if (!isOtpValid) return;

    otpError = null;
    update();

    if (otpController.text.trim().length != 6) {
      otpError = 'Please enter 6-digit OTP';
      update();
      return;
    }

    try {
      isVerifyOTPLoading = true;
      otpError = null;
      update();

      final (response, errorMessage) = await _dioHelper.verifyOtp(
        email: emailTextEditingController.text.trim(),
        otp: int.parse(otpController.text.trim()),
        referenceNumber: loginOTPRequest?.referenceNumber ?? '',
      );

      if (errorMessage != null || response?.data == null) {
        otpError = errorMessage ?? 'Error verifying OTP';
        update();
        return;
      }

      try {
        token = Token.fromJson(response);

        if (token == null) {
          otpError = 'Invalid response from server';
          update();
          return;
        }

        await _authService.saveToken(token!);

        Get.offAllNamed(Routes.scannerScreen);
      } catch (e) {
        otpError = 'Invalid token format';
        update();
      }
    } catch (e) {
      otpError = e.toString();
      update();
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

  // Add timer functionality
  // Add this method for timer control
  void startOtpTimer() {
    otpTimer = 45;
    canResendOtp = false;
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimer > 0) {
        otpTimer--;
        update();
      } else {
        timer.cancel();
        canResendOtp = true;
        update();
      }
    });
  }

  // Add resend OTP functionality
  Future<void> resendOtp() async {
    if (!canResendOtp) return;

    try {
      isResendOTPLoading = true;
      update();

      final (response, errorMessage) =
          await _dioHelper.requestOtp(emailTextEditingController.text.trim());

      if (errorMessage != null) {
        otpTimer = -2; // Error state
        otpError = errorMessage;
        update();
        return;
      }

      if (response?.data == null) {
        otpTimer = -2;
        otpError = 'Failed to resend OTP';
        update();
        return;
      }

      loginOTPRequest = LoginOTPRequest.fromJson(response.data);
      startOtpTimer(); // Restart timer after successful resend
    } catch (e) {
      otpTimer = -2;
      await _showError(e.toString());
    } finally {
      isResendOTPLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    timer?.cancel(); // Cancel timer when controller is disposed
    emailTextEditingController.removeListener(_onEmailChanged);
    otpController.removeListener(_onOtpChanged);
    emailTextEditingController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
