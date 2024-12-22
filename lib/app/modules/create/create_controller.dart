import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/api/dio_helpers.dart';
import '../../data/services/dialog_service.dart';
import '../home/home_controller.dart';

class CreateController extends GetxController {
// Dependencies
  final mainController = Get.find<HomeController>();
  final _dioHelper = Get.find<DioHelper>();
  final _dialogService = Get.find<DialogService>();

  // Controllers
  final TextEditingController cashDropDesController = TextEditingController();
  final TextEditingController cashDropAmountController = TextEditingController();

  // Loading state
  bool isCashDropsCreating = false;

  @override
  void onInit() async {
    super.onInit();
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
}
