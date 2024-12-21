// lib/core/network/dio_helper.dart
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:gashopper/app/data/api/api_end_points.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../services/dialog_service.dart';

class DioHelper extends GetxController {
  // Singleton pattern
  static final DioHelper _instance = DioHelper._internal();

  factory DioHelper() => _instance;

  DioHelper._internal();

  static DioHelper get instance => Get.find<DioHelper>();

  String? authToken;

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

    _dio.interceptors.addAll([
      TokenInterceptor(),
      _LoggerInterceptor(),
      _ErrorInterceptor(),
      _ResponseInterceptor(),
      _RequestInterceptor()
    ]);
  }

  // Auth APIs
  // Request OTP
  Future<(dynamic, String?)> requestOtp(String email) async {
    try {
      final response = await _dio.post(
        ApiEndPoints.requestOtp,
        data: {'email': email},
      );

      if (response.statusCode == 200) return (response, null);
    } catch (err) {
      if (err is DioException) {
        if (err.response?.data is String) {
          return (null, err.response?.data.toString());
        }
        if (err.response?.data['message'] is String) {
          return (null, err.response?.data['message'].toString());
        }
        return (null, null);
      }
      return (null, null);
    }
    return (null, null);
  }

  // Verify OTP
  Future<(dynamic, String?)> verifyOtp({
    required String? email,
    required int otp,
    required String? referenceNumber,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndPoints.verifyOtp,
        data: {
          'email': email,
          'otp': otp,
          'reference_number': referenceNumber,
          'password': '',
        },
      );

      if (response.statusCode == 200) {
        return (response, null);
      }
    } catch (err) {
      if (err is DioException) {
        if (err.response?.data is String) {
          return (null, err.response?.data.toString());
        }
        if (err.response?.data['message'] is String) {
          return (null, err.response?.data['message'].toString());
        }
        return (null, null);
      }
      return (null, null);
    }
    return (null, null);
  }
}

// Interceptors
class _LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(dio.Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 502) {
      // Handle server maintenance/update
      Get.find<DialogService>().showErrorDialog(
        title: 'Server Maintenance',
        description: 'Server is under maintenance. Please try again later.',
      );
    }
    return super.onError(err, handler);
  }
}

class _RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add auth token if available

    const token = '';

    options.headers['Authorization'] = 'Bearer $token';

    // Add version
    options.queryParameters.addAll({
      'app_version': '1.0.0', // Get from package info
    });

    return super.onRequest(options, handler);
  }
}

class _ResponseInterceptor extends Interceptor {
  @override
  void onResponse(dio.Response response, ResponseInterceptorHandler handler) {
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

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = Get.find<AuthService>().authToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      Get.find<AuthService>().logout();
    }
    return super.onError(err, handler);
  }
}
