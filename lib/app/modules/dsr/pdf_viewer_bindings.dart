import 'package:gashopper/app/modules/dsr/pdf_viewer_controller.dart';
import 'package:get/get.dart';

class PDFViewerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PDFViewerController>(
      () => PDFViewerController(),
    );
  }
}
