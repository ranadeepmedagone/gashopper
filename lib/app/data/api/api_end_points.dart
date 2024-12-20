import 'package:flutter/foundation.dart';

class ApiEndPoints {
  static const productionBaseUrl = "https://gashopper.com";
  static const developmentBaseUrl = 'http://3.85.243.55:5555';

  static const gashopperAPIEndpoint = '/api/v1';

  // ------------ Server Address ------------ //
  static const serverAddress = kDebugMode ? developmentBaseUrl : productionBaseUrl;

  static const baseUrl = serverAddress + gashopperAPIEndpoint;

  // Auth APIs

  static const requestOtp = '$baseUrl/auth/otp/request';

  static const verifyOtp = '$baseUrl/auth/login';
}
