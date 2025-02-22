import 'package:get/get.dart';

import '../../data/api/dio_helpers.dart';
import '../../data/models/app_inputs.dart';
import '../../data/models/gas_station.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/dialog_service.dart';
import '../../routes/app_pages.dart';
import '../registration/registration_controller.dart';

class HomeController extends GetxController {
  // Dependencies
  final DioHelper _dioHelper = Get.find<DioHelper>();
  final DialogService _dialogService = Get.find<DialogService>();
  final authService = Get.find<AuthService>();
  final registrationController = Get.put(RegistrationController());

  // Model
  AppInputs? appInputs;
  List<GasStation> gasStations = [];

  // State variables
  bool isOnPressSales = false;

  bool isOnPressExpenses = false;

  bool isOnPressCashDrop = false;

  bool isOnPressRequest = false;

  bool isOnPressReports = false;

  bool isAppInputsLoading = false;

  bool isGasStationsLoading = false;

  @override
  void onInit() async {
    super.onInit();

    await getAppInputs();
    await getGasStations();
  }

  void onPressSales() {
    isOnPressSales = true;
    isOnPressCashDrop = false;
    isOnPressExpenses = false;
    isOnPressReports = false;
    isOnPressRequest = false;
    Get.toNamed(Routes.listScreen, arguments: isOnPressSales);
    update();
  }

  void onPressExpenses() {
    isOnPressExpenses = true;
    isOnPressCashDrop = false;
    isOnPressSales = false;
    isOnPressReports = false;
    isOnPressRequest = false;
    Get.toNamed(Routes.listScreen, arguments: isOnPressExpenses);
    update();
  }

  void onPressCashDrop() {
    isOnPressCashDrop = true;
    isOnPressExpenses = false;
    isOnPressSales = false;
    isOnPressReports = false;
    isOnPressRequest = false;
    Get.toNamed(Routes.listScreen, arguments: isOnPressCashDrop);
    update();
  }

  void onPressRequest() {
    isOnPressRequest = true;
    isOnPressCashDrop = false;
    isOnPressExpenses = false;
    isOnPressSales = false;
    isOnPressReports = false;
    Get.toNamed(Routes.listScreen, arguments: isOnPressRequest);
    update();
  }

  void onPressReport() {
    isOnPressReports = true;
    isOnPressCashDrop = false;
    isOnPressExpenses = false;
    isOnPressSales = false;
    isOnPressRequest = false;
    Get.toNamed(Routes.listScreen, arguments: isOnPressReports);
    update();
  }

  // void resetValues() {
  //   isOnPressCashDrop = false;
  //   isOnPressExpenses = false;
  //   isOnPressReports = false;
  //   isOnPressRequest = false;
  //   isOnPressSales = false;
  //   update();
  // }

  String getTypeNmae() {
    if (isOnPressSales) return 'Sales';
    if (isOnPressExpenses) return 'Expenses';
    if (isOnPressCashDrop) return 'Cash drop';
    if (isOnPressRequest) return 'Request';
    if (isOnPressReports) return 'Reports';
    return '';
  }

  // Get app inputs when user enter into the home screen
  Future<void> getAppInputs() async {
    try {
      isAppInputsLoading = true;
      update();

      final (response, error) = await _dioHelper.appInputs();

      if (error != null || response?.data == null) {
        isAppInputsLoading = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error.toString(),
          buttonText: 'OK',
        );
        isAppInputsLoading = false;
        update();
        return;
      }

      appInputs = AppInputs.fromJson(response?.data);
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
    } finally {
      isAppInputsLoading = false;
      update();
    }
  }

  // Get gas stations when user enter into the home screen
  Future<void> getGasStations() async {
    try {
      isGasStationsLoading = true;
      update();

      final (response, error) = await _dioHelper.getAllGasStations();

      if (error != null || response?.data == null) {
        isGasStationsLoading = false;
        update();
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        isGasStationsLoading = false;
        update();
        return;
      }

      if (response!.data is List) {
        try {
          gasStations = (response.data as List)
              .map((item) => GasStation.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (e) {
          isGasStationsLoading = false;
          update();
          await _dialogService.showErrorDialog(
            title: 'Error',
            description: 'Failed to process gas stations data',
            buttonText: 'OK',
          );
          isGasStationsLoading = false;
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
    } finally {
      isGasStationsLoading = false;
      update();
    }
  }
}
