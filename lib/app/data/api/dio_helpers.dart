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

    _dio.interceptors.addAll([
      TokenInterceptor(),
      _LoggerInterceptor(),
      _ErrorInterceptor(),
      _ResponseInterceptor(),
      _RequestInterceptor()
    ]);
  }

  // Extract error messages from dio response.
  String? _extractErrorMessage(dynamic error) {
    if (error is dio.DioException) {
      if (error.response?.data is String) {
        return error.response?.data.toString();
      }
      if (error.response?.data is Map) {
        final map = error.response?.data as Map;
        return map['message']?.toString() ??
            map['error']?.toString() ??
            map['error_message']?.toString();
      }
      return error.message;
    }
    return error.toString();
  }

  // Handle request
  Future<(dio.Response?, String?)> _handleRequest(
    Future<dio.Response> Function() request,
  ) async {
    try {
      final response = await request();
      return (response, null);
    } catch (error) {
      return (null, _extractErrorMessage(error));
    }
  }

  // Request OTP
  Future<(dio.Response?, String?)> requestOtp(String email) async {
    return _handleRequest(() => _dio.post(
          ApiEndPoints.requestOtp,
          data: {'email': email},
        ));
  }

  // Verify OTP
  Future<(dio.Response?, String?)> verifyOtp({
    required String? email,
    required int otp,
    required String? referenceNumber,
  }) async {
    return _handleRequest(() => _dio.post(
          ApiEndPoints.verifyOtp,
          data: {
            'email': email,
            'otp': otp,
            'reference_number': referenceNumber,
            'password': '',
          },
        ));
  }

  // Get app inputs
  Future<(dio.Response?, String?)> appInputs() async {
    return _handleRequest(() => _dio.get(''));
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
    const token = '';
    options.headers['Authorization'] = 'Bearer $token';

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
