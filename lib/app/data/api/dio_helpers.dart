import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:gashopper/app/data/api/api_end_points.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../services/dialog_service.dart';

class DioHelper extends GetxController {
  static final DioHelper _instance = DioHelper._internal();
  factory DioHelper() => _instance;
  DioHelper._internal();

  static DioHelper get instance => Get.find<DioHelper>();

  final dio.Dio _dio = dio.Dio(
    dio.BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @override
  void onInit() {
    super.onInit();
    _initializeDio();
  }

  // initialize dio
  void _initializeDio() {
    if (!kReleaseMode) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient(
          context: SecurityContext(withTrustedRoots: false),
        );
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }

    _dio.interceptors.addAll(
      [
        TokenInterceptor(),
        _LoggerInterceptor(),
        _ErrorInterceptor(),
        _ResponseInterceptor(),
        _RequestInterceptor()
      ],
    );
  }

  // Handle request
  Future<(dio.Response?, String?)> _handleRequest(
    Future<dio.Response> Function() request,
  ) async {
    try {
      final response = await request();
      return (response, null);
    } catch (err) {
      if (err is dio.DioException) {
        // First check if there's a server error message
        final responseData = err.response?.data;
        if (responseData != null) {
          if (responseData is Map && responseData['message'] != null) {
            return (null, responseData['message'].toString());
          }
          if (responseData is String && responseData.isNotEmpty) {
            return (null, responseData);
          }
        }

        // If no server message, use status code based messages
        switch (err.response?.statusCode) {
          case 400:
            return (null, 'Bad request. Please check your input.');
          case 401:
            return (null, 'Unauthorized. Please login again.');
          case 403:
            return (null, 'Access forbidden. You don\'t have permission.');
          case 404:
            return (null, 'Data not found');
          case 500:
            return (null, 'Internal server error. Please try again later.');
          case 502:
            return (null, 'Server is currently unavailable. Please try again later.');
          case 503:
            return (null, 'Service unavailable. Please try again later.');
          default:
            return (null, 'Server error occurred (${err.response?.statusCode})');
        }
      }
      return (null, err.toString());
    }
  }

  // Request OTP
  Future<(dio.Response?, String?)> requestOtp(String email) async {
    return _handleRequest(
      () => _dio.post(
        ApiEndPoints.requestOtpEndpoint,
        data: {'email': email},
      ),
    );
  }

  // Verify OTP
  Future<(dio.Response?, String?)> verifyOtp({
    required String? email,
    required int otp,
    required String? referenceNumber,
  }) async {
    return _handleRequest(
      () => _dio.post(
        ApiEndPoints.verifyOtpEndpoint,
        data: {
          'email': email,
          'otp': otp,
          'reference_number': referenceNumber,
          'password': '',
        },
      ),
    );
  }

  // Get app inputs
  Future<(dio.Response?, String?)> appInputs() async {
    return _handleRequest(
      () => _dio.get(
        ApiEndPoints.appInputsEndpoint,
      ),
    );
  }

  // Get all gas stations
  Future<(dio.Response?, String?)> getAllGasStations() async {
    return _handleRequest(
      () => _dio.get(
        ApiEndPoints.gasStationAPIEndpoint,
      ),
    );
  }

  // Get all cash drops
  Future<(dio.Response?, String?)> getAllCashDrops() async {
    return _handleRequest(
      () => _dio.get(
        ApiEndPoints.cashDropAPIEndpoint,
      ),
    );
  }

  // Create cash drop
  Future<(dio.Response?, String?)> createCashDrop({
    required String? description,
    required int amount,
  }) async {
    return _handleRequest(
      () => _dio.post(
        ApiEndPoints.cashDropAPIEndpoint,
        data: {
          'amount': amount,
          'description': description,
        },
      ),
    );
  }

  // Get all cash drops
  Future<(dio.Response?, String?)> getAllStationRequests() async {
    return _handleRequest(
      () => _dio.get(
        ApiEndPoints.stationRequestAPIEndpoint,
      ),
    );
  }

  // Station request create
  Future<(dio.Response?, String?)> createStationRequest({
    required int requestTypeId,
    required String? description,
  }) async {
    return _handleRequest(
      () => _dio.post(
        ApiEndPoints.stationRequestAPIEndpoint,
        data: {
          'request_type_id': requestTypeId,
          'description': description,
        },
      ),
    );
  }
}

// Interceptors
class _LoggerInterceptor extends dio.Interceptor {
  @override
  void onRequest(dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(dio.Response response, dio.ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}

class _ErrorInterceptor extends dio.Interceptor {
  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 502) {
      Get.find<DialogService>().showErrorDialog(
        title: 'Server Maintenance',
        description: 'Server is under maintenance. Please try again later.',
      );
    }
    return super.onError(err, handler);
  }
}

class _RequestInterceptor extends dio.Interceptor {
  @override
  void onRequest(dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    final token = Get.find<AuthService>().authToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.queryParameters.addAll({
      'app_version': '1.0.0',
    });

    return super.onRequest(options, handler);
  }
}

class _ResponseInterceptor extends dio.Interceptor {
  @override
  void onResponse(dio.Response response, dio.ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      final map = response.headers.map;
      final responseData = response.data;

      if (map.containsKey('x-total-count')) {
        response.data = {
          'total_count': int.tryParse(map['x-total-count']?.first ?? '0'),
          'page': int.tryParse(map['x-page']?.first ?? '0'),
          'limit': int.tryParse(map['x-limit']?.first ?? '0'),
          'data': responseData,
        };
      }
    }
    return super.onResponse(response, handler);
  }
}

class TokenInterceptor extends dio.Interceptor {
  @override
  void onRequest(dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    final token = Get.find<AuthService>().authToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      Get.find<AuthService>().logout();
    }
    return super.onError(err, handler);
  }
}
