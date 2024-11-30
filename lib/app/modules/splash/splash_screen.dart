import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_elevation_button.dart';
import '../../core/values/constants.dart';
import '../registration/registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _buttonSlideAnimation;
  late final Animation<double> _buttonFadeAnimation;
  late final Animation<double> _middleImageFadeAnimation;
  late final Animation<double> _middleImageScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _middleImageFadeAnimation = _createAnimation(
      begin: 0.0,
      end: 1.0,
      intervalStart: 0.0, // Start immediately
      intervalEnd: 0.5,   // End halfway
      curve: Curves.easeIn,
    );

    _middleImageScaleAnimation = _createAnimation(
      begin: 0.8,
      end: 1.0,
      intervalStart: 0.0, // Start immediately
      intervalEnd: 0.5,   // End halfway
      curve: Curves.easeOutCubic,
    );

    _buttonSlideAnimation = _createAnimation(
      begin: 100.0,
      end: 0.0,
      intervalStart: 0.5,  // Start after middle image
      intervalEnd: 1.0,    // End at finish
      curve: Curves.easeOutCubic,
    );

    _buttonFadeAnimation = _createAnimation(
      begin: 0.0,
      end: 1.0,
      intervalStart: 0.5,  // Start after middle image
      intervalEnd: 1.0,    // End at finish
      curve: Curves.easeIn,
    );


    _controller.forward();
  }

  Animation<double> _createAnimation({
    required double begin,
    required double end,
    required double intervalStart,
    required double intervalEnd,
    required Curve curve,
  }) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(intervalStart, intervalEnd, curve: curve),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GashopperTheme.appBackGrounColor,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => SplashScreenContent(
          animations: SplashAnimations(
            buttonSlide: _buttonSlideAnimation,
            buttonFade: _buttonFadeAnimation,
            middleImageFade: _middleImageFadeAnimation,
            middleImageScale: _middleImageScaleAnimation,
          ),
        ),
      ),
    );
  }
}

class SplashAnimations {
  final Animation<double> buttonSlide;
  final Animation<double> buttonFade;
  final Animation<double> middleImageFade;
  final Animation<double> middleImageScale;

  const SplashAnimations({
    required this.buttonSlide,
    required this.buttonFade,
    required this.middleImageFade,
    required this.middleImageScale,
  });
}

class SplashScreenContent extends StatelessWidget {
  final SplashAnimations animations;

  const SplashScreenContent({
    super.key,
    required this.animations,
  });

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    final textTheme = Get.textTheme;

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

        SafeArea(
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
              ],
            ),
          ),
        ),

        Stack(
          children: [
            _buildMiddleImage(context),
            _buildGetStartedButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildMiddleImage(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: Opacity(
          opacity: animations.middleImageFade.value,
          child: Transform.scale(
            scale: animations.middleImageScale.value,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(
                Constants.splashBg,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 60 + animations.buttonSlide.value,
      child: Opacity(
        opacity: animations.buttonFade.value,
        child: CustomElevatedButton(
          title: "Lets Start",
          rightIcon: const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: GashopperTheme.black,
            size: 26,
          ),
          onPressed: () {
            Get.to(() => RegistrationScreen());
          },
        ).ltrbPadding(24, 0, 24, 0),
      ),
    );
  }
}
