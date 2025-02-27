import 'package:gashopper/app/data/models/fuel_sale.dart';
import 'package:get/get.dart';

import '../../data/api/dio_helpers.dart';
import '../../data/models/cash_drop.dart';
import '../../data/models/expenses.dart';
import '../../data/models/station_request.dart';
import '../../data/services/dialog_service.dart';
import '../home/home_controller.dart';

class ListController extends GetxController {
  // Dependencies
  final mainController = Get.find<HomeController>();
  final _dioHelper = Get.find<DioHelper>();
  final _dialogService = Get.find<DialogService>();

  bool isEditCashDrop = false;
  bool isEditSale = false;
  bool isEditExpense = false;
  bool isEditStationRequest = false;

  @override
  void onInit() async {
    super.onInit();
    if (mainController.isOnPressCashDrop) {
      await getAllCashDrops();
    }
    if (mainController.isOnPressRequest) {
      await getAllStationRequests();
    }
    if (mainController.isOnPressSales) {
      await getAllSales();
    }
    if (mainController.isOnPressExpenses) {
      await getAllExpenses();
    }
    update();
  }

  bool isListScreenLoading = false;

  //-------------------------------------------------------------------------
  // ------------------------------Cash drops get list-----------------------
  //-------------------------------------------------------------------------

  // Cash drops list
  List<CashDrop> cashDropsList = [];

  // Loding state
  bool isCashDropsLoading = false;

  // Expanded state
  bool isExpanded = false;

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

  //-------------------------------------------------------------------------
  // ------------------------------Station Requests get list-----------------
  //-------------------------------------------------------------------------

  // Station requests list
  List<StationRequest> stationRequestsList = [];

  List<StationRequest> stationReportsList = [];

  // Loding state
  bool isStationRequestsLoading = false;

  // Get all station requests
  Future<void> getAllStationRequests() async {
    try {
      isStationRequestsLoading = true;
      update();

      final (response, error) = await _dioHelper.getAllStationRequests();

      if (error != null || response?.data == null) {
        isStationRequestsLoading = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isStationRequestsLoading = false;
        update();
        return;
      }

      if (response?.data is List) {
        try {
          stationRequestsList = (response?.data as List)
              .map((item) => StationRequest.fromJson(item as Map<String, dynamic>))
              .toList();

          stationRequestsList = stationRequestsList.where((e) => e.requestTypeId == 1).toList();
          stationReportsList = stationRequestsList.where((e) => e.requestTypeId == 2).toList();
          update();
        } catch (e) {
          isStationRequestsLoading = false;
          update();
          await _dialogService.showErrorDialog(
            title: 'Error',
            description: 'Failed to process cash drops data',
            buttonText: 'OK',
          );
          isStationRequestsLoading = false;
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
      isStationRequestsLoading = false;
      update();
    } finally {
      isStationRequestsLoading = false;
      update();
    }
  }

  // --------------------------------------------------------------
  // ----------------------Fuel sale get list ---------------------
  // --------------------------------------------------------------

  // Fuel sales list
  List<FuelSale> fuelSalesList = [];

  // Loding state
  bool isFuelSalesLoading = false;

  // Get all station requests
  Future<void> getAllSales() async {
    try {
      isFuelSalesLoading = true;
      update();

      final (response, error) = await _dioHelper.getAllSales();

      if (error != null || response?.data == null) {
        isFuelSalesLoading = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isFuelSalesLoading = false;
        update();
        return;
      }

      if (response?.data is List) {
        try {
          fuelSalesList = (response?.data as List)
              .map((item) => FuelSale.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (e) {
          isFuelSalesLoading = false;
          update();
          await _dialogService.showErrorDialog(
            title: 'Error',
            description: 'Failed to process cash drops data',
            buttonText: 'OK',
          );
          isFuelSalesLoading = false;
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
      isFuelSalesLoading = false;
      update();
    } finally {
      isFuelSalesLoading = false;
      update();
    }
  }

  // --------------------------------------------------------------
  // ----------------------Expenses get list ---------------------
  // --------------------------------------------------------------

  // Expenses list
  List<Expenses> expensesList = [];

  // Loding state
  bool isExpensesLoading = false;

  // Get all expenses
  Future<void> getAllExpenses() async {
    try {
      isExpensesLoading = true;
      update();

      final (response, error) = await _dioHelper.getAllExpenses();

      if (error != null || response?.data == null) {
        isExpensesLoading = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isExpensesLoading = false;
        update();
        return;
      }

      if (response?.data is List) {
        try {
          expensesList = (response?.data as List)
              .map((item) => Expenses.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (e) {
          isExpensesLoading = false;
          update();
          await _dialogService.showErrorDialog(
            title: 'Error',
            description: 'Failed to process expenses data',
            buttonText: 'OK',
          );
          isExpensesLoading = false;
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
      isExpensesLoading = false;
      update();
    } finally {
      isExpensesLoading = false;
      update();
    }
  }
}
