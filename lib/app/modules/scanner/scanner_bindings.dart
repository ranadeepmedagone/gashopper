import 'package:gashopper/app/modules/scanner/scanner_controller.dart';
import 'package:get/get.dart';

class LandingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerController>(
      () => ScannerController(),
    );
  }
}
