import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token if needed
        // options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(url, queryParameters: queryParameters);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio.post(url, data: data);
  }
}