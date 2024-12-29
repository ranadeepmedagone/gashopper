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
              // Date and Company Info
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    '11 Nov 2024',
                    style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Exxon',
                        style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text('211 hanover st, newareton'),
                      pw.Text('NJ 08068'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 40),

              // Sales Section
              pw.Text(
                'Sales',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              _buildSalesTable(context),
              pw.SizedBox(height: 40),

              // Payment Account Section
              pw.Text(
                'Payment Account',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              _buildPaymentTable(context),
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

  pw.Widget _buildSalesTable(pw.Context context) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        // Header Row
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _buildCell('Gas Type'),
            _buildCell('Open'),
            _buildCell('Sold'),
            _buildCell('Close'),
            _buildCell('Ret.'),
            _buildCell('\$', alignment: pw.Alignment.centerRight),
          ],
        ),
        // Data Rows
        _buildSalesRow('Regular', 11047, 1040, 9991, 2.1, 3069),
        _buildSalesRow('Ultra', 4322, 218, 4096, 2.7, 817),
        _buildSalesRow('Diesel', 5549, 1237, 4310, 3.0, 3959),
        _buildSalesRow('D.e.f', 27, 9, 18, 12.0, 108),
        _buildSalesRow('Paid in', null, null, null, null, 294.01),
        // Total Row
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _buildCell('', colspan: 5),
            _buildCell('', colspan: 5),
            _buildCell('', colspan: 5),
            _buildCell('', colspan: 5),
            _buildCell('', colspan: 5),
            _buildCell('8248', alignment: pw.Alignment.centerRight, isBold: true),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildPaymentTable(pw.Context context) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _buildCell('Payment Type', alignment: pw.Alignment.centerLeft),
            _buildCell('\$', alignment: pw.Alignment.centerRight),
          ],
        ),
        _buildPaymentRow('Card', 5942),
        _buildPaymentRow('Mobile', 0),
        _buildPaymentRow('Cash', 1268),
        _buildPaymentRow('House', 1038),
        // Total Row
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _buildCell('', colspan: 1),
            _buildCell('8248', alignment: pw.Alignment.centerRight, isBold: true),
          ],
        ),
      ],
    );
  }

  pw.TableRow _buildSalesRow(
      String label, int? open, int? sold, int? close, double? ret, double amount) {
    return pw.TableRow(
      children: [
        _buildCell(label),
        _buildCell(open?.toString() ?? ''),
        _buildCell(sold?.toString() ?? ''),
        _buildCell(close?.toString() ?? ''),
        _buildCell(ret?.toString() ?? ''),
        _buildCell(amount.toString(), alignment: pw.Alignment.centerRight),
      ],
    );
  }

  pw.TableRow _buildPaymentRow(String label, num amount) {
    return pw.TableRow(
      children: [
        _buildCell(label),
        _buildCell(amount.toString(), alignment: pw.Alignment.centerRight),
      ],
    );
  }

  pw.Widget _buildCell(
    String text, {
    pw.Alignment alignment = pw.Alignment.centerLeft,
    bool isBold = false,
    int colspan = 1,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        textAlign:
            alignment == pw.Alignment.centerRight ? pw.TextAlign.right : pw.TextAlign.left,
        style: pw.TextStyle(
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
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
