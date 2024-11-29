import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:gashopper/app/core/values/constants.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialBinding: InitialBindings(),
      title: 'Gashopper',
      debugShowCheckedModeBanner: false,
      theme: GashopperTheme.mainTheme(),
      navigatorObservers: const [
        // FirebaseAnalyticsObserver(analytics: analytics),
      ],
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(
            1.0,
          ),
        ),
        child: child!,
      ),
      home: const SplashScreen(),
      // onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
       height: MediaQuery.of(context).size.height,
        child: SvgPicture.asset(
          Constants.splashScreenBg,
        ),
      ),
    );
  }
}





// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoUpwardAnimation;
//   late Animation<double> _titleFadeAnimation;
//   late Animation<double> _buttonSlideAnimation;
//   late Animation<double> _buttonFadeAnimation;
//   late Animation<double> _middleImageFadeAnimation;
//   late Animation<double> _middleImageScaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 2500),
//       vsync: this,
//     );

//     // Logo moves upward animation
//     _logoUpwardAnimation = Tween<double>(begin: 0.0, end: -340.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
//       ),
//     );

//     // Title fade in animation
//     _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.3, 0.5, curve: Curves.easeIn),
//       ),
//     );

//     // Middle image fade and scale animations
//     _middleImageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
//       ),
//     );

//     _middleImageScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.5, 0.8, curve: Curves.easeOutCubic),
//       ),
//     );

//     // Button slide up animation
//     _buttonSlideAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.6, 0.8, curve: Curves.easeOutCubic),
//       ),
//     );

//     // Button fade in animation
//     _buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.6, 0.8, curve: Curves.easeIn),
//       ),
//     );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.yellow[300],
//       body: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Stack(
//             children: [
//               // Logo and Title Container
//               Positioned.fill(
//                 child: Transform.translate(
//                   offset: Offset(0, _logoUpwardAnimation.value),
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Petrol pump icon with subtle bounce effect
//                         Transform.scale(
//                           scale: 1.0 + (_titleFadeAnimation.value * 0.1),
//                           child: const Icon(
//                             Icons.local_gas_station,
//                            color: Colors.black,
//                             size: 100,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         // App title with fade in
//                         Opacity(
//                           opacity: _titleFadeAnimation.value,
//                           child: const Text(
//                             "Gashopper",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 40,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               // Middle Image with fade and scale animation
//               Positioned.fill(
//                 child: Center(
//                   child: Opacity(
//                     opacity: _middleImageFadeAnimation.value,
//                     child: Transform.scale(
//                       scale: _middleImageScaleAnimation.value,
//                       child: Container(
//                         width: size.width * 0.7,
//                         height: size.width * 0.7,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white.withOpacity(0.1),
//                         ),
//                         child: const Icon(
//                           Icons.local_gas_station,
//                            color: Colors.black,
//                           size: 300,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // Continue Button
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 60 + _buttonSlideAnimation.value,
//                 child: Opacity(
//                   opacity: _buttonFadeAnimation.value,
//                   child: Center(
//                     child: SizedBox(
//                       width: size.width * 0.8,
//                       height: 56,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const NextScreen()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:  Colors.black,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(28),
//                           ),
//                           elevation: 4,
//                         ),
//                         child: const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children:  [
//                             Text(
//                               "Get Started",
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w700,
//                                   letterSpacing: 1),
//                             ),
//                             SizedBox(width: 8),
//                             Icon(Icons.arrow_forward_rounded),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class NextScreen extends StatelessWidget {
//   const NextScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           "Welcome to GasHopper!",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
