import 'package:get/get.dart';

class SettingsController extends GetxController {
  final List<String> languages = [
    'Telugu',
    'Hindi',
    'English',
    'Gujarati',
    'Rajasthani',
  ];

  String selectedLanguage = 'English';

  void updateLanguage(String language) {
    selectedLanguage = language;
    update();
  }
}
