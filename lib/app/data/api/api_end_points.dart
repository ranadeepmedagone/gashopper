import 'package:flutter/foundation.dart';

class ApiEndPoints {
  static const productionBaseUrl = "https://gashopper.com";
  static const developmentBaseUrl = 'https://dev-gashopper.com';

  static const gashopperAPIEndpoint = '/api/gashopper/v1';

  // ------------ Server Address ------------ //
  static const serverAddress = kDebugMode ? developmentBaseUrl : productionBaseUrl;

  static const baseUrl = serverAddress + gashopperAPIEndpoint;
}
