import 'package:get/get.dart';

class RegistrationController extends GetxController {
  bool isRegister = false;

  bool isForgetPassword = false;

  // Toggle register
  void toggleRegister() {
    isRegister = !isRegister;
    update();
  }

  // Toggle forget password
  void toggleForgetPassword() {
    isForgetPassword = !isForgetPassword;
    update();
  }
}
