import 'package:gashopper/app/modules/registration/registration_controller.dart';
import 'package:get/get.dart';

class RegistrationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );
  }
}