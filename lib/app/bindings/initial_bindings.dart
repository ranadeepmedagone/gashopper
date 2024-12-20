import 'package:get/get.dart';

import '../data/api/dio_helpers.dart';
import '../data/services/dialog_services.dart';
import '../modules/controllers/main_controller.dart';
import '../modules/controllers/photo_upload_controller.dart';
import '../modules/scanner/scanner_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => ScannerController(), fenix: true);
    Get.lazyPut(() => PhotoUploadController(), fenix: true);
    Get.lazyPut(() => DioHelper(), fenix: true);
    Get.lazyPut(() => DialogService(), fenix: true);
  }
}
