import 'package:flutter/material.dart';
import 'package:gashopper/app/data/models/app_inputs.dart';
import 'package:get/get.dart';

import '../../data/api/dio_helpers.dart';
import '../../data/models/cash_drop.dart';
import '../../data/models/expenses.dart';
import '../../data/models/fuel_sale.dart';
import '../../data/models/station_request.dart';
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
  List<IdNameRecord> fuelTypes = [];
  List<IdNameRecord> paymentTypes = [];

  IdNameRecord? _selectedRequestOrReportType;
  IdNameRecord? get selectedRequestOrReport => _selectedRequestOrReportType;
  set selectedRequestOrReport(IdNameRecord? value) {
    _selectedRequestOrReportType = value;
    update();
  }

  IdNameRecord? _selectedSalePaymentType;
  IdNameRecord? get selectedSalePayment => _selectedSalePaymentType;
  set selectedSalePayment(IdNameRecord? value) {
    _selectedSalePaymentType = value;
    update();
  }

  IdNameRecord? _selectedFuelType;
  IdNameRecord? get selectedFuel => _selectedFuelType;
  set selectedFuel(IdNameRecord? value) {
    _selectedFuelType = value;
    update();
  }

  IdNameRecord? _selectedExpensePaymentType;
  IdNameRecord? get selectedExpensePayment => _selectedExpensePaymentType;
  set selectedExpensePayment(IdNameRecord? value) {
    _selectedExpensePaymentType = value;
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

  // Cash drop arguments
  CashDrop? argCashDrop;

  // Sale arguments
  FuelSale? argSale;

  // Expense arguments
  Expenses? argExpense;

  // Station request arguments
  StationRequest? argStationRequest;

  @override
  void onInit() async {
    super.onInit();

    final args = Get.arguments;

    if (args is Map<String, dynamic>) {
      argCashDrop = args['cashDrop'] as CashDrop?;
      argSale = args['sale'] as FuelSale?;
      argExpense = args['expense'] as Expenses?;
      argStationRequest = args['stationRequest'] as StationRequest?;
    }

    // Get all request types
    requestTypes = mainController.appInputs?.requestTypes ?? [];
    paymentTypes = mainController.appInputs?.paymenTypes ?? [];
    fuelTypes = mainController.appInputs?.fuelTypes ?? [];

    if (argCashDrop != null) {
      cashDropDesController.text = argCashDrop!.description ?? '';
      cashDropAmountController.text = argCashDrop!.amount.toString();
    }

    if (argSale != null) {
      saleAmountController.text = argSale!.addedAmount.toString();
      selectedFuel = fuelTypes.firstWhere((e) => e.id == argSale!.fuelTypeId);
      selectedSalePayment = paymentTypes.firstWhere((e) => e.id == argSale!.paymentTypeId);
    }

    if (argExpense != null) {
      expensesDesController.text = argExpense!.description ?? '';
      expensesAmountController.text = argExpense!.addedAmount.toString();
      selectedExpensePayment =
          paymentTypes.firstWhere((e) => e.id == argExpense!.paymentTypeId);
    }

    if (argStationRequest != null) {
      stationRequestOrReportDesController.text = argStationRequest!.description ?? '';
      selectedRequestOrReport =
          requestTypes.firstWhere((e) => e.id == argStationRequest!.requestTypeId);
    }

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

  // Update cash drop
  Future<void> updateCashDrop() async {
    try {
      isCashDropsCreating = true;
      update();

      final (response, error) = await _dioHelper.updateCashDrop(
        cashDropId: argCashDrop!.id!,
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
      cashDropDesController.text = '';
      cashDropAmountController.clear();
      cashDropAmountController.text = '';

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
  final TextEditingController stationRequestOrReportDesController = TextEditingController();

  bool isStationRequestsOrReportsCreating = false;

  String? errorMessage;

  // Create station request
  Future<void> createStationRequestOrReport() async {
    try {
      if (selectedRequestOrReport == null) {
        errorMessage = 'Please select a request type';
        update();
        return;
      }

      // if (stationRequestDesController.text.trim().isEmpty) {
      //   errorMessage = 'Please enter a description';
      //   update();
      //   return;
      // }

      isStationRequestsOrReportsCreating = true;
      update();

      final (response, error) = await _dioHelper.createStationRequestOrReport(
        requestTypeId: selectedRequestOrReport!.id!,
        description: stationRequestOrReportDesController.text.trim(),
      );

      if (error != null || response?.data == null) {
        isStationRequestsOrReportsCreating = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isStationRequestsOrReportsCreating = false;
        update();
        return;
      }

      stationRequestOrReportDesController.clear();
      stationRequestOrReportDesController.text = '';

      Get.back();
      await listController.getAllStationRequests();
      update();
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
      isStationRequestsOrReportsCreating = false;
      update();
    } finally {
      isStationRequestsOrReportsCreating = false;
      update();
    }
  }

  // Update station request
  Future<void> updateStationRequest() async {
    try {
      isStationRequestsOrReportsCreating = true;
      update();

      final (response, error) = await _dioHelper.updateStationRequest(
        stationRequestId: argStationRequest!.id!,
        requestTypeId: selectedRequestOrReport!.id!,
        description: stationRequestOrReportDesController.text.trim(),
      );

      if (error != null || response?.data == null) {
        isStationRequestsOrReportsCreating = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isStationRequestsOrReportsCreating = false;
        update();
        return;
      }

      stationRequestOrReportDesController.clear();
      stationRequestOrReportDesController.text = '';

      Get.back();
      await listController.getAllStationRequests();
      update();
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
      isStationRequestsOrReportsCreating = false;
      update();
    } finally {
      isStationRequestsOrReportsCreating = false;
      update();
    }
  }

  // ----------------------------------------------------------
  // ----------------------  Fuel sale create ------------------
  // ----------------------------------------------------------

  // Controllers
  final TextEditingController saleAmountController = TextEditingController();

  bool isSaleCreating = false;

  // Create station request
  Future<void> createSale() async {
    try {
      if (saleAmountController.text.trim().isEmpty) {
        errorMessage = 'Please enter a amount';
        update();
        return;
      }

      if (selectedSalePayment == null) {
        errorMessage = 'Please select a payment type';
        update();
        return;
      }

      if (selectedFuel == null) {
        errorMessage = 'Please select a fuel type';
        update();
        return;
      }

      isSaleCreating = true;
      update();

      final (response, error) = await _dioHelper.createSale(
        fuelTypeId: selectedFuel!.id!,
        addedAmount: int.parse(saleAmountController.text.trim()),
        paymentTypeId: selectedSalePayment!.id!,
      );

      if (error != null || response?.data == null) {
        isSaleCreating = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isSaleCreating = false;
        update();
        return;
      }

      saleAmountController.clear();
      saleAmountController.text = '';
      selectedFuel = null;
      selectedSalePayment = null;

      Get.back();
      await listController.getAllSales();
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
      isSaleCreating = false;
      update();
    } finally {
      isSaleCreating = false;
      update();
    }
  }

  // Update sale
  Future<void> updateSale() async {
    try {
      isSaleCreating = true;
      update();

      final (response, error) = await _dioHelper.updateSale(
        saleId: argSale!.fuelTypeId!,
        fuelTypeId: selectedFuel!.id!,
        addedAmount: int.parse(saleAmountController.text.trim()),
        paymentTypeId: selectedSalePayment!.id!,
      );

      if (error != null || response?.data == null) {
        isSaleCreating = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isSaleCreating = false;
        update();
        return;
      }

      saleAmountController.clear();
      saleAmountController.text = '';
      selectedFuel = null;
      selectedSalePayment = null;

      Get.back();
      await listController.getAllSales();
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
      isSaleCreating = false;
      update();
    } finally {
      isSaleCreating = false;
      update();
    }
  }

  // ----------------------------------------------------------
  // ----------------------  Expenses create ------------------
  // ----------------------------------------------------------

  // Controllers
  final TextEditingController expensesDesController = TextEditingController();
  final TextEditingController expensesAmountController = TextEditingController();

  bool isExpensesCreating = false;

  // Create station request
  Future<void> createExpense() async {
    try {
      if (expensesDesController.text.trim().isEmpty) {
        errorMessage = 'Please enter a description';
        update();
        return;
      }

      if (expensesAmountController.text.trim().isEmpty) {
        errorMessage = 'Please enter a amount';
        update();
        return;
      }

      if (selectedExpensePayment == null) {
        errorMessage = 'Please select a payment type';
        update();
        return;
      }
      isExpensesCreating = true;
      update();

      final (response, error) = await _dioHelper.createExpense(
        description: expensesDesController.text.trim(),
        addedAmount: int.parse(expensesAmountController.text.trim()),
        paymentTypeId: selectedExpensePayment!.id!,
      );

      if (error != null || response?.data == null) {
        isExpensesCreating = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isExpensesCreating = false;
        update();
        return;
      }
      expensesDesController.clear();
      expensesDesController.text = '';
      expensesAmountController.clear();
      expensesAmountController.text = '';
      selectedExpensePayment = null;

      Get.back();
      await listController.getAllExpenses();
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
      isExpensesCreating = false;
      update();
    } finally {
      isExpensesCreating = false;
      update();
    }
  }

  // Update expense
  Future<void> updateExpense() async {
    try {
      isExpensesCreating = true;
      update();

      final (response, error) = await _dioHelper.updateExpense(
        expenseId: argExpense!.id!,
        description: expensesDesController.text.trim(),
        addedAmount: int.parse(expensesAmountController.text.trim()),
        paymentTypeId: selectedExpensePayment!.id!,
      );

      if (error != null || response?.data == null) {
        isExpensesCreating = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isExpensesCreating = false;
        update();
        return;
      }
      expensesDesController.clear();
      expensesDesController.text = '';
      expensesAmountController.clear();
      expensesAmountController.text = '';
      selectedExpensePayment = null;

      Get.back();
      await listController.getAllExpenses();
      update();
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
      isExpensesCreating = false;
      update();
    } finally {
      isExpensesCreating = false;
      update();
    }
  }
}
