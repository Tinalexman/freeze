import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  static Dio _createDio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8080/api',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: <String, String>{'Content-Type': 'application/json'},
      ),
    );

    // Add interceptors for logging and error handling
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (Object obj) => debugPrint(obj.toString()),
      ),
    );

    return dio;
  }

  // Set auth token for authenticated requests
  static void setAuthToken(String token) {
    instance.options.headers['Authorization'] = 'Bearer $token';
  }

  // Clear auth token
  static void clearAuthToken() {
    instance.options.headers.remove('Authorization');
  }
}
