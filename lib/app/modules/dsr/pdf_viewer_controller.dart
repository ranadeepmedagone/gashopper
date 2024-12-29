import 'dart:io';
import 'dart:typed_data';

import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/widgets/pdf_generator.dart';
import 'pdf_viewer_screen.dart';

class PDFViewerController extends GetxController {
  final _pdf = Rx<pw.Document?>(null);
  final _isLoading = false.obs;
  final _currentFilePath = ''.obs;

  bool get isLoading => _isLoading.value;
  String get currentFilePath => _currentFilePath.value;
  pw.Document? get pdf => _pdf.value;

  @override
  void onInit() {
    super.onInit();
    _cleanupOldFiles();
    _initNewPdf();
  }

  void _initNewPdf() {
    _pdf.value = pw.Document();
    update();
  }

  Future<void> showSnackBar(String message, bool isError) async {
    Get.snackbar(
      isError ? 'Error' : 'Success',
      message,
      backgroundColor: isError ? GashopperTheme.red : GashopperTheme.appYellow,
      colorText: GashopperTheme.black,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  Future<String> savePdf() async {
    try {
      if (_pdf.value == null) {
        _initNewPdf();
      }

      // Delete previous file if it exists
      if (_currentFilePath.value.isNotEmpty) {
        final previousFile = File(_currentFilePath.value);
        if (await previousFile.exists()) {
          await previousFile.delete();
        }
      }

      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = "${documentDirectory.path}/example_$timestamp.pdf";
      File file = File(filePath);

      Uint8List pdfData = await _pdf.value!.save();
      await file.writeAsBytes(pdfData);

      _currentFilePath.value = filePath;
      update();
      return filePath;
    } catch (e) {
      showSnackBar('Error saving PDF: $e', true);
      update();
      return '';
    }
  }

  Future<void> generateAndPreviewPdf() async {
    try {
      _isLoading.value = true;
      update();

      setMetadata(
        stationName: 'Exxon Station Name', // Replace with actual station name
        date: DateTime.now().toString(), // Or your formatted date
        reportType: 'DSR',
      );

      // Generate PDF using the generator
      final pdfData = await PdfGenerator.generateDSRDocument();

      // Save PDF to file
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = "${documentDirectory.path}/example_$timestamp.pdf";
      File file = File(filePath);

      await file.writeAsBytes(pdfData);
      _currentFilePath.value = filePath;

      if (filePath.isNotEmpty) {
        await Get.to(
          () => PdfViewerScreen(filePath: filePath),
          preventDuplicates: true,
          // fullscreenDialog: true,
        );
      } else {
        showSnackBar('Failed to generate PDF', false);
      }
    } catch (e) {
      showSnackBar('Error: ${e.toString()}', false);
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<void> _cleanupOldFiles() async {
    try {
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      List<FileSystemEntity> files = documentDirectory
          .listSync()
          .where((entity) => entity.path.contains('example_'))
          .toList();

      if (files.length > 5) {
        files.sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));
        for (var file in files.sublist(5)) {
          await file.delete();
        }
      }
    } catch (e) {
      showSnackBar('Error cleaning up old files: $e', true);
    }
  }

  Future<void> sharePdf({
    required String stationName,
    required String date,
    String? reportType = 'DSR',
  }) async {
    try {
      if (_currentFilePath.value.isEmpty) {
        showSnackBar('No PDF file to share', true);
        return;
      }

      final file = File(_currentFilePath.value);
      if (await file.exists()) {
        final shareTitle = '$reportType Report - $stationName';
        final shareText = '''
        $reportType Report from $stationName
        Date: $date
        Generated via Gashopper App''';

        await Share.shareXFiles(
          [XFile(_currentFilePath.value)],
          subject: shareTitle,
          text: shareText,
        );
      } else {
        showSnackBar('PDF file not found', true);
      }
    } catch (e) {
      showSnackBar('Error sharing PDF: $e', true);
    } finally {
      update();
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.photos.request();
      return status.isGranted;
    } else {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }

  Future<String?> _getDownloadPath() async {
    try {
      if (Platform.isAndroid) {
        final directory = await getDownloadsDirectory();
        return directory?.path;
      } else {
        // For iOS, use the Documents directory
        final directory = await getApplicationDocumentsDirectory();
        return directory.path;
      }
    } catch (e) {
      showSnackBar('Error getting download path: $e', true);
      return null;
    }
  }

  final _stationName = ''.obs;
  final _reportDate = ''.obs;
  final _reportType = ''.obs;

  void setMetadata({
    required String stationName,
    required String date,
    String reportType = 'DSR',
  }) {
    _stationName.value = stationName;
    _reportDate.value = date;
    _reportType.value = reportType;
    update();
  }

  Future<void> downloadPdf() async {
    try {
      if (_currentFilePath.value.isEmpty) {
        showSnackBar('No PDF file to download', true);
        return;
      }

      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        showSnackBar('Permission denied to access storage', true);
        return;
      }

      final downloadPath = await _getDownloadPath();
      if (downloadPath == null) {
        showSnackBar('Could not access download directory', true);
        return;
      }

      final sourceFile = File(_currentFilePath.value);
      final fileName = 'gasshopper_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final targetPath = '$downloadPath/$fileName';
      final targetFile = await sourceFile.copy(targetPath);

      showSnackBar('PDF downloaded to Downloads folder', false);

      // Try to open the file
      try {
        final result = await OpenFile.open(targetFile.path);
        if (result.type != ResultType.done) {
          showSnackBar('PDF downloaded but could not be opened: ${result.message}', true);
        }
      } catch (e) {
        showSnackBar('PDF downloaded but could not be opened', true);
      }
    } catch (e) {
      showSnackBar('Error downloading PDF: $e', true);
    }
  }

  @override
  void onClose() {
    _pdf.value = null;
    _cleanupOldFiles();
    super.onClose();
  }
}
