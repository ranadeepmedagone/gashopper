// lib/data/network/dio_helper.dart
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'YOUR_BASE_URL',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}

// lib/data/models/auth_response.dart
class AuthResponse {
  final String message;
  final String? token;
  final bool success;

  AuthResponse({
    required this.message,
    this.token,
    required this.success,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'] ?? '',
      token: json['token'],
      success: json['success'] ?? false,
    );
  }
}
