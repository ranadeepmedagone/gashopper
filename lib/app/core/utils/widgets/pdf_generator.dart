import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GasStationPDFGenerator {
  static Future<Uint8List> generateDocument({
    required String stationName,
    required String address,
    required String date,
    required Map<String, dynamic> salesData,
    required Map<String, double> paymentData,
  }) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            // Header with Date and Station Info
            _buildHeader(stationName, address, date),
            pw.SizedBox(height: 40),

            // Sales Section
            _buildSalesSection(salesData),
            pw.SizedBox(height: 40),

            // Payment Section
            _buildPaymentSection(paymentData),
          ];
        },
      ),
    );

    return doc.save();
  }

  static pw.Widget _buildHeader(String stationName, String address, String date) {
    final addressParts = address.split(',');
    final street = addressParts[0].trim();
    final location = addressParts.length > 1 ? addressParts[1].trim() : '';

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          date,
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              stationName,
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(street),
            pw.Text(location),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSalesSection(Map<String, dynamic> salesData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Sales',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        _buildSalesTable(salesData),
      ],
    );
  }

  static pw.Widget _buildSalesTable(Map<String, dynamic> salesData) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        // Header Row
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _buildCell(''),
            _buildCell('Open'),
            _buildCell('Sold'),
            _buildCell('Close'),
            _buildCell('Ret.'),
            _buildCell('\$', alignment: pw.Alignment.centerRight),
          ],
        ),
        // Data Rows
        ...salesData.entries.map((entry) {
          final data = entry.value as Map<String, dynamic>;
          return _buildSalesRow(
            entry.key,
            data['open'] as int?,
            data['sold'] as int?,
            data['close'] as int?,
            data['ret'] as double?,
            data['amount'] as double,
          );
        }),
        // Total Row
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _buildCell('', colspan: 5),
            _buildCell(
              salesData['total']?.toString() ?? '0',
              alignment: pw.Alignment.centerRight,
              isBold: true,
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildPaymentSection(Map<String, double> paymentData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Payment Account',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        _buildPaymentTable(paymentData),
      ],
    );
  }

  static pw.Widget _buildPaymentTable(Map<String, double> paymentData) {
    final total = paymentData.values.reduce((a, b) => a + b);

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        ...paymentData.entries.map((entry) => _buildPaymentRow(entry.key, entry.value)),
        // Total Row
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey200),
          children: [
            _buildCell(''),
            _buildCell(
              total.toString(),
              alignment: pw.Alignment.centerRight,
              isBold: true,
            ),
          ],
        ),
      ],
    );
  }

  static pw.TableRow _buildSalesRow(
    String label,
    int? open,
    int? sold,
    int? close,
    double? ret,
    double amount,
  ) {
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

  static pw.TableRow _buildPaymentRow(String label, double amount) {
    return pw.TableRow(
      children: [
        _buildCell(label),
        _buildCell(
          amount.toString(),
          alignment: pw.Alignment.centerRight,
        ),
      ],
    );
  }

  static pw.Widget _buildCell(
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
}
