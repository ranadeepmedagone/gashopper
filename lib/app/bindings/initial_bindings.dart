import 'package:get/get.dart';

import '../modules/controller/main_controller.dart';
import '../modules/landing/landing_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandingController(), fenix: true);
    Get.lazyPut(() => MainController(), fenix: true);
  }
}
