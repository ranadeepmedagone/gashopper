import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../data/api/dio_helpers.dart';
import '../../../data/models/app_inputs.dart';
import '../../../data/services/dialog_service.dart';
import '../../../routes/app_pages.dart';
import '../../home/home_controller.dart';

class MaintenanceController extends GetxController {
  final homeController = Get.put(HomeController());
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  String senderText = "Problem with pump 1\nDetails: Screen not working";
  String receivedText = "Technician will come tomorrow";
  List<Map<String, dynamic>> messages = [];

  TextEditingController messageController = TextEditingController();

  final _dialogService = Get.find<DialogService>();
  final dioHelper = Get.find<DioHelper>();

  List<StationInventory> stationInventories = [];
  List<StationPump> stationPumps = [];
  List<StationInventoryHistory> inventoryHistory = [];
  List<IdNameRecord> priorityTypes = [];
  List<IdNameRecord> historyReasons = [];

  bool editInventory = false;

  bool isInventoryListLoading = false;

  TextEditingController inventoryNameController = TextEditingController();
  TextEditingController countController = TextEditingController();

  TextEditingController stationPumpDesController = TextEditingController();

  IdNameRecord? _selectedPriority;
  IdNameRecord? get selectedPriority => _selectedPriority;
  set selectedPriority(IdNameRecord? value) {
    _selectedPriority = value;
    update();
  }

  IdNameRecord? _selectedHistoryReason;
  IdNameRecord? get selectedHistoryReason => _selectedHistoryReason;
  set selectedHistoryReason(IdNameRecord? value) {
    _selectedHistoryReason = value;
    update();
  }

  StationPump? stationPump;

  @override
  void onInit() async {
    await getInventoryHistory();

    stationInventories = homeController.appInputs?.stationInventories ?? [];
    stationPumps = homeController.appInputs?.stationPumps ?? [];
    priorityTypes = homeController.appInputs?.priorityTypes ?? [];
    historyReasons = homeController.appInputs?.historyReasons ?? [];

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

  // --------------------------------------------------------------
  // ----------------------Inventory history ---------------------
  // --------------------------------------------------------------

  // Get inventory history
  Future<void> getInventoryHistory() async {
    isInventoryListLoading = true;
    update();

    try {
      final (response, error) = await dioHelper.getAllInventoryHistory();

      if (response?.data is List) {
        try {
          inventoryHistory = (response?.data as List)
              .map((item) => StationInventoryHistory.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (e) {
          await _dialogService.showErrorDialog(
            title: 'Error',
            description: 'Failed to process inventory history data',
            buttonText: 'OK',
          );
          return;
        }
      }

      if (error != null || response?.data == null) {
        isInventoryListLoading = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        return;
      }

      isInventoryListLoading = false;
      update();
    } catch (e) {
      isInventoryListLoading = false;
      update();
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
    } finally {
      update();
    }
  }

  // --------------------------------------------------------------
  // ----------------------Inventory create ---------------------
  // --------------------------------------------------------------

  Future<void> createInventory() async {
    // Prevent multiple simultaneous calls
    if (isInventoryListLoading) return;

    Get.back();

    try {
      // Set initial loading state
      editInventory = false;
      isInventoryListLoading = true;
      update();

      // Parse count and make API call
      final count = countController.text.trim().isNotEmpty
          ? int.parse(countController.text.trim())
          : null;

      final (response, error) = await dioHelper.createInventory(
        inventoryName: inventoryNameController.text.trim(),
        count: count,
      );

      // Handle error cases
      if (error != null || response?.data == null) {
        isInventoryListLoading = false;
        update();

        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );

        return;
      }

      // Handle success
      await homeController.getAppInputs();
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
    } finally {
      // Reset loading state
      isInventoryListLoading = false;
      editInventory = true;
      update();
    }
  }

  // --------------------------------------------------------------
  // ----------------------Station Pump create ---------------------
  // --------------------------------------------------------------

  bool isCreateStationPumpLoading = false;

  Future<void> createStationPump() async {
    try {
      // Set initial loading state
      isCreateStationPumpLoading = true;
      update();

      final (response, error) = await dioHelper.createStationPump(
        stationPumpId: stationPump!.id!,
        issueDescription: stationPumpDesController.text.trim(),
        attachments: [],
      );

      // Handle error cases
      if (error != null || response?.data == null) {
        isCreateStationPumpLoading = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'Error creating station pump',
          buttonText: 'OK',
        );

        return;
      }

      // Handle success
      await homeController.getAppInputs();

      Get.toNamed(
        Routes.maintenanceChatScreen,
      );
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
    } finally {
      // Reset loading state
      isCreateStationPumpLoading = false;
      update();
    }
  }
}
