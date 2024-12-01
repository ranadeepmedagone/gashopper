import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class LandingController extends GetxController {
  MobileScannerController? cameraController;

  bool isScanning = false;
  bool isScanEnabled = false;
  bool isLoading = false;
  bool hasValidQR = false;
  bool showError = false;
  String scannedCode = '';

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  void initializeCamera() {
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    isScanning = true;
    update();
  }

  void toggleFlash() {
    cameraController?.toggleTorch();
    update();
  }

  void switchCamera() {
    cameraController?.switchCamera();
    update();
  }

  void enableScanning() {
    isScanEnabled = true;
    showError = false;
    hasValidQR = false;
    scannedCode = '';

    update();
  }

  Future<void> handleScan(BarcodeCapture capture) async {
    if (!isScanEnabled || isLoading || hasValidQR) return;

    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        isLoading = true;
        scannedCode = barcode.rawValue!;
        update();

        try {
          // Simulate API call to validate QR code
          await Future.delayed(const Duration(seconds: 2));

          // Replace this with your actual QR validation logic
          bool isValid = barcode.rawValue?.startsWith('VALID') ?? false;

          if (isValid) {
            hasValidQR = true;
            cameraController?.stop();
          } else {
            showError = true;
            Get.snackbar(
              'Invalid QR',
              'Please scan a valid QR code',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
          update();
        } catch (e) {
          showError = true;
          Get.snackbar(
            'Error',
            'Failed to process QR code',
            snackPosition: SnackPosition.BOTTOM,
          );
        } finally {
          isLoading = false;
        }
        update();
      }
    }
  }

  void resetScan() {
    isScanEnabled = false;
    hasValidQR = false;
    showError = false;
    scannedCode = '';
    cameraController?.start();
    update();
  }
}
