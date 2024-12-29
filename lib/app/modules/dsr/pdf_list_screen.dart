import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_loader.dart';
import 'pdf_viewer_controller.dart';

class PdfListView extends StatelessWidget {
  const PdfListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PDFViewerController>(
      builder: (controller) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'DSR List',
            actionWidget: Row(
              children: [],
            ),
          ),
          body: controller.isLoading
              ? const Center(child: CustomLoader())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return PdfListCard(
                              customValueTextColor: Colors.green,
                              isPending: false,
                              title: 'Gasshopper PDF',
                              value: 'open',
                              onTap: controller.generateAndPreviewPdf,
                            ).ltrbPadding(0, 0, 0, 16);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class PdfListCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isPending;
  final Color? customValueTextColor;
  final Function()? onTap;

  const PdfListCard({
    super.key,
    required this.title,
    required this.value,
    this.isPending = false,
    this.customValueTextColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: GashopperTheme.appYellow,
                border: Border.all(
                  color: isPending ? GashopperTheme.grey1 : GashopperTheme.appYellow,
                  width: 1.5,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: const Icon(
                Icons.file_open_rounded,
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isPending ? GashopperTheme.grey1 : GashopperTheme.appYellow,
                    width: 1.5,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GashopperTheme.fontWeightApplier(
                            FontWeight.w700,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.keyboard_arrow_right_rounded)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
