import 'package:flutter/foundation.dart';

class ApiEndPoints {
  static const productionBaseUrl = "https://gashopper.com";
  static const developmentBaseUrl = 'http://3.85.243.55:5555';

  // http://3.85.243.55:5555

  // ------------ Server Address ------------ //
  static const serverAddress = kDebugMode ? developmentBaseUrl : developmentBaseUrl;

  // Gashopper API endpoint
  static const gashopperAPIEndpoint = '/api/v1';

  // Base url
  static const baseUrl = serverAddress + gashopperAPIEndpoint;

  // Gas Station API
  static const gasStationAPIEndpoint = '$baseUrl/gas_station';
  static const stationPumpAPIEndpoint = '$gasStationAPIEndpoint/pump_history';

  // Auth APIs
  static const requestOtpEndpoint = '$baseUrl/auth/otp/request';
  static const verifyOtpEndpoint = '$baseUrl/auth/login';

  // App inputs
  static const appInputsEndpoint = '$gasStationAPIEndpoint/module_inputs';

  // Cash drop API
  static const cashDropAPIEndpoint = '$baseUrl/cash_drop';

  // Station request API
  static const stationRequestAPIEndpoint = '$baseUrl/station_request';

  // Sale API
  static const saleAPIEndpoint = '$baseUrl/station_fuel_sale';

  // Expenses API
  static const expensesAPIEndpoint = '$baseUrl/expenses';

  // User Shift API
  static const userShiftAPIEndpoint = '$baseUrl/user_shift';

  // Inventory History API
  static const inventoryCreateyAPIEndpoint = '$baseUrl/station_fuel_sale/inventory';
  static const inventoryHistoryAPIEndpoint = '$inventoryCreateyAPIEndpoint/history';

  // File upload
  static const postUploadFile = '$baseUrl/media/upload_s3';
}
