import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../data/models/app_inputs.dart';
import '../../../routes/app_pages.dart';
import '../controller/maintenance_controller.dart';

class MaintenanceStationStatusUpdateScreen extends StatelessWidget {
  MaintenanceStationStatusUpdateScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final maintenaceController = Get.find<MaintenanceController>();

  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MaintenanceController>(initState: (state) {
      maintenaceController.stationPump = args['stationPump'] as StationPump?;
    }, builder: (c) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: GashopperTheme.appBackGrounColor,
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
                  onPressed: () {
                    c.createStationPump();
                  },
                ),
              ),
            ],
          ).ltrbPadding(16, 16, 16, 16),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_gas_station,
                  size: 80,
                  color: GashopperTheme.appYellow,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: GashopperTheme.appBackGrounColor,
                    border: Border.all(
                      color: GashopperTheme.black.withAlphaOpacity(0.2),
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    c.stationPump?.id.toString() ?? '',
                    style: const TextStyle(
                      color: GashopperTheme.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ).ltrbPadding(0, 0, 16, 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        c.stationPump?.isActive == true ? 'Active' : 'Inactive',
                        style: const TextStyle(
                          fontSize: 16,
                          letterSpacing: 0.5,
                          color: GashopperTheme.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    // Expanded(
                    //   child: CustomDropdownButton<String>(
                    //     value: c.stationPump?.isActive == true ? 'Active' : 'Inactive',
                    //     items: c.fuelTypes
                    //         .map((e) => DropdownMenuItem(
                    //               value: e,
                    //               child: Text(
                    //                 e.name ?? '',
                    //                 style: const TextStyle(
                    //                   color: GashopperTheme.black,
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w700,
                    //                   letterSpacing: 0.5,
                    //                 ),
                    //               ),
                    //             ))
                    //         .toList(),
                    //     hintText: 'Select',
                    //     errorMessage: '',
                    //     hintStyle: GashopperTheme.fontWeightApplier(
                    //       FontWeight.w600,
                    //       const TextStyle(
                    //         fontSize: 16,
                    //         letterSpacing: 0.5,
                    //         color: GashopperTheme.grey1,
                    //       ),
                    //     ),
                    //     onChanged: (value) {
                    //       // Handle selection change
                    //       // c.selectedFuel = value;
                    //       // c.update();
                    //     },
                    //     onSaved: (value) {
                    //       // Handle value save
                    //       // c.selectedFuel = value;
                    //       // c.update();
                    //     },
                    //     borderRadius: BorderRadius.circular(12),
                    //     borderColor: GashopperTheme.black,
                    //     borderWidth: 1.5,
                    //     padding: const EdgeInsets.all(8),
                    //     icon: const Icon(
                    //       Icons.keyboard_arrow_down,
                    //       color: Colors.grey,
                    //     ),
                    //     dropdownShadow: BoxShadow(
                    //       color: Colors.grey.withAlphaOpacity(0.4),
                    //       offset: const Offset(0, 4),
                    //       blurRadius: 16,
                    //     ),
                    //   ),
                    // ),
                  ],
                ).ltrbPadding(0, 0, 0, 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    ).ltrbPadding(0, 0, 0, 4),
                    Container(
                      decoration: BoxDecoration(
                        color: GashopperTheme.grey1.withAlphaOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: c.stationPumpDesController,
                        minLines: 5,
                        maxLines: 5,
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
                    ),
                  ],
                ).ltrbPadding(0, 0, 0, 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Submit photo',
                      style: GashopperTheme.fontWeightApplier(
                        FontWeight.w700,
                        const TextStyle(
                          fontSize: 16,
                          letterSpacing: 0.5,
                          color: GashopperTheme.black,
                        ),
                      ),
                    ).ltrbPadding(0, 0, 0, 4),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            customBackgroundColor: GashopperTheme.appBackGrounColor,
                            customBorderSide: Border.all(
                              color: GashopperTheme.black,
                              width: 1,
                            ),
                            title: 'Add Image',
                            onPressed: () {
                              Get.toNamed(Routes.photoUploadScreen);
                            },
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
                          ),
                        ),
                      ],
                    )
                  ],
                ).ltrbPadding(0, 0, 0, 16),
                CustomButton(
                  customButtonHeight: 30,
                  customBackgroundColor: GashopperTheme.appYellow,
                  customBorderSide: Border.all(
                    color: GashopperTheme.black,
                    width: 1,
                  ),
                  title: 'Pump.Img',
                  customTextStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: GashopperTheme.black,
                  ),
                  onPressed: () {},
                  leftIcon: const Icon(
                    Icons.image,
                    color: GashopperTheme.black,
                    size: 18,
                  ).ltrbPadding(8, 0, 24, 0),
                  rightIcon: const Icon(
                    Icons.close,
                    color: GashopperTheme.black,
                    size: 18,
                  ),
                  isLeftIcon: true,
                  isRightIconEnd: true,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
