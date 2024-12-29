import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  static Future<Uint8List> generateDSRDocument() async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            // Header with Date and Station Info
            _buildHeader(),
            pw.SizedBox(height: 40),

            // Sales Section
            _buildSalesSection(),
            pw.SizedBox(height: 40),

            // Payment Section
            _buildPaymentSection(),
          ];
        },
      ),
    );

    return doc.save();
  }

  static pw.Widget _buildHeader() {
    return pw.Row(
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
    );
  }

  static pw.Widget _buildSalesSection() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Sales',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        _buildSalesTable(),
      ],
    );
  }

  static pw.Widget _buildSalesTable() {
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

  static pw.Widget _buildPaymentSection() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Payment Account',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        _buildPaymentTable(),
      ],
    );
  }

  static pw.Widget _buildPaymentTable() {
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
            _buildCell(''),
            _buildCell('8248', alignment: pw.Alignment.centerRight, isBold: true),
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

  static pw.TableRow _buildPaymentRow(String label, num amount) {
    return pw.TableRow(
      children: [
        _buildCell(label),
        _buildCell(amount.toString(), alignment: pw.Alignment.centerRight),
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
