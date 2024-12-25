import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_button.dart';
import '../../core/utils/widgets/custom_dropdown.dart';
import '../../core/utils/widgets/custom_loader.dart';
import '../../core/utils/widgets/custom_textfield.dart';
import '../home/home_controller.dart';
import 'create_controller.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;

    return GetBuilder<CreateController>(builder: (c) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: GashopperTheme.appBackGrounColor,
        appBar: CustomAppBar(
          isTitleCentered: true,
          title: 'Create ${c.mainController.getTypeNmae()}',
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
              color: GashopperTheme.grey1.withOpacity(0.6),
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
                  title: c.mainController.isOnPressRequest
                      ? 'Submit'
                      : c.mainController.isOnPressCashDrop
                          ? 'Drop'
                          : 'Create',
                  onPressed: () {
                    if (c.mainController.isOnPressCashDrop && !c.isCashDropsCreating) {
                      if (c.cashDropDesController.text.trim().isNotEmpty &&
                          c.cashDropAmountController.text.trim().isNotEmpty) {
                        c.createCashDrop();
                      }
                    }
                  },
                ),
              ),
            ],
          ).ltrbPadding(16, 16, 16, 16),
        ),
        body: c.isCashDropsCreating
            ? const Center(child: CustomLoader())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (c.mainController.isOnPressSales) ...[
                        CustomDropdownButton<List<String>>(
                          value: const ['Level 01'],
                          items: const [
                            DropdownMenuItem(
                              value: ['Level 01'],
                              child: Text(
                                'Empire Trucking',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                          hintText: 'Select',
                          onChanged: (value) {
                            // Handle selection change
                          },
                          onSaved: (value) {
                            // Handle value save
                          },
                          borderRadius: BorderRadius.circular(12),
                          borderColor: Colors.black,
                          borderWidth: 1.5,
                          padding: const EdgeInsets.all(8),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          dropdownShadow: BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: const Offset(0, 4),
                            blurRadius: 16,
                          ),
                        ).ltrbPadding(0, 0, 0, 16),
                        const Text(
                          'Amout',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.black,
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomTextField(
                          hintText: 'Enter amount',
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            textTheme.bodyMedium!.copyWith(
                              color: GashopperTheme.grey1,
                              fontSize: 14,
                            ),
                          ),
                          borderRadius: 12,
                          borderColor: Colors.grey[400]!,
                          focusedBorderColor: GashopperTheme.appYellow,
                          borderWidth: 1.5,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          controller: c.cashDropAmountController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                        ).ltrbPadding(0, 0, 0, 16),
                        const Text(
                          'Payment type',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomDropdownButton<List<String>>(
                          value: const ['Level 01'],
                          items: const [
                            DropdownMenuItem(
                              value: ['Level 01'],
                              child: Text(
                                'Empire Trucking',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                          hintText: 'Select',
                          onChanged: (value) {
                            // Handle selection change
                          },
                          onSaved: (value) {
                            // Handle value save
                          },
                          borderRadius: BorderRadius.circular(12),
                          borderColor: Colors.black,
                          borderWidth: 1.5,
                          padding: const EdgeInsets.all(8),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          dropdownShadow: BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: const Offset(0, 4),
                            blurRadius: 16,
                          ),
                        ).ltrbPadding(0, 0, 0, 16),
                      ],
                      if (c.mainController.isOnPressCashDrop) ...[
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.black,
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomTextField(
                          hintText: 'Enter description',
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            textTheme.bodyMedium!.copyWith(
                              color: GashopperTheme.grey1,
                              fontSize: 14,
                            ),
                          ),
                          borderRadius: 12,
                          borderColor: Colors.grey[400]!,
                          focusedBorderColor: GashopperTheme.appYellow,
                          borderWidth: 1.5,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          controller: c.cashDropDesController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                        ).ltrbPadding(0, 0, 0, 16),
                        const Text(
                          'Amout',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.black,
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomTextField(
                          hintText: 'Enter amount',
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            textTheme.bodyMedium!.copyWith(
                              color: GashopperTheme.grey1,
                              fontSize: 14,
                            ),
                          ),
                          borderRadius: 12,
                          borderColor: Colors.grey[400]!,
                          focusedBorderColor: GashopperTheme.appYellow,
                          borderWidth: 1.5,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          controller: c.cashDropAmountController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                        ).ltrbPadding(0, 0, 0, 16),
                      ],
                      if (c.mainController.isOnPressRequest)
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
                      if (c.mainController.isOnPressRequest)
                        Container(
                          decoration: BoxDecoration(
                            color: GashopperTheme.grey1.withOpacity(0.1),
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
                              fontSize: 14,
                              color: GashopperTheme.grey1,
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
                      if (c.mainController.isOnPressRequest)
                        Text(
                          'Add photo',
                          style: GashopperTheme.fontWeightApplier(
                            FontWeight.w700,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black,
                            ),
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                      if (c.mainController.isOnPressRequest)
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                title: 'Camera / Gallery',
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
