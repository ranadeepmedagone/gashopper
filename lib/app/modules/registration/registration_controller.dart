import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/api/dio_helpers.dart';
import '../../data/models/login_otp_request.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/dialog_service.dart';
import '../../routes/app_pages.dart';

class RegistrationController extends GetxController {
  // Dependencies
  final DioHelper _dioHelper = Get.find<DioHelper>();
  final DialogService _dialogService = Get.find<DialogService>();
  final AuthService _authService = Get.find<AuthService>();

  // Controllers
  final emailTextEditingController = TextEditingController();
  final otpController = TextEditingController();
  final emailFocusNode = FocusNode();

  // State variables
  bool isEmailFlow = true;
  bool isEnterEmailLoading = false;
  bool isVerifyOTPLoading = false;
  bool isResendOTPLoading = false;

  LoginOTPRequest? loginOTPRequest;
  Token? token;

  // Timer variables
  int otpTimer = 45;
  Timer? timer;
  bool canResendOtp = false;

  // Error messages
  String? otpError;
  String? emailErrorMessage;

  // Getters
  bool get isEmailValid => emailTextEditingController.text.trim().isNotEmpty;
  bool get isOtpValid => otpController.text.trim().isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  // Setup listeners fopr email and otp.
  void _setupListeners() {
    emailTextEditingController.addListener(_onEmailChanged);
    otpController.addListener(_onOtpChanged);
  }

  // On email changed
  void _onEmailChanged() => update();
  // On otp changed
  void _onOtpChanged() => update();

  // Toggle email flow or otp flow.
  void toggleEmailFlow() {
    isEmailFlow = false;
    startOtpTimer();
    update();
  }

  // Enter email
  Future<(bool, String?)> enterEmail() async {
    emailFocusNode.unfocus();
    emailErrorMessage = null;
    update();

    // Validate email
    if (!_validateEmail()) {
      return (false, emailErrorMessage);
    }

    try {
      isEnterEmailLoading = true;
      update();

      final (response, error) =
          await _dioHelper.requestOtp(emailTextEditingController.text.trim());

      if (error != null || response?.data == null) {
        emailErrorMessage = error ?? 'Failed to send OTP. Please try again.';
        update();
        return (false, emailErrorMessage);
      }

      loginOTPRequest = LoginOTPRequest.fromJson(response!.data);
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

  // Validations for email.
  bool _validateEmail() {
    final email = emailTextEditingController.text.trim();
    if (email.isEmpty) {
      emailErrorMessage = 'Email is required';
      update();
      return false;
    }
    if (!email.contains('@')) {
      emailErrorMessage = 'Please enter a valid email';
      update();
      return false;
    }
    return true;
  }

  // Verify otp.
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
      update();

      final (response, error) = await _dioHelper.verifyOtp(
        email: emailTextEditingController.text.trim(),
        otp: int.parse(otpController.text.trim()),
        referenceNumber: loginOTPRequest?.referenceNumber ?? '',
      );

      if (error != null || response?.data == null) {
        otpError = error ?? 'Error verifying OTP';
        update();
        return;
      }

      try {
        token = Token.fromJson(response!.data);

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

  // Resend otp.
  Future<void> resendOtp() async {
    if (!canResendOtp) return;

    try {
      isResendOTPLoading = true;
      update();

      final (response, error) =
          await _dioHelper.requestOtp(emailTextEditingController.text.trim());

      if (error != null) {
        otpTimer = -2;
        otpError = error;
        update();
        return;
      }

      if (response?.data == null) {
        otpTimer = -2;
        otpError = 'Failed to resend OTP';
        update();
        return;
      }

      loginOTPRequest = LoginOTPRequest.fromJson(response!.data);
      startOtpTimer();
    } catch (e) {
      otpTimer = -2;
      await _showError(e.toString());
    } finally {
      isResendOTPLoading = false;
      update();
    }
  }

  // Start otp timer.
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

  // Show error dialog.
  Future<void> _showError(String message) async {
    await _dialogService.showErrorDialog(
      title: 'Error',
      description: message,
      buttonText: 'OK',
    );
  }

  @override
  void onClose() {
    timer?.cancel();
    emailTextEditingController.removeListener(_onEmailChanged);
    otpController.removeListener(_onOtpChanged);
    emailTextEditingController.dispose();
    otpController.dispose();
    emailFocusNode.dispose();
    super.onClose();
  }
}
