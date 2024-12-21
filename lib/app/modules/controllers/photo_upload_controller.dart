import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadController extends GetxController {
  /// Selected image file to be uploaded to the server.
  File? selectedImageFile;

  /// Image picker instance.
  final ImagePicker _picker = ImagePicker();

  XFile? selectedImageXFile;

  bool isImageVisible = false;
  bool isAttachmentUpload = false;
  double uploadProgress = 0.0;

  // Image quality settings
  static const int imageQuality = 100; // Maximum quality
  static const double maxWidth = 4096; // Maximum width in pixels
  static const double maxHeight = 4096; // Maximum height in pixels

  // To handle the image capture with high quality
  Future<bool> captureHighQualityImage() async {
    try {
      isAttachmentUpload = true;
      update();

      // Configure image picker with high quality settings
      selectedImageXFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        preferredCameraDevice: CameraDevice.rear, // Use rear camera for better quality
      );

      if (selectedImageXFile == null) {
        isAttachmentUpload = false;
        update();
        return false;
      }

      // Create file from XFile
      selectedImageFile = File(selectedImageXFile!.path);

      // Get image information
      final fileSize = await selectedImageFile!.length();
      final fileSizeInMB = fileSize / (1024 * 1024);

      print('Image captured successfully:');
      print('File size: ${fileSizeInMB.toStringAsFixed(2)} MB');
      print('File path: ${selectedImageFile!.path}');

      isImageVisible = true;
      update();

      // Here you can add your image upload logic
      // await uploadImage(selectedImageFile);

      isAttachmentUpload = false;
      update();

      return true;
    } catch (error) {
      print('Error in capturing image: $error');
      isAttachmentUpload = false;
      update();
      ShowSnackBars.showError('Failed to capture image. Please try again.');
      return false;
    }
  }

  // Clear the form and reset states
  void clearForm() {
    selectedImageFile = null;
    selectedImageXFile = null;
    isImageVisible = false;
    uploadProgress = 0.0;
    update();
  }

  // Handle image capture when button is pressed
  Future<void> onCaptureImage() async {
    var result = await captureHighQualityImage();

    if (!result) {
      ShowSnackBars.showError('Failed to capture image. Please try again.');
    }
  }

  void deleteImage() {
    selectedImageFile = null;
    selectedImageXFile = null;
    isImageVisible = false;
    update();
  }
}

class ShowSnackBars {
  static void showError(String message) {
    if (Get.context != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  static void showSuccess(String message) {
    if (Get.context != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}