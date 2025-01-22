import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_button.dart';

class MaintenanceMainScreen extends StatelessWidget {
  MaintenanceMainScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
            children: [
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
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      child: const Text(
                                        '5',
                                        style: TextStyle(
                                          color: GashopperTheme.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ).ltrbPadding(0, 0, 16, 0),
                                  ],
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
                onPressed: () {},
                customButtonHeight: 50,
              ).ltrbPadding(0, 0, 0, 16),
              CustomButton(
                title: 'Inventory',
                customBackgroundColor: GashopperTheme.appBackGrounColor,
                customBorderSide: Border.all(
                  color: GashopperTheme.black,
                  width: 1.5,
                ),
                onPressed: () {},
                customButtonHeight: 50,
              ).ltrbPadding(0, 0, 0, 16),
              CustomButton(
                title: 'Change Price',
                customBackgroundColor: GashopperTheme.appBackGrounColor,
                customBorderSide: Border.all(
                  color: GashopperTheme.black,
                  width: 1.5,
                ),
                onPressed: () {},
                customButtonHeight: 50,
              ).ltrbPadding(0, 0, 0, 16),
              CustomButton(
                title: 'Request',
                customBackgroundColor: GashopperTheme.appBackGrounColor,
                customBorderSide: Border.all(
                  color: GashopperTheme.black,
                  width: 1.5,
                ),
                onPressed: () {},
                customButtonHeight: 50,
              ).ltrbPadding(0, 0, 0, 16),
            ],
          ),
        ),
      ),
    );
  }
}
