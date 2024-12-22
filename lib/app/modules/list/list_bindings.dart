import 'package:get/get.dart';

import 'list_controller.dart';

class ListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListController>(() => ListController());
  }
}
