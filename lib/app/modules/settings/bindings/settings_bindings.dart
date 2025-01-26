import 'package:get/get.dart';

import '../controller/settings_controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
  }
}
