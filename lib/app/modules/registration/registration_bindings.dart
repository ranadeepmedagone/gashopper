import 'package:get/get.dart';

import 'registration_controller.dart';

class RegistrationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );
  }
}
