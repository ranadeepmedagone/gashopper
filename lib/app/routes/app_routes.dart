import 'package:flutter/material.dart';
import 'package:gashopper/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../modules/landing/lading_bindings.dart';
import '../modules/landing/landing_screen.dart';
import '../modules/no_data_screen.dart';
import '../modules/registration/registration_bindings.dart';
import '../modules/registration/registration_screen.dart';

//  `RouteGenerator` is a class that generates routes for the application.
class RouteGenerator {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case Routes.registrationScreen:
        return GetPageRoute(
          routeName: Routes.registrationScreen,
          binding: RegistrationBindings(),
          page: () => RegistrationScreen(),
          settings: settings,
        );

      case Routes.landingScreen:
        return GetPageRoute(
          routeName: Routes.landingScreen,
          binding: LandingBindings(),
          page: () => LandingScreen(),
          settings: settings,
        );

      default:
        return GetPageRoute(
          page: () => const NotFoundScreen(),
        );
    }
  }
}
