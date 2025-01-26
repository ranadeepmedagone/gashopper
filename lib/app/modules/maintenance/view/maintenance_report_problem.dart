import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../routes/app_pages.dart';
import '../../list/list_screen.dart';

class MaintenanceReportProblemScreen extends StatelessWidget {
  const MaintenanceReportProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
        title: 'Business Unit',
        isTitleCentered: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Problem',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: GashopperTheme.black,
                ),
              ).ltrbPadding(0, 0, 0, 8),
              CustomButton(
                title: 'Create',
                customTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: GashopperTheme.black,
                ),
                customBackgroundColor: GashopperTheme.appBackGrounColor,
                customBorderSide: Border.all(
                  color: GashopperTheme.black,
                  width: 1.5,
                ),
                leftIcon: const Icon(
                  Icons.add,
                  color: GashopperTheme.black,
                  size: 28,
                ),
                onPressed: () {
                  Get.toNamed(
                    Routes.maintenanceReportProblemCreateScreen,
                  );
                },
              ).ltrbPadding(0, 0, 0, 16),
              const Row(
                children: [
                  Icon(
                    Icons.history,
                    color: GashopperTheme.black,
                    size: 24,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'History',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: GashopperTheme.black,
                    ),
                  ),
                ],
              ).ltrbPadding(0, 0, 0, 8),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ListCard(
                    isPending: false,
                    title: 'PRB00001',
                    value: 'High',
                  ).ltrbPadding(0, 0, 0, 16);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
