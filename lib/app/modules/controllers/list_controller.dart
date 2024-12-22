import 'package:get/get.dart';

import '../../data/api/dio_helpers.dart';
import '../../data/models/cash_drop.dart';
import '../../data/services/dialog_service.dart';
import 'main_controller.dart';

class ListController extends GetxController {
  // Dependencies
  final mainController = Get.find<MainController>();
  final _dioHelper = Get.find<DioHelper>();
  final _dialogService = Get.find<DialogService>();

  @override
  void onInit() async {
    super.onInit();
    await getAllCashDrops();
    update();
  }

  //-------------------------------------------------------------------------
  // ------------------------------Cash drops--------------------------------
  //-------------------------------------------------------------------------

  // Cash drops list
  List<CashDrop> cashDropsList = [];

  // Loding state
  bool isCashDropsLoading = false;

  // Get all cash drops
  Future<void> getAllCashDrops() async {
    try {
      isCashDropsLoading = true;
      update();

      final (response, error) = await _dioHelper.getAllCashDrops();

      if (error != null || response?.data == null) {
        isCashDropsLoading = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isCashDropsLoading = false;
        update();
        return;
      }

      if (response?.data is List) {
        try {
          cashDropsList = (response?.data as List)
              .map((item) => CashDrop.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (e) {
          isCashDropsLoading = false;
          update();
          await _dialogService.showErrorDialog(
            title: 'Error',
            description: 'Failed to process cash drops data',
            buttonText: 'OK',
          );
          isCashDropsLoading = false;
          update();
          return;
        }
      }
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
      isCashDropsLoading = false;
      update();
    } finally {
      isCashDropsLoading = false;
      update();
    }
  }
}
