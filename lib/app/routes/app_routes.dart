import 'package:flutter/material.dart';
import 'package:gashopper/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../modules/bindings/main_bindings.dart';
import '../modules/landing/lading_bindings.dart';
import '../modules/landing/landing_screen.dart';
import '../modules/no_data_screen.dart';
import '../modules/registration/registration_bindings.dart';
import '../modules/registration/registration_screen.dart';
import '../modules/view/create_screen.dart';
import '../modules/view/home_screen.dart';
import '../modules/view/list_screen.dart';

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

      default:
        return GetPageRoute(
          page: () => const NotFoundScreen(),
        );
    }
  }
}
