import 'package:get/get.dart';

import '../controller/maintenance_controller.dart';

class MaintenanceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaintenanceController>(
      () => MaintenanceController(),
    );
  }
}
