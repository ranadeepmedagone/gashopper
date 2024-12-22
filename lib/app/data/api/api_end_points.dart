import 'package:flutter/foundation.dart';

class ApiEndPoints {
  static const productionBaseUrl = "https://gashopper.com";
  static const developmentBaseUrl = 'http://3.85.243.55:5555';

  // ------------ Server Address ------------ //
  static const serverAddress = kDebugMode ? developmentBaseUrl : productionBaseUrl;

  // Gashopper API endpoint
  static const gashopperAPIEndpoint = '/api/v1';

  // Base url
  static const baseUrl = serverAddress + gashopperAPIEndpoint;

  static const gasStationAPIEndpoint = '$baseUrl/gas_station';

  // Auth APIs
  static const requestOtpEndpoint = '$baseUrl/auth/otp/request';
  static const verifyOtpEndpoint = '$baseUrl/auth/login';

  // App inputs
  static const appInputsEndpoint = '$gasStationAPIEndpoint/module_inputs';
}
