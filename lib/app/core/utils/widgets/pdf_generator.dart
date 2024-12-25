import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../data/models/gas_station.dart';

class GasStationPDFGenerator {
  static Future<Uint8List> generateDocument(
    PdfPageFormat format,
    GasStation station,
  ) async {
    station = GasStation(
        id: 1,
        name: 'Test Station',
        address: '123 Test Street',
        contactNumber: 1234567890,
        operatingHours: 24,
        latitude: 12.345,
        longitude: 67.890,
        createdByUserName: 'Test User');

    final doc = pw.Document(pageMode: PdfPageMode.fullscreen);
    const title = 'Gas Station Details';

    // Load your company logo if needed
    // final pngImage = await rootBundle.load('assets/images/logo.png');

    pw.Widget singleLineText(String title, String value) => pw.RichText(
          text: pw.TextSpan(
            children: [
              pw.TextSpan(
                text: '$title:  ',
                style: const pw.TextStyle(
                  color: PdfColors.grey600,
                  fontSize: 12,
                ),
              ),
              pw.TextSpan(
                text: value,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );

    doc.addPage(
      pw.MultiPage(
        pageFormat: format.copyWith(
          marginBottom: 1.5 * PdfPageFormat.cm,
          marginRight: PdfPageFormat.cm,
          marginLeft: PdfPageFormat.cm,
        ),
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          if (context.pageNumber == 1) {
            return pw.SizedBox();
          }
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(width: 0.5, color: PdfColors.grey),
              ),
            ),
            child: pw.Text(
              title,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(color: PdfColors.grey),
            ),
          );
        },
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: pw.Theme.of(context).defaultTextStyle.copyWith(color: PdfColors.grey),
            ),
          );
        },
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(title, textScaleFactor: 2),
                pw.Text(
                  DateFormat('dd MMM yyyy').format(DateTime.now()),
                  style: const pw.TextStyle(
                    fontSize: 16,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
          ),
          pw.Header(level: 1, text: 'Station Information'),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              singleLineText('Station Name', station.name ?? ''),
              singleLineText('Station ID', '#${station.id.toString()}'),
              singleLineText('Address', station.address ?? ''),
              singleLineText('Contact Number', station.contactNumber.toString()),
              singleLineText('Operating Hours', '${station.operatingHours} hours'),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Header(level: 1, text: 'Location Details'),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              singleLineText('Latitude', station.latitude.toString()),
              singleLineText('Longitude', station.longitude.toString()),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Header(level: 1, text: 'Additional Information'),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (station.createdByUserName != null)
                singleLineText('Created By', station.createdByUserName!),
              singleLineText(
                'Created Date',
                'dd MMM yyyy, HH:mm',
                // DateFormat('dd MMM yyyy, HH:mm').format(station.createdAt ?? DateTime.now()),
              ),
              if (station.updatedAt != null)
                singleLineText(
                  'Last Updated',
                  'dd MMM yyyy, HH:mm',
                  // DateFormat('dd MMM yyyy, HH:mm').format(station.updatedAt ?? DateTime.now()),
                ),
            ],
          ),
        ],
      ),
    );

    return await doc.save();
  }

  static Future<File?> saveGasStationDetails(GasStation station) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final filePath = '${appDocDir.path}/gas_station_${station.id}.pdf';

      final pdfBytes = await generateDocument(PdfPageFormat.a4, station);
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      return file;
    } catch (e) {
      print('Error generating PDF: $e');
      return null;
    }
  }
}
