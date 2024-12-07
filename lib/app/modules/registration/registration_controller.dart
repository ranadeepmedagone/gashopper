import 'package:get/get.dart';

class RegistrationController extends GetxController {
  // bool isRegister = false;

  // bool isForgetPassword = false;

  // // Toggle register
  // void toggleRegister() {
  //   isRegister = !isRegister;
  //   isForgetPassword = false;
  //   update();
  // }

  // // Toggle forget password
  // void toggleForgetPassword() {
  //   isForgetPassword = !isForgetPassword;
  //   update();
  // }

  bool isMobileFlow = false;

  void toggleMobileFlow() {
    isMobileFlow = false;
    update();
  }
}
