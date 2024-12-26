import 'package:flutter/material.dart';
import 'package:gashopper/app/data/models/app_inputs.dart';
import 'package:get/get.dart';

import '../../data/api/dio_helpers.dart';
import '../../data/services/dialog_service.dart';
import '../home/home_controller.dart';
import '../list/list_controller.dart';

class CreateController extends GetxController {
// Dependencies
  final mainController = Get.find<HomeController>();
  final _dioHelper = Get.find<DioHelper>();
  final _dialogService = Get.find<DialogService>();
  final listController = Get.find<ListController>();

  List<IdNameRecord> requestTypes = [];

  IdNameRecord? _selectedRequestType;
  IdNameRecord? get selectedRequest => _selectedRequestType;
  set selectedRequest(IdNameRecord? value) {
    _selectedRequestType = value;
    update();
  }

  //-------------------------------------------------------------------------
  // ------------------------------Cash drops create------------------------
  //-------------------------------------------------------------------------

  // Controllers
  final TextEditingController cashDropDesController = TextEditingController();
  final TextEditingController cashDropAmountController = TextEditingController();

  // Loading state
  bool isCashDropsCreating = false;

  @override
  void onInit() async {
    super.onInit();

    // Get all request types
    requestTypes = mainController.appInputs?.requestTypes ?? [];

    update();
  }

  // Create cash drop
  Future<void> createCashDrop() async {
    try {
      isCashDropsCreating = true;
      update();

      final (response, error) = await _dioHelper.createCashDrop(
        description: cashDropDesController.text.trim(),
        amount: int.parse(cashDropAmountController.text.trim()),
      );

      if (error != null || response?.data == null) {
        isCashDropsCreating = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isCashDropsCreating = false;
        update();
        return;
      }

      cashDropDesController.clear();
      cashDropAmountController.clear();
      cashDropAmountController.text = '';
      cashDropDesController.text = '';

      Get.back();
      await listController.getAllCashDrops();
      update();
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
      isCashDropsCreating = false;
      update();
    } finally {
      isCashDropsCreating = false;
      update();
    }
  }

  //-------------------------------------------------------------------------
  //------------------------------Station Requests create--------------------
  //-------------------------------------------------------------------------

  // Controllers
  final TextEditingController stationRequestDesController = TextEditingController();

  bool isStationRequestsCreating = false;

  String? errorMessage;

  // Create station request
  Future<void> createStationRequest() async {
    try {
      if (selectedRequest == null) {
        errorMessage = 'Please select a request type';
        update();
        return;
      }

      // if (stationRequestDesController.text.trim().isEmpty) {
      //   errorMessage = 'Please enter a description';
      //   update();
      //   return;
      // }

      isStationRequestsCreating = true;
      update();

      final (response, error) = await _dioHelper.createStationRequest(
        requestTypeId: selectedRequest!.id!,
        description: stationRequestDesController.text.trim(),
      );

      if (error != null || response?.data == null) {
        isStationRequestsCreating = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isStationRequestsCreating = false;
        update();
        return;
      }

      stationRequestDesController.clear();
      stationRequestDesController.text = '';

      Get.back();
      await listController.getAllStationRequests();
      update();
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
      isStationRequestsCreating = false;
      update();
    } finally {
      isStationRequestsCreating = false;
      update();
    }
  }
}
