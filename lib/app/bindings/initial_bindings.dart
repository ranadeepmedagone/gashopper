import 'package:get/get.dart';

import '../data/api/dio_helpers.dart';
import '../data/services/auth_service.dart';
import '../data/services/dialog_service.dart';
import '../modules/controllers/main_controller.dart';
import '../modules/controllers/photo_upload_controller.dart';
import '../modules/controllers/shift_update_controller.dart';
import '../modules/scanner/scanner_controller.dart';
import '../modules/splash/splash_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DioHelper(), permanent: true);
    Get.put(DialogService(), permanent: true);
    Get.put(AuthService(), permanent: true);

    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => ScannerController(), fenix: true);
    Get.lazyPut(() => PhotoUploadController(), fenix: true);
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => ShiftUpdateController(), fenix: true);
  }
}
