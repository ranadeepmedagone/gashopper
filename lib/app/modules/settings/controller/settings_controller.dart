import 'package:get/get.dart';

class SettingsController extends GetxController {
  final List<String> languages = [
    'Telugu',
    'English',
    'Gujarati',
    'Rajasthani',
    'Hindi',
  ];

  String selectedLanguage = 'English'; // Default language

  // Function to update the selected language
  void updateLanguage(String language) {
    selectedLanguage = language;
    update(); // Notify listeners to rebuild the UI
  }
}
