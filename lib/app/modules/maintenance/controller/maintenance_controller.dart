import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // For formatting time

import '../../home/home_controller.dart';

class MaintenanceController extends GetxController {
  final homeController = Get.put(HomeController());
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  String senderText = "Problem with pump 1\nDetails: Screen not working";
  String receivedText = "Technician will come tomorrow";
  List<Map<String, dynamic>> messages = [];

  TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    messages.addAll([
      {"sender": "Asta", "message": senderText, "timestamp": DateTime.now()},
      {"receiver": "Technician", "message": receivedText, "timestamp": DateTime.now()}
    ]);
    super.onInit();
  }

  Future<void> takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      selectedImage = File(photo.path);
      update();
    }
  }

  void removeImage() {
    selectedImage = null;
    update();
  }

  void sendMessage(String text) {
    if (selectedImage != null) {
      messages.add({
        "sender": "Asta",
        "message": text,
        "image": selectedImage!.path,
        "timestamp": DateTime.now()
      });
      selectedImage = null;
    } else {
      messages.add({"sender": "Asta", "message": text, "timestamp": DateTime.now()});
    }
    update();
  }

  void receiveMessage(String text) {
    messages.add({
      "receiver": "Technician", // Example receiver name
      "message": text,
      "timestamp": DateTime.now()
    });
    update();
  }

  String formatTime(DateTime time) {
    return DateFormat.Hm().format(time); // Format as HH:mm
  }
}
