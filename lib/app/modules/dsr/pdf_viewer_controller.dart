import 'dart:io';
import 'dart:typed_data';

import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

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

  void _resetState() {
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

  Future<void> writeOnPdf() async {
    try {
      _resetState();

      _pdf.value?.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text('GeeksforGeeks', textScaleFactor: 2),
                    pw.Text(DateTime.now().toString().split('.')[0]),
                  ],
                ),
              ),
              pw.Header(level: 1, text: 'What is Lorem Ipsum?'),
              pw.Paragraph(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              pw.SizedBox(height: 20),
              pw.Header(level: 1, text: 'Sample Table'),
              _buildTable(context),
            ];
          },
        ),
      );
      update();
    } catch (e) {
      showSnackBar('Error generating PDF content: $e', true);
      update();
      throw Exception('Failed to generate PDF content: $e');
    }
  }

  pw.Table _buildTable(pw.Context context) {
    return pw.TableHelper.fromTextArray(
      context: context,
      data: const <List<String>>[
        <String>['Year', 'Sample'],
        <String>['SN0', 'GFG1'],
        <String>['SN1', 'GFG2'],
        <String>['SN2', 'GFG3'],
      ],
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
      ),
      headerDecoration: const pw.BoxDecoration(
        color: PdfColors.grey300,
      ),
      rowDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.grey300,
            width: 0.5,
          ),
        ),
      ),
      cellAlignment: pw.Alignment.center,
      cellPadding: const pw.EdgeInsets.all(5),
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

      await writeOnPdf();
      String filePath = await savePdf();

      if (filePath.isNotEmpty) {
        await Get.to(
          () => PdfViewerScreen(filePath: filePath),
        );
        _resetState();
      } else {
        showSnackBar('Failed to generate PDF', true);
      }
    } catch (e) {
      showSnackBar('Error: ${e.toString()}', true);
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

  Future<void> sharePdf() async {
    try {
      if (_currentFilePath.value.isEmpty) return;

      final file = File(_currentFilePath.value);
      if (await file.exists()) {
        await Share.shareXFiles(
          [XFile(_currentFilePath.value)],
          subject: 'Shared from the Gashopper app',
          text: 'Check out this PDF file',
        );
      }
    } catch (e) {
      showSnackBar('Error sharing PDF: $e', true);
      update();
    }
  }

  Future<void> downloadPdf() async {
    try {
      if (_currentFilePath.value.isEmpty) return;

      final status = await Permission.storage.request();
      if (!status.isGranted) {
        showSnackBar('Storage permission denied', true);
        return;
      }

      Directory? downloadDir;
      if (Platform.isAndroid) {
        downloadDir = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadDir = await getApplicationDocumentsDirectory();
      }

      if (downloadDir == null) {
        showSnackBar('Download directory not found', true);
        return;
      }

      final sourceFile = File(_currentFilePath.value);
      final fileName = 'gasshopper_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final targetPath = '${downloadDir.path}/$fileName';
      final targetFile = await sourceFile.copy(targetPath);

      showSnackBar('PDF downloaded successfully', false);

      // Open the downloaded file
      final result = await OpenFile.open(targetFile.path);
      if (result.type != ResultType.done) {
        showSnackBar('Error opening PDF: ${result.message}', true);
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
