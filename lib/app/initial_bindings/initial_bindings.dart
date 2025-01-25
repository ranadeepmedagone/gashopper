import 'package:get/get.dart';

import '../data/api/dio_helpers.dart';
import '../data/services/auth_service.dart';
import '../data/services/dialog_service.dart';
import '../modules/create/create_controller.dart';
import '../modules/dsr/pdf_viewer_controller.dart';
import '../modules/home/home_controller.dart';
import '../modules/list/list_controller.dart';
import '../modules/maintenance/controller/maintenance_controller.dart';
import '../modules/photo_upload/photo_upload_controller.dart';
import '../modules/scanner/scanner_controller.dart';
import '../modules/shift_update/shift_update_controller.dart';
import '../modules/splash/splash_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DioHelper(), permanent: true);
    Get.put(DialogService(), permanent: true);
    Get.put(AuthService(), permanent: true);

    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ScannerController(), fenix: true);
    Get.lazyPut(() => PhotoUploadController(), fenix: true);
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => ShiftUpdateController(), fenix: true);
    Get.lazyPut(() => ListController(), fenix: true);
    Get.lazyPut(() => CreateController(), fenix: true);
    Get.lazyPut(() => PDFViewerController(), fenix: true);
    Get.lazyPut(() => MaintenanceController(), fenix: true);
  }
}
