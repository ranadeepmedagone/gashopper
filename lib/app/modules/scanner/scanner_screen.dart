// landing_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_button.dart';
import '../../core/utils/widgets/custom_loader.dart';
import '../../core/values/constants.dart';
import '../../routes/app_pages.dart';
import 'scanner_controller.dart';

class ScanerScreen extends StatelessWidget {
  ScanerScreen({super.key});

  /// Initializes the [LandingController] controller.
  final scannerController = Get.find<ScannerController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: GashopperTheme.appBackGrounColor,
      appBar: const CustomAppBar(
        isTitleCentered: true,
        title: 'Business Unit',
        showBackButton: false,
      ),
      body: GetBuilder<ScannerController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              SizedBox(
                height: mQ.size.height / 2.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      MobileScanner(
                        controller: controller.cameraController,
                        onDetect: controller.handleScan,
                        errorBuilder: (context, error, child) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Error: ${error.errorCode.name}',
                                  style: const TextStyle(color: Colors.red),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: controller.resetScan,
                                  child: const Text('Try Again'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      if (controller.isLoading) const Center(child: CustomLoader()),
                      if (controller.hasValidQR)
                        Container(
                          color: Colors.black54,
                          child: const Center(
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 100,
                            ),
                          ),
                        ),
                      if (controller.showError)
                        Container(
                          color: Colors.black54,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 60,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: controller.resetScan,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: GashopperTheme.appYellow,
                                  ),
                                  child: const Text(
                                    'Scan Again',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (!controller.isScanEnabled)
                        GestureDetector(
                          onTap: controller.enableScanning,
                          child: Container(
                            color: Colors.black54,
                            child: const Center(
                              child: Text(
                                'Tap to scan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const SizedBox(height: 24),
              Column(
                children: [
                  if (!controller.hasValidQR)
                    SvgPicture.asset(
                      Constants.qrScanner,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(height: 16),
                  if (controller.isScanEnabled && !controller.hasValidQR)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: controller.toggleFlash,
                          icon: const Icon(Icons.flash_on),
                        ),
                        IconButton(
                          onPressed: controller.switchCamera,
                          icon: const Icon(Icons.flip_camera_ios),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  // if (controller.hasValidQR)
                  CustomButton(
                    title: 'Begin Shift',
                    onPressed: () {
                      Get.toNamed(Routes.homeScreen);
                    },
                    leftIcon: const Icon(
                      Icons.play_arrow_rounded,
                      color: GashopperTheme.black,
                      size: 26,
                    ).ltrbPadding(8, 0, 24, 0),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    title: 'Back',
                    onPressed: () => Get.back(),
                    customBackgroundColor: GashopperTheme.appBackGrounColor,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
