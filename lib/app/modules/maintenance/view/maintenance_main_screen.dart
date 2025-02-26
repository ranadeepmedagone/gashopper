import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/price_change_board.dart';
import '../../../routes/app_pages.dart';
import '../controller/maintenance_controller.dart';

class MaintenanceMainScreen extends StatelessWidget {
  MaintenanceMainScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final maintenaceController = Get.find<MaintenanceController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MaintenanceController>(builder: (c) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: GashopperTheme.appBackGrounColor,
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
                  'Maintenance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: GashopperTheme.black,
                  ),
                ).ltrbPadding(0, 0, 0, 16),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: GashopperTheme.grey2,
                        border: Border.all(
                          color: GashopperTheme.black.withAlphaOpacity(0.2),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: c.stationPumps.length,
                                itemBuilder: (context, index) {
                                  final stationPump = c.stationPumps[index];
                                  return InkWell(
                                    onTap: stationPump.isActive == false
                                        ? null
                                        : () {
                                            Get.toNamed(
                                                Routes.maintenanceStationStatusUpdateScreen,
                                                arguments: {
                                                  'stationPump': stationPump,
                                                });
                                          },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.local_gas_station,
                                          size: 80,
                                          color: stationPump.isActive == true
                                              ? GashopperTheme.appYellow
                                              : GashopperTheme.grey1,
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
                                            stationPump.id.toString(),
                                            style: const TextStyle(
                                              color: GashopperTheme.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ).ltrbPadding(0, 0, 16, 0),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).ltrbPadding(0, 0, 12, 0),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: GashopperTheme.appBackGrounColor,
                          border: Border.all(
                            color: GashopperTheme.black.withAlphaOpacity(0.2),
                            width: 1.5,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.keyboard_arrow_right),
                      ),
                    )
                  ],
                ).ltrbPadding(0, 0, 0, 24),
                CustomButton(
                  title: 'Report Problem',
                  customBackgroundColor: GashopperTheme.appBackGrounColor,
                  customBorderSide: Border.all(
                    color: GashopperTheme.black,
                    width: 1.5,
                  ),
                  onPressed: () {
                    c.homeController.onPressReport();
                    // Get.toNamed(
                    //   Routes.maintenanceReportProblemScreen,
                    // );
                  },
                  customButtonHeight: 50,
                ).ltrbPadding(0, 0, 0, 16),
                CustomButton(
                  title: 'Inventory',
                  customBackgroundColor: GashopperTheme.appBackGrounColor,
                  customBorderSide: Border.all(
                    color: GashopperTheme.black,
                    width: 1.5,
                  ),
                  onPressed: () {
                    Get.toNamed(
                      Routes.maintenanceInventoryScreen,
                    );
                  },
                  customButtonHeight: 50,
                ).ltrbPadding(0, 0, 0, 16),
                CustomButton(
                  title: 'Change Price',
                  customBackgroundColor: GashopperTheme.appBackGrounColor,
                  customBorderSide: Border.all(
                    color: GashopperTheme.black,
                    width: 1.5,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      enableDrag: true,
                      isDismissible: true,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return PopScope(
                          canPop: false,
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              left: 16,
                              right: 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Did you change price on Pump toppers?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    color: Colors.black,
                                  ),
                                ).ltrbPadding(0, 0, 0, 16),
                                const Text(
                                  'Did you change price on Display board?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    color: Colors.black,
                                  ),
                                ).ltrbPadding(0, 0, 0, 16),
                                const PriceChangeBoard().ltrbPadding(0, 0, 0, 16),
                                Row(
                                  children: [
                                    CustomButton(
                                      title: 'Back',
                                      onPressed: () {
                                        Get.back();
                                      },
                                      customBackgroundColor: GashopperTheme.appBackGrounColor,
                                    ).ltrbPadding(0, 0, 0, 16),
                                    Expanded(
                                      child: CustomButton(
                                        title: 'Yes',
                                        onPressed: () {
                                          Get.toNamed(
                                            Routes.photoUploadScreen,
                                          );
                                        },
                                      ).ltrbPadding(0, 0, 0, 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  customButtonHeight: 50,
                ).ltrbPadding(0, 0, 0, 16),
                CustomButton(
                  title: 'Request',
                  customBackgroundColor: GashopperTheme.appBackGrounColor,
                  customBorderSide: Border.all(
                    color: GashopperTheme.black,
                    width: 1.5,
                  ),
                  onPressed: () {
                    c.homeController.onPressRequest();
                  },
                  customButtonHeight: 50,
                ).ltrbPadding(0, 0, 0, 16),
              ],
            ),
          ),
        ),
      );
    });
  }
}
