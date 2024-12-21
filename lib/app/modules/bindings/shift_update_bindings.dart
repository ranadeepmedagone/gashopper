import 'package:get/get.dart';

import '../controllers/shift_update_controller.dart';

class ShiftUpdateBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShiftUpdateController>(
      () => ShiftUpdateController(),
    );
  }
}
