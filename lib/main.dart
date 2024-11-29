import 'package:flutter/material.dart';
import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/modules/splash/splash_screen.dart';

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