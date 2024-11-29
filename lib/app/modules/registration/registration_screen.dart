import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:get/get.dart';
import '../../core/values/constants.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;

    final mQ = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: GashopperTheme.appBackGrounColor,
      body: Stack(
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
                    bottom: 24),
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
                    const LoginFlow()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginFlow extends StatelessWidget {
  const LoginFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    final textTheme = Get.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: mQ.height / 10),
        // Email TextField
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter email i’d',
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
              borderSide:
                  const BorderSide(color: GashopperTheme.appYellow, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Password TextField
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter password',
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
              borderSide:
                  const BorderSide(color: GashopperTheme.appYellow, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),

        // Forget Password
        const SizedBox(height: 4),
        Align(
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

        const SizedBox(height: 24),

        // Login Button
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: GashopperTheme.appYellow,
            foregroundColor: GashopperTheme.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            'Login',
            style: GashopperTheme.fontWeightApplier(
              FontWeight.w700,
              textTheme.bodyMedium!.copyWith(
                color: GashopperTheme.black,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),

        const SizedBox(height: 32),

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
        ),

        const SizedBox(height: 32),

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
        ),

        const SizedBox(height: 32),

        // Create Account
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Not register yet ? ',
              style: TextStyle(
                color: GashopperTheme.grey1,
                fontSize: 14,
                letterSpacing: 0.2,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Create Account',
                style: TextStyle(
                  color: GashopperTheme.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(String iconPath, {double? padding}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300] ??  GashopperTheme.grey1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){},
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
