import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_viewer_screen.dart';

class PDFViewerController extends GetxController {
  final _pdf = Rx<pw.Document?>(null);
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _currentFilePath = ''.obs;

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
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
    _errorMessage.value = '';
    update();
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
      _errorMessage.value = 'Error generating PDF content: $e';
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
      _errorMessage.value = 'Error saving PDF: $e';
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
        _errorMessage.value = 'Failed to generate PDF';
      }
    } catch (e) {
      _errorMessage.value = 'Error: ${e.toString()}';
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
      print('Error cleaning up old files: $e');
    }
  }

  @override
  void onClose() {
    _pdf.value = null;
    _cleanupOldFiles();
    super.onClose();
  }
}
