// lib/core/network/dio_helper.dart
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:gashopper/app/data/api/api_end_points.dart';
import 'package:get/get.dart';

import '../services/dialog_services.dart';

class DioHelper extends GetxService {
  // Singleton pattern
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

  void _initializeDio() {
    // For handling certificate issues in debug
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
      _LoggerInterceptor(),
      _ErrorInterceptor(),
      _RequestInterceptor(),
      _ResponseInterceptor(),
    ]);
  }

  // Auth APIs
  Future<dio.Response> requestOtp(String email) async {
    try {
      final response = await _dio.post(
        ApiEndPoints.requestOtp,
        data: {'email': email},
      );

      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dio.Response> verifyOtp({
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

      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dio.Response> resendOtp(String email) async {
    try {
      final response = await _dio.post(
        // ApiEndPoints.resendOtp,
        '',
        data: {'email': email},
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dio.Response> logout() async {
    try {
      final response = await _dio.post(
        // ApiEndPoints.logout,
        '',
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Error Handling
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException('Request timeout');

        case DioExceptionType.badResponse:
          switch (error.response?.statusCode) {
            case 400:
              return BadRequestException(
                error.response?.data['message'] ?? 'Bad request',
              );
            case 401:
              // Handle unauthorized
              Get.offAllNamed('/login');
              return UnauthorizedException(
                error.response?.data['message'] ?? 'Unauthorized',
              );
            case 403:
              return UnauthorizedException(
                error.response?.data['message'] ?? 'Access denied',
              );
            case 404:
              return NotFoundException(
                error.response?.data['message'] ?? 'Not found',
              );
            case 500:
              return ServerException(
                error.response?.data['message'] ?? 'Server error',
              );
            default:
              return ServerException(
                error.response?.data['message'] ?? 'Server error',
              );
          }

        case DioExceptionType.cancel:
          return RequestCancelledException('Request cancelled');

        default:
          return NetworkException('Network error occurred');
      }
    }
    return UnknownException('Unknown error occurred');
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

// Custom Exceptions
class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
}

class RequestCancelledException implements Exception {
  final String message;
  RequestCancelledException(this.message);
}
