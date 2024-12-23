// lib/app/modules/pdf_viewer/controllers/pdf_viewer_controller.dart
import 'dart:io';

import 'package:gashopper/app/data/services/dialog_service.dart';
import 'package:gashopper/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../core/utils/widgets/pdf_generator.dart';
import '../../data/models/gas_station.dart';

class PDFViewerController extends GetxController {
  final DialogService _dialogService = Get.find<DialogService>();

  bool isViewPDFLoading = false;

  // In your controller
  Future<File?> generateGasStationPDF(GasStation station) async {
    try {
      final file = await GasStationPDFGenerator.saveGasStationDetails(station);
      if (file != null) {
        return file;
      } else {
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: 'Failed to generate PDF',
          buttonText: 'OK',
        );
      }
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: 'An error occurred while generating PDF: ${e.toString()}',
        buttonText: 'OK',
      );
    }
    return null;
  }

  Future<void> viewGasStationPDF(GasStation station) async {
    try {
      isViewPDFLoading = true;
      update();

      final file = await generateGasStationPDF(station);
      if (file != null) {
        Get.toNamed(
          Routes.pdfViewewScreen,
          arguments: {
            'url': file.path,
            'title': 'Gas Station Details',
            'fileName': 'gas_station_${station.id}.pdf',
          },
        );
      }
    } finally {
      isViewPDFLoading = false;
      update();
    }
  }
}
