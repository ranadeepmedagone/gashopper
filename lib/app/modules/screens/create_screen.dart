import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/core/utils/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_dropdown.dart';
import '../../core/utils/widgets/custom_elevation_button.dart';
import '../controllers/main_controller.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final MainController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (c) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: GashopperTheme.appBackGrounColor,
        appBar: const CustomAppBar(
          isTitleCentered: true,
          title: 'Business Unit',
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
                child: CustomElevatedButton(
                  title: 'Cancel',
                  customBackgroundColor: GashopperTheme.appBackGrounColor,
                  customBorderSide: const BorderSide(
                    color: GashopperTheme.black,
                    width: 1.5,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomElevatedButton(
                  title: c.isOnPressRequest
                      ? 'Submit'
                      : c.isOnPressCashDrop
                          ? 'Drop'
                          : 'Create',
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
                Text(
                  'Create ${c.getTypeNmae()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: GashopperTheme.black,
                  ),
                ).ltrbPadding(0, 0, 0, c.isOnPressRequest ? 16 : 8),
                if (!c.isOnPressRequest)
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
                if (!c.isOnPressRequest)
                  const CustomTextField(hintText: 'Enter amount').ltrbPadding(0, 0, 0, 16),
                if (!c.isOnPressCashDrop && !c.isOnPressRequest)
                  const Text(
                    'Payment type',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: GashopperTheme.black),
                  ).ltrbPadding(0, 0, 0, 8),
                if (!c.isOnPressCashDrop && !c.isOnPressRequest)
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
                if (c.isOnPressRequest)
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
                if (c.isOnPressRequest)
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
                if (c.isOnPressRequest)
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
                if (c.isOnPressRequest)
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
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
