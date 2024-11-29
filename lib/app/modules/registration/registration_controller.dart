import 'package:get/get.dart';

class RegistrationController extends GetxController {
  bool isRegister = false;

  // Toggle register
  void toggleRegister() {
    isRegister = !isRegister;
    update();
  }
}
