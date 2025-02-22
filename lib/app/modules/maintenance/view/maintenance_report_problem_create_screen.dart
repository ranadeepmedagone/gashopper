import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_dropdown.dart';
import '../../../data/models/app_inputs.dart';
import '../controller/maintenance_controller.dart';

class MaintenanceReportProblemCreateScreen extends StatelessWidget {
  const MaintenanceReportProblemCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MaintenanceController>(builder: (c) {
      return Scaffold(
        appBar: const CustomAppBar(
          showBackButton: true,
          title: 'Business Unit',
          isTitleCentered: true,
        ),
        bottomNavigationBar: Container(
          margin: MediaQuery.of(context).padding.bottom > 12.0
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom - 12.0,
                )
              : null,
          height: 80,
          decoration: BoxDecoration(color: GashopperTheme.appBackGrounColor, boxShadow: [
            BoxShadow(
              color: GashopperTheme.grey1.withAlphaOpacity(0.6),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ]),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  title: 'Cancel',
                  customBackgroundColor: GashopperTheme.appBackGrounColor,
                  customBorderSide: Border.all(
                    color: GashopperTheme.black,
                    width: 1.5,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  title: 'Save',
                  onPressed: () {},
                ),
              ),
            ],
          ).ltrbPadding(16, 16, 16, 16),
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
                ).ltrbPadding(0, 0, 0, 16),
                const Text(
                  'Priority',
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w700,
                    color: GashopperTheme.black,
                  ),
                ).ltrbPadding(0, 0, 0, 8),
                CustomDropdownButton<IdNameRecord>(
                  value: c.selectedPriority,
                  items: c.priorityTypes
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.name ?? '',
                              style: const TextStyle(
                                color: GashopperTheme.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ))
                      .toList(),
                  hintText: 'Select priority',
                  errorMessage: '',
                  hintStyle: GashopperTheme.fontWeightApplier(
                    FontWeight.w600,
                    const TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.5,
                      color: GashopperTheme.grey1,
                    ),
                  ),
                  onChanged: (value) {
                    // Handle selection change
                    c.selectedPriority = value;
                    c.update();
                  },
                  onSaved: (value) {
                    // Handle value save
                    c.selectedPriority = value;
                    c.update();
                  },
                  borderRadius: BorderRadius.circular(12),
                  borderColor: GashopperTheme.black,
                  borderWidth: 1.5,
                  padding: const EdgeInsets.all(8),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  dropdownShadow: BoxShadow(
                    color: Colors.grey.withAlphaOpacity(0.4),
                    offset: const Offset(0, 4),
                    blurRadius: 16,
                  ),
                ).ltrbPadding(0, 0, 0, 16),
                Text(
                  'Describe',
                  style: GashopperTheme.fontWeightApplier(
                    FontWeight.w700,
                    const TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.5,
                      color: GashopperTheme.black,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: GashopperTheme.grey1.withAlphaOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: TextEditingController(),
                    minLines: 3,
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    style: const TextStyle(
                      fontSize: 16,
                      color: GashopperTheme.black,
                    ),
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: 'Enter',
                      hintStyle: TextStyle(
                        color: GashopperTheme.grey1,
                      ),
                      alignLabelWithHint: true,
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                  ),
                ).ltrbPadding(0, 8, 0, 16),
                Text(
                  'Take photo',
                  style: GashopperTheme.fontWeightApplier(
                    FontWeight.w700,
                    const TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.5,
                      color: GashopperTheme.black,
                    ),
                  ),
                ).ltrbPadding(0, 0, 0, 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: 'Camera',
                        onPressed: () {},
                        leftIcon: const Icon(
                          Icons.camera_alt_outlined,
                          color: GashopperTheme.black,
                          size: 26,
                        ).ltrbPadding(8, 0, 24, 0),
                        rightIcon: const Icon(
                          Icons.arrow_forward_ios,
                          color: GashopperTheme.black,
                          size: 18,
                        ),
                        isLeftIcon: true,
                        isRightIconEnd: true,
                      ).ltrbPadding(0, 0, 0, 16),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
