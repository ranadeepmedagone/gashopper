import 'package:get/get.dart';

import '../controller/photo_upload_controller.dart';

class PhotoUploadBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoUploadController>(
      () => PhotoUploadController(),
    );
  }
}
