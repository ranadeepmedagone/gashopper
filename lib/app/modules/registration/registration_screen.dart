import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/modules/registration/registration_controller.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../core/utils/widgets/custom_elevation_button.dart';
import '../../core/utils/widgets/custom_textfield.dart';
import '../../core/values/constants.dart';
import '../landing/landing_screen.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  /// Initializes the [MicroScheduleProgressController] controller.
  final microScheduleProgressController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;

    final mQ = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: GashopperTheme.appBackGrounColor,
      body: GetBuilder<RegistrationController>(initState: (state) {
        microScheduleProgressController.isRegister = false;
        microScheduleProgressController.update();
      }, builder: (controller) {
        return Stack(
          fit: StackFit.expand,
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
            // Content
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: mQ.size.height / 14.2,
                    left: 24,
                    right: 24,
                    bottom: 24,
                  ),
                  child: Column(
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
                      LoginFlow(
                        isForgetPassword: controller.isForgetPassword,
                        isRegister: controller.isRegister,
                        onCreateAccountClicked: controller.toggleRegister,
                        onClickForgetPassword: controller.toggleForgetPassword,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class LoginFlow extends StatelessWidget {
  final bool isRegister;
  final bool isForgetPassword;
  final Function()? onCreateAccountClicked;
  final Function()? onClickForgetPassword;

  const LoginFlow({
    super.key,
    this.isRegister = false,
    this.isForgetPassword = false,
    this.onCreateAccountClicked,
    this.onClickForgetPassword,
  });

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    final textTheme = Get.textTheme;
    FocusNode focusNode = FocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: mQ.height / 10),

        if (isRegister && !isForgetPassword)
          CustomTextField(
            hintText: 'First name',
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
            controller: TextEditingController(),
            keyboardType: TextInputType.name,
            obscureText: false,
          ).ltrbPadding(0, 0, 0, 16),

        if (isRegister && !isForgetPassword)
          CustomTextField(
            hintText: 'Last name',
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
            controller: TextEditingController(),
            keyboardType: TextInputType.name,
            obscureText: false,
          ).ltrbPadding(0, 0, 0, 16),

        if (isRegister && !isForgetPassword)
          IntlPhoneField(
            focusNode: focusNode,
            decoration: InputDecoration(
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

        // Email TextField
        CustomTextField(
          hintText: 'Enter email i’d',
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
          controller: TextEditingController(),
          keyboardType: TextInputType.name,
          obscureText: false,
        ).ltrbPadding(0, 0, 0, 16),

        // Password TextField
        CustomTextField(
          hintText: 'Enter password',
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
          controller: TextEditingController(),
          keyboardType: TextInputType.name,
          obscureText: true,
        ).ltrbPadding(0, 0, 0, (isRegister || isForgetPassword) ? 16 : 4),

        if (isRegister || isForgetPassword)
          CustomTextField(
            hintText: 'Confirm password',
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
            controller: TextEditingController(),
            keyboardType: TextInputType.name,
            obscureText: false,
          ).ltrbPadding(0, 0, 0, 16),

        // Forget Password
        if (!isRegister && !isForgetPassword)
          InkWell(
            onTap: () {
              if (onClickForgetPassword != null) onClickForgetPassword!();
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forget Password ?',
                style: GashopperTheme.fontWeightApplier(
                  FontWeight.w600,
                  textTheme.bodyMedium!.copyWith(
                    color: GashopperTheme.black,
                    fontSize: 14,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ),

        // Login Button
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                title: isForgetPassword
                    ? 'Enter '
                    : isRegister
                        ? 'Register'
                        : 'Login',
                onPressed: () {
                  if (isForgetPassword && onClickForgetPassword != null) {
                    onClickForgetPassword!();
                  } else {
                    Get.to(() => const LandingScreen());
                  }
                },
              ).ltrbPadding(0, 24, 0, isRegister ? 24 : 32),
            ),
          ],
        ),

        if (isRegister)
          InkWell(
            onTap: () {
              if (onCreateAccountClicked != null) onCreateAccountClicked!();
            },
            child: const Text(
              'Already have an account? ',
              style: TextStyle(
                color: GashopperTheme.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ).ltrbPadding(0, 0, 0, 24),

        // Or sign up with
        Row(
          children: [
            const Expanded(
                child: Divider(
              color: GashopperTheme.grey1,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Or sign up with',
                style: GashopperTheme.fontWeightApplier(
                  FontWeight.w600,
                  textTheme.bodyMedium!.copyWith(
                    color: GashopperTheme.black,
                    fontSize: 14,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
            const Expanded(
                child: Divider(
              color: GashopperTheme.grey1,
            )),
          ],
        ).ltrbPadding(0, 0, 0, 32),

        // Social Login Buttons

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: _buildSocialButton(Constants.googleIcon, padding: 10),
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: _buildSocialButton(Constants.facebookIcon),
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: _buildSocialButton(Constants.twitterxIcon, padding: 10),
            ),
          ],
        ).ltrbPadding(0, 0, 0, 32),

        // Create Account
        if (!isRegister)
          InkWell(
            onTap: () {
              if (onCreateAccountClicked != null) onCreateAccountClicked!();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not register yet ? ',
                  style: TextStyle(
                    color: GashopperTheme.grey1,
                    fontSize: 14,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  'Create Account',
                  style: TextStyle(
                    color: GashopperTheme.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSocialButton(String iconPath, {double? padding}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300] ?? GashopperTheme.grey1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(11),
          child: Container(
            padding: EdgeInsets.all(padding ?? 8),
            child: SvgPicture.asset(
              iconPath,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
