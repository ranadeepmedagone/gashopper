import 'package:flutter/material.dart';
import 'package:gashopper/app/data/models/gas_station.dart';
import 'package:get/get.dart';

import 'pdf_viewer_controller.dart';

class PDFViewerScreen extends StatelessWidget {
  const PDFViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PDFViewerController>(builder: (controller) {
      return Scaffold(
        body: Center(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  controller.viewGasStationPDF(GasStation(
                    id: 1,
                    name: 'Gas Station 1',
                  ));
                },
                icon: const Icon(
                  Icons.picture_as_pdf,
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.generateGasStationPDF(
                    GasStation(
                      id: 1,
                      name: 'Gas Station 1',
                    ),
                  );
                },
                icon: const Icon(
                  Icons.picture_as_pdf,
                ),
              ),
              const Text('PDF Viewer'),
            ],
          ),
        ),
      );
    });
  }
}
