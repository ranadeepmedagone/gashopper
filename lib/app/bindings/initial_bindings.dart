
import 'package:gashopper/app/modules/registration/registration_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut(() => RegistrationController(), fenix: true);
   
  }
}