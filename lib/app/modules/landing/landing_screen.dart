import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gashopper/app/modules/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/helpers.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_elevation_button.dart';
import '../../core/values/constants.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  MobileScannerController? _cameraController;
  bool _isScanning = false;
  bool _isCaptureEnabled = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() {
    _cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    setState(() {
      _isScanning = true;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _toggleFlash() {
    _cameraController?.toggleTorch();
  }

  void _switchCamera() {
    _cameraController?.switchCamera();
  }

  void _handleScan(BarcodeCapture capture) {
    if (!_isCaptureEnabled) return; // Only process if capture is enabled

    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      debugPrint('Barcode found! ${barcode.rawValue}');
      if (barcode.rawValue != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('QR Code Scanned: ${barcode.rawValue}'),
            duration: const Duration(seconds: 2),
          ),
        );
        // Disable capture after successful scan
        setState(() {
          _isCaptureEnabled = false;
        });
      }
    }
  }

  Widget _buildScanner() {
    if (!_isScanning) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        MobileScanner(
          controller: _cameraController,
          onDetect: _handleScan,
          errorBuilder: (context, error, child) {
            return Center(
              child: Text(
                'Error: ${error.errorCode}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
        ),
        if (!_isCaptureEnabled)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: Text(
                'Click Begin Shift to start scanning',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isTitleCentered: true,
        title: 'Business Unit',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildScanner(),
              ),
            ),
            const SizedBox(height: 24),
            SvgPicture.asset(
              Constants.qrScanner,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _toggleFlash,
                  icon: const Icon(Icons.flash_on),
                ),
                IconButton(
                  onPressed: _switchCamera,
                  icon: const Icon(Icons.flip_camera_ios),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              title: _isCaptureEnabled ? 'Cancel Scan' : 'Begin Shift',
              onPressed: () {
                Get.to(() => HomeScreen());
                // TODO: Handle scan
                // setState(() {
                //   _isCaptureEnabled = !_isCaptureEnabled;
                // });
              },
              leftIcon: Icon(
                _isCaptureEnabled ? Icons.cancel : Icons.camera_alt_outlined,
                color: GashopperTheme.black,
                size: 26,
              ).ltrbPadding(8, 0, 24, 0),
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              title: 'Back',
              onPressed: () {
                Navigator.pop(context);
              },
              customBackgroundColor: GashopperTheme.appBackGrounColor,
            ),
          ],
        ),
      ),
    );
  }
}
