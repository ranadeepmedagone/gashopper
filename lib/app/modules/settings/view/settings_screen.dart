import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(builder: (c) {
      return Scaffold(
        appBar: const CustomAppBar(
          showBackButton: true,
          title: 'Business Unit',
          isTitleCentered: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: GashopperTheme.black,
                ),
              ).ltrbPadding(16, 24, 16, 16),
              SettingsCard(
                title: 'Dark Mode',
                onTap: () {},
              ),
              SettingsCard(
                title: 'Change language',
                onTap: () => _showLanguageDialog(context),
              ),
              SettingsCard(
                title: 'Logout',
                onTap: () {},
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showLanguageDialog(BuildContext context) {
    Get.dialog(
      GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Language',
                    style: TextStyle(
                      // TODO: Change text style
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: GashopperTheme.black,
                    ),
                  ).ltrbPadding(0, 0, 0, 16),
                  Column(
                    children: controller.languages.map((language) {
                      final bool isSelected = language == controller.selectedLanguage;
                      return GestureDetector(
                        onTap: () {
                          controller.updateLanguage(language);
                          Get.back();
                        },
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? GashopperTheme.appYellow : Colors.black,
                              width: isSelected ? 2 : 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                language,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: GashopperTheme.black,
                                ),
                              ),
                              Radio<String>(
                                value: language,
                                groupValue: controller.selectedLanguage,
                                onChanged: (value) {
                                  controller.updateLanguage(value ?? '');
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  const SettingsCard({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: GashopperTheme.grey1.withAlphaOpacity(0.3),
            width: 1.5,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: GashopperTheme.black,
                      ),
                    ),
                  const Icon(Icons.keyboard_arrow_right_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
