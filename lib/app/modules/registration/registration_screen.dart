import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_button.dart';
import '../../core/utils/widgets/custom_loader.dart';
import '../../core/utils/widgets/custom_richtext.dart';
import '../../core/utils/widgets/custom_textfield.dart';
import '../../core/values/constants.dart';
import 'registration_controller.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;

    final textTheme = Get.textTheme;

    return GetBuilder<RegistrationController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: GashopperTheme.appBackGrounColor,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                // Background SVGs
                _BackgroundImages(),

                // Header with Logo
                Positioned(
                  top: 24,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.only(top: mQ.height / 14.2),
                    child: controller.isEmailFlow
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildLogo(textTheme),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.isEmailFlow = true;
                                  controller.update();
                                },
                                icon: const Icon(Icons.arrow_back_ios),
                              ).ltrbPadding(24, 0, 0, 0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _buildLogo(textTheme),
                                ],
                              ).ltrbPadding(Get.width / 29, 0, 0, 0),
                            ],
                          ),
                  ),
                ),

                // Main Content
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: LoginFlow(
                        enterMobileNumber: controller.toggleEmailFlow,
                        enterEmail: controller.enterEmail,
                        verifyOtp: controller.verifyOtp,
                        resendOtp: controller.resendOtp,
                        isEmailFlow: controller.isEmailFlow,
                        emailTextEditingController: controller.emailTextEditingController,
                        otpController: controller.otpController,
                        isEmailLoading: controller.isEnterEmailLoading,
                        isOtpLoading: controller.isVerifyOTPLoading,
                        emailFocusNode: controller.emailFocusNode,
                        otpError: controller.otpError,
                        otpTimer: controller.otpTimer,
                        isResendOTPLoading: controller.isResendOTPLoading,
                        emailErrorText: controller.emailErrorMessage,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo(TextTheme textTheme) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Gas',
            style: GashopperTheme.fontWeightApplier(
              FontWeight.w700,
              textTheme.bodyMedium!.copyWith(
                color: GashopperTheme.black,
                fontSize: 50,
              ),
            ),
          ),
          TextSpan(
            text: 'opper',
            style: GashopperTheme.fontWeightApplier(
              FontWeight.w700,
              textTheme.bodyMedium!.copyWith(
                color: GashopperTheme.appYellow,
                fontSize: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Background Images Widget
class _BackgroundImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(
            Constants.registrationBg,
            fit: BoxFit.fill,
            colorFilter: const ColorFilter.mode(
              GashopperTheme.appYellow,
              BlendMode.srcATop,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SvgPicture.asset(
            Constants.registrationBg2,
            fit: BoxFit.fill,
            colorFilter: const ColorFilter.mode(
              GashopperTheme.appYellow,
              BlendMode.srcATop,
            ),
          ),
        ),
      ],
    );
  }
}

// Login Flow Widget
class LoginFlow extends StatelessWidget {
  final bool isEmailFlow;
  final TextEditingController emailTextEditingController;
  final TextEditingController otpController;
  final Function()? enterMobileNumber;
  final Function()? enterEmail;
  final Function()? verifyOtp;
  final Function()? resendOtp;
  final bool isEmailLoading;
  final bool isOtpLoading;
  final FocusNode? emailFocusNode;
  final String? otpError;
  final String? emailErrorText;
  final int? otpTimer;
  final bool isResendOTPLoading;

  const LoginFlow({
    super.key,
    required this.isEmailFlow,
    this.enterMobileNumber,
    required this.emailTextEditingController,
    required this.otpController,
    this.enterEmail,
    this.verifyOtp,
    this.resendOtp,
    this.isEmailLoading = false,
    this.isOtpLoading = false,
    this.isResendOTPLoading = false,
    this.emailFocusNode,
    this.otpError,
    this.otpTimer,
    this.emailErrorText,
  });

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    final textTheme = Get.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: mQ.height / 10),
        if (isEmailFlow) _buildLoginHeader(textTheme),
        const SizedBox(height: 8),
        if (isEmailFlow) _buildEmailInput(textTheme) else _buildOtpFlow(),
        _buildActionButton(mQ),
      ],
    );
  }

  Widget _buildLoginHeader(TextTheme textTheme) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Login',
            style: GashopperTheme.fontWeightApplier(
              FontWeight.w700,
              textTheme.bodyMedium!.copyWith(
                color: GashopperTheme.black,
                fontSize: 30,
              ),
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: 'with',
            style: GashopperTheme.fontWeightApplier(
              FontWeight.w700,
              textTheme.bodyMedium!.copyWith(
                color: GashopperTheme.appYellow,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput(TextTheme textTheme) {
    return CustomTextField(
      errorText: emailErrorText,
      hintText: 'Enter your email',
      hintStyle: GashopperTheme.fontWeightApplier(
        FontWeight.w600,
        textTheme.bodyMedium!.copyWith(
          color: GashopperTheme.grey1,
          fontSize: 14,
        ),
      ),
      borderRadius: 12,
      borderColor: Colors.grey[400]!,
      focusedBorderColor: GashopperTheme.appYellow,
      borderWidth: 1.5,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      controller: isEmailLoading ? null : emailTextEditingController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (isEmailLoading) {
          emailFocusNode?.unfocus();
        }
      },
      focusNode: emailFocusNode,
    ).ltrbPadding(0, 0, 0, 16);
  }

  Widget _buildOtpFlow() {
    return OtpFlow(
      onSubmit: (code) {
        otpController.text = code ?? '';
        if (code?.length == 6 && verifyOtp != null) {
          verifyOtp!();
        }
      },
      onResendOtp: () {
        if (otpTimer == 0 && resendOtp != null) {
          resendOtp!();
        }
      },
      otpController: otpController,
      isResendLoading: isResendOTPLoading,
      phoneNumber: emailTextEditingController.text,
      error: otpError,
      seconds: otpTimer,
      onVerifyPressed: verifyOtp,
      isVerifyLoading: isResendOTPLoading,
    );
  }

  Widget _buildActionButton(Size mQ) {
    return Row(
      children: [
        Expanded(
          child: GetBuilder<RegistrationController>(
            builder: (controller) {
              final bool isDisabled = isEmailFlow
                  ? (isEmailLoading || emailTextEditingController.text.trim().isEmpty)
                  : (isOtpLoading || otpController.text.trim().isEmpty);

              return CustomButton(
                isDisable: isDisabled,
                isLoading: isEmailLoading || isOtpLoading,
                title: isEmailFlow ? 'Enter' : 'Verify OTP',
                onPressed: isDisabled
                    ? null
                    : () {
                        emailFocusNode?.unfocus();
                        isEmailFlow ? enterEmail?.call() : verifyOtp?.call();
                      },
              ).ltrbPadding(0, 16, 0, mQ.height / 15.4);
            },
          ),
        ),
      ],
    );
  }
}

// otp_flow.dart
class OtpFlow extends StatelessWidget {
  final Function(String?) onSubmit;
  final VoidCallback onResendOtp;
  final VoidCallback? onVerifyPressed;
  final String? error;
  final int? seconds;
  final TextEditingController otpController;
  final bool isResendLoading;
  final String? phoneNumber;
  final bool isVerifyLoading;

  OtpFlow({
    required this.onSubmit,
    required this.onResendOtp,
    required this.otpController,
    this.phoneNumber,
    super.key,
    this.error,
    this.seconds,
    this.onVerifyPressed,
    this.isVerifyLoading = false,
    this.isResendLoading = false,
  });

  final controller = Get.put(OtpFieldController());

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context).ltrbPadding(0, 0, 0, 16),
        _buildOtpInput(mQ),
        if (error != null) ...[
          const SizedBox(height: 4),
          _buildErrorText(context),
        ],
        _buildResendOtp().ltrbPadding(0, 8, 0, 16),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Verify with an OTP\n',
            style: GashopperTheme.fontWeightApplier(
              FontWeight.w700,
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: GashopperTheme.black,
                    fontSize: 20,
                  ),
            ),
          ),
          const TextSpan(text: ''),
          TextSpan(
            text: 'Enter OTP sent to $phoneNumber',
            style: const TextStyle(
              color: GashopperTheme.black,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOtpInput(MediaQueryData mQ) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: mQ.size.width),
      child: PinFieldAutoFill(
        cursor: Cursor(
          width: 1,
          height: 20,
          color: GashopperTheme.black,
          radius: const Radius.circular(1),
          enabled: true,
        ),
        decoration: BoxTightDecoration(
          strokeColor: error != null ? GashopperTheme.red : GashopperTheme.appYellow,
          bgColorBuilder: const FixedColorBuilder(GashopperTheme.appBackGrounColor),
          strokeWidth: 1.5,
          textStyle: const TextStyle(
            color: GashopperTheme.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        onCodeSubmitted: onSubmit,
        codeLength: 6,
        focusNode: controller.focusNode,
        controller: otpController,
        currentCode: otpController.text,
        keyboardType: TextInputType.number,
        onCodeChanged: (code) {
          if (code?.length == 4) {
            onSubmit(code);
          }
        },
      ),
    );
  }

  Widget _buildErrorText(BuildContext context) {
    return Text(
      error!,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.red,
            fontSize: 16,
          ),
    );
  }

  Widget _buildResendOtp() {
    return Row(
      children: [
        if (_shouldShowTimer) _buildResendTimer() else _buildResendButton(),
      ],
    );
  }

  bool get _shouldShowTimer => seconds != null && seconds! > 0;

  Widget _buildResendTimer() {
    return CustomRichText(
      headline: 'Resend OTP in ',
      value: '00:${seconds.toString().padLeft(2, '0')}',
      leftCustomColor: GashopperTheme.black,
      rightCustomColor: GashopperTheme.black,
      leftCustomFontWeight: FontWeight.normal,
      rightCustomFontWeight: FontWeight.w700,
      leftCustomFontsize: 16,
      rightCustomFontsize: 16,
    );
  }

  Widget _buildResendButton() {
    final isResendEnabled = seconds == 0;
    final hasError = seconds == -2;
    final isResent = seconds == -1;

    return AbsorbPointer(
      absorbing: isResendLoading || !isResendEnabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onResendOtp,
          child: OtpStatusInfoContainer(
            infoIcon: _buildResendIcon(isResent),
            infoText: _getResendText(isResent, hasError, isResendEnabled),
            otpError: hasError,
          ),
        ),
      ),
    );
  }

  Widget _buildResendIcon(bool isResent) {
    if (isResent) {
      return const Icon(
        Icons.check,
        color: GashopperTheme.black,
        size: 18,
        weight: 30.0,
      );
    }

    if (isResendLoading) {
      return const Center(
        child: CustomLoader(
          size: 18,
          customStrokeWidth: 2,
        ),
      );
    }

    return const Icon(
      Icons.sms_outlined,
      color: GashopperTheme.black,
      size: 18,
      weight: 10.0,
    );
  }

  String _getResendText(bool isResent, bool hasError, bool isEnabled) {
    if (isResent) return 'OTP sent';
    if (hasError) return 'Error in resending OTP';
    if (isEnabled) return 'Resend OTP';
    return '';
  }
}

class OtpStatusInfoContainer extends StatelessWidget {
  final String? infoText;
  final Widget? infoIcon;
  final bool otpError;

  const OtpStatusInfoContainer({
    super.key,
    this.infoText,
    this.infoIcon,
    this.otpError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: GashopperTheme.appYellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          infoIcon ?? const Icon(Icons.sms, color: GashopperTheme.black),
          if (infoText?.isNotEmpty ?? false) ...[
            const SizedBox(width: 8),
            Text(
              infoText!,
              style: TextStyle(
                color: otpError ? Colors.red : GashopperTheme.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class OtpFieldController extends GetxController {
  FocusNode focusNode = FocusNode();
  late SmsAutoFill smsAutoReader;

  @override
  void onInit() {
    super.onInit();
    _initializeSmsListener();
  }

  void _initializeSmsListener() {
    smsAutoReader = SmsAutoFill();
    smsAutoReader.listenForCode();
  }

  @override
  void onClose() {
    smsAutoReader.unregisterListener();
    focusNode.dispose();
    super.onClose();
  }
}
