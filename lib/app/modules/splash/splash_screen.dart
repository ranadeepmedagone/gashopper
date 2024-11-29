import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
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
  late final Animation<double> _logoUpwardAnimation;
  late final Animation<double> _titleFadeAnimation;
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

    _logoUpwardAnimation = _createAnimation(
      begin: 0.0,
      end: -340.0,
      intervalStart: 0.2,
      intervalEnd: 0.6,
      curve: Curves.easeOutCubic,
    );

    _titleFadeAnimation = _createAnimation(
      begin: 0.0,
      end: 1.0,
      intervalStart: 0.3,
      intervalEnd: 0.5,
      curve: Curves.easeIn,
    );

    _middleImageFadeAnimation = _createAnimation(
      begin: 0.0,
      end: 1.0,
      intervalStart: 0.5,
      intervalEnd: 0.8,
      curve: Curves.easeIn,
    );

    _middleImageScaleAnimation = _createAnimation(
      begin: 0.8,
      end: 1.0,
      intervalStart: 0.5,
      intervalEnd: 0.8,
      curve: Curves.easeOutCubic,
    );

    _buttonSlideAnimation = _createAnimation(
      begin: 100.0,
      end: 0.0,
      intervalStart: 0.6,
      intervalEnd: 0.8,
      curve: Curves.easeOutCubic,
    );

    _buttonFadeAnimation = _createAnimation(
      begin: 0.0,
      end: 1.0,
      intervalStart: 0.6,
      intervalEnd: 0.8,
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
            logoUpward: _logoUpwardAnimation,
            titleFade: _titleFadeAnimation,
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
  final Animation<double> logoUpward;
  final Animation<double> titleFade;
  final Animation<double> buttonSlide;
  final Animation<double> buttonFade;
  final Animation<double> middleImageFade;
  final Animation<double> middleImageScale;

  const SplashAnimations({
    required this.logoUpward,
    required this.titleFade,
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
    final size = MediaQuery.of(context).size;

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
        Stack(
          children: [
            _buildLogoAndTitle(context),
            _buildMiddleImage(context),
            _buildGetStartedButton(context, size),
          ],
        ),
      ],
    );
  }

  Widget _buildLogoAndTitle(BuildContext context) {
    final textTheme = Get.textTheme;
    return 
    Positioned.fill(
      child: Transform.translate(
        offset: Offset(0, animations.logoUpward.value),
        child: Center(
          child: RichText(
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
        ),
      ),
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

  Widget _buildGetStartedButton(BuildContext context, Size size) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 60 + animations.buttonSlide.value,
      child: Opacity(
        opacity: animations.buttonFade.value,
        child: GetStartedButton(size: size),
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  final Size size;

  const GetStartedButton({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size.width * 0.8,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => const RegistrationScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: GashopperTheme.appYellow,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Lets Start",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: GashopperTheme.black,
                ),
              ),
              SizedBox(width: 2),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: GashopperTheme.black,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
