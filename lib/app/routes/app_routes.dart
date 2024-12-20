import 'package:flutter/material.dart';
import 'package:gashopper/app/modules/bindings/photo_upload_bindings.dart';
import 'package:gashopper/app/modules/bindings/shift_update_bindings.dart';
import 'package:gashopper/app/modules/screens/photo_upload_screen.dart';
import 'package:gashopper/app/modules/screens/shift_update_screen.dart';
import 'package:gashopper/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../modules/bindings/main_bindings.dart';
import '../modules/registration/registration_bindings.dart';
import '../modules/registration/registration_screen.dart';
import '../modules/scanner/scanner_bindings.dart';
import '../modules/scanner/scanner_screen.dart';
import '../modules/screens/create_screen.dart';
import '../modules/screens/home_screen.dart';
import '../modules/screens/list_screen.dart';
import '../modules/screens/no_data_screen.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_screen.dart';

//  `RouteGenerator` is a class that generates routes for the application.
class RouteGenerator {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case Routes.splashScreen:
        return GetPageRoute(
          routeName: Routes.splashScreen,
          binding: SplashBinding(),
          page: () => const SplashScreen(),
          settings: settings,
        );

      case Routes.registrationScreen:
        return GetPageRoute(
          routeName: Routes.registrationScreen,
          binding: RegistrationBindings(),
          page: () => const RegistrationScreen(),
          settings: settings,
        );

      case Routes.scannerScreen:
        return GetPageRoute(
          routeName: Routes.scannerScreen,
          binding: LandingBindings(),
          page: () => ScanerScreen(),
          settings: settings,
        );

      case Routes.homeScreen:
        return GetPageRoute(
          routeName: Routes.homeScreen,
          binding: MainBindings(),
          page: () => HomeScreen(),
          settings: settings,
        );

      case Routes.listScreen:
        return GetPageRoute(
          routeName: Routes.listScreen,
          binding: MainBindings(),
          page: () => SalesListScreen(),
          settings: settings,
        );

      case Routes.createScreen:
        return GetPageRoute(
          routeName: Routes.createScreen,
          binding: MainBindings(),
          page: () => CreateScreen(),
          settings: settings,
        );

      case Routes.shiftUpdateScreen:
        return GetPageRoute(
          routeName: Routes.shiftUpdateScreen,
          binding: ShiftUpdateBindings(),
          page: () => const ShiftUpdateScreen(),
          settings: settings,
        );

      case Routes.photoUploadScreen:
        return GetPageRoute(
          routeName: Routes.photoUploadScreen,
          binding: PhotoUploadBindings(),
          page: () => PhotoUploadScreen(),
          settings: settings,
        );

      default:
        return GetPageRoute(
          page: () => const NotFoundScreen(),
        );
    }
  }
}
