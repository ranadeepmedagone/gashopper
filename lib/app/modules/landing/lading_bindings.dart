import 'package:gashopper/app/modules/landing/landing_controller.dart';
import 'package:get/get.dart';

class LandingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingController>(
      () => LandingController(),
    );
  }
}
