import 'package:get/get.dart';

import 'scanner_controller.dart';

class LandingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerController>(
      () => ScannerController(),
    );
  }
}
