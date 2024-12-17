import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/modules/registration/registration_controller.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../core/utils/widgets/custom_elevation_button.dart';
import '../../core/utils/widgets/custom_richtext.dart';
import '../../core/values/constants.dart';
import '../landing/landing_screen.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  /// Initializes the [RegistrationController] controller.
  final registrationController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;

    final mQ = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: GashopperTheme.appBackGrounColor,
      body: GetBuilder<RegistrationController>(initState: (state) {
        registrationController.isMobileFlow = true;
        registrationController.update();
      }, builder: (controller) {
        return Stack(
          children: [
            // First background SVG
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
            // Second background SVG
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

            Positioned(
              top: 24,
              right: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  top: mQ.size.height / 14.2,
                ),
                child: controller.isMobileFlow
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
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
                                  text: 'hopper',
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
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                                  onPressed: () {
                                    controller.isMobileFlow = true;
                                    controller.update();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios))
                              .ltrbPadding(24, 0, 0, 0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
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
                                      text: 'hopper',
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
                              ),
                            ],
                          ).ltrbPadding(mQ.size.width / 29, 0, 0, 0),
                        ],
                      ),
              ),
            ),
            // Content
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: LoginFlow(
                    isMobileFlow: controller.isMobileFlow,
                    enterMobileNumber: controller.toggleMobileFlow,
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

class LoginFlow extends StatelessWidget {
  final bool isMobileFlow;
  final Function()? enterMobileNumber;

  const LoginFlow({
    super.key,
    required this.isMobileFlow,
    this.enterMobileNumber,
  });

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    final textTheme = Get.textTheme;
    FocusNode focusNode = FocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: mQ.height / 10),

        if (isMobileFlow)
          RichText(
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
          ),

        const SizedBox(height: 16),

        // if (isRegister && !isForgetPassword)
        if (isMobileFlow)
          IntlPhoneField(
            focusNode: focusNode,
            decoration: InputDecoration(
              fillColor: GashopperTheme.appBackGrounColor,
              hintText: 'Enter mobile number',
              hintStyle: GashopperTheme.fontWeightApplier(
                FontWeight.w600,
                textTheme.bodyMedium!.copyWith(
                  color: GashopperTheme.grey1,
                  fontSize: 14,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: GashopperTheme.grey1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: GashopperTheme.grey1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: GashopperTheme.appYellow, width: 1.5),
              ),
            ),
            dropdownIcon: const Icon(
              Icons.arrow_drop_down,
              color: GashopperTheme.appYellow,
            ),
            languageCode: "en",
            onChanged: (phone) {},
            onCountryChanged: (country) {},
            disableLengthCheck: true,
          ).ltrbPadding(0, 0, 0, 16),

        if (!isMobileFlow)
          OtpFlow(
            onSubmit: (code) {
              // Handle OTP submission
            },
            onResendOtp: () {
              // Handle resend OTP
            },
            otpController: TextEditingController(),
            isResendLoading: false,
            phoneNumber: '+1234567890',
            error: null, // Show error if any
            seconds: 30, // Countdown timer
            onVerifyPressed: () {
              // Handle verify button press
            },
            isVerifyLoading: false,
          ),

        // Login Button
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                title: isMobileFlow ? 'Enter' : 'Verify OTP',
                onPressed: () {
                  if (isMobileFlow) {
                    if (enterMobileNumber != null) enterMobileNumber!();
                  } else {
                    Get.to(() => LandingScreen());
                  }
                },
              ).ltrbPadding(0, 24, 0, mQ.height / 15.4),
            ),
          ],
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
    required this.isResendLoading,
    required this.onResendOtp,
    required this.otpController,
    this.phoneNumber,
    super.key,
    this.error,
    this.seconds,
    this.onVerifyPressed,
    this.isVerifyLoading = false,
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
        _buildResendOtp().ltrbPadding(0, 20, 0, 24),
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
        color: GashopperTheme.appYellow,
        size: 18,
        weight: 30.0,
      );
    }

    if (isResendLoading) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: GashopperTheme.appYellow,
        ),
      );
    }

    return const Icon(
      Icons.sms_outlined,
      color: GashopperTheme.appYellow,
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
        color: GashopperTheme.appYellow.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          infoIcon ?? const Icon(Icons.sms, color: GashopperTheme.appYellow),
          if (infoText?.isNotEmpty ?? false) ...[
            const SizedBox(width: 8),
            Text(
              infoText!,
              style: TextStyle(
                color: otpError ? Colors.red : GashopperTheme.appYellow,
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
