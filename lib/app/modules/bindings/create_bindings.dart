import 'package:get/get.dart';

import '../controllers/create_controller.dart';

class CreateBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateController());
  }
}
