import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class MainController extends GetxController {
  bool isOnPressSales = false;

  bool isOnPressExpenses = false;

  bool isOnPressCashDrop = false;

  bool isOnPressRequest = false;

  bool isOnPressReports = false;

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
}
