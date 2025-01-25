import 'package:flutter/material.dart';
import 'package:gashopper/app/modules/maintenance/bindings/maintenance_bindings.dart';
import 'package:get/get.dart';

import '../modules/create/create_bindings.dart';
import '../modules/create/create_screen.dart';
import '../modules/dsr/pdf_list_screen.dart';
import '../modules/dsr/pdf_viewer_bindings.dart';
import '../modules/home/home_bindings.dart';
import '../modules/home/home_screen.dart';
import '../modules/list/list_bindings.dart';
import '../modules/list/list_screen.dart';
import '../modules/maintenance/view/maintenance_inventory_screen.dart';
import '../modules/maintenance/view/maintenance_main_screen.dart';
import '../modules/maintenance/view/station_status_update_screen.dart';
import '../modules/no_data_screen.dart';
import '../modules/photo_upload/photo_upload_bindings.dart';
import '../modules/photo_upload/photo_upload_screen.dart';
import '../modules/registration/registration_bindings.dart';
import '../modules/registration/registration_screen.dart';
import '../modules/scanner/scanner_bindings.dart';
import '../modules/scanner/scanner_screen.dart';
import '../modules/shift_update/shift_update_bindings.dart';
import '../modules/shift_update/shift_update_screen.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_screen.dart';
import 'app_pages.dart';

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
          binding: HomeBindings(),
          page: () => HomeScreen(),
          settings: settings,
        );

      case Routes.listScreen:
        return GetPageRoute(
          routeName: Routes.listScreen,
          binding: ListBindings(),
          page: () => SalesListScreen(),
          settings: settings,
        );

      case Routes.createScreen:
        return GetPageRoute(
          routeName: Routes.createScreen,
          binding: CreateBindings(),
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

      case Routes.pdfViewewScreen:
        return GetPageRoute(
          routeName: Routes.pdfViewewScreen,
          binding: PDFViewerBindings(),
          page: () => const PdfListView(),
          settings: settings,
        );

      case Routes.maintenanceMainScreen:
        return GetPageRoute(
          routeName: Routes.maintenanceMainScreen,
          binding: MaintenanceBindings(),
          page: () => MaintenanceMainScreen(),
          settings: settings,
        );

      case Routes.maintenanceStationStatusUpdateScreen:
        return GetPageRoute(
          routeName: Routes.maintenanceStationStatusUpdateScreen,
          binding: MaintenanceBindings(),
          page: () => MaintenanceStationStatusUpdateScreen(),
          settings: settings,
        );

      case Routes.maintenanceInventoryScreen:
        return GetPageRoute(
          routeName: Routes.maintenanceInventoryScreen,
          binding: MaintenanceBindings(),
          page: () => MaintenanceInventoryScreen(),
          settings: settings,
        );

      default:
        return GetPageRoute(
          page: () => const NotFoundScreen(),
        );
    }
  }
}
