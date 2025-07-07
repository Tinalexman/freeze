import 'package:dio/dio.dart';
import 'package:freeze/core/network/dio_client.dart';
import 'package:freeze/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> getAuthUrl();
  Future<UserModel> getCurrentUser();
  Future<UserModel> handleAuthCallback(String code);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl() : _dio = DioClient.instance;

  @override
  Future<String> getAuthUrl() async {
    try {
      final Response<dynamic> response = await _dio.get('/auth/login');
      return response.data['auth_url'] as String;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final Response<dynamic> response = await _dio.get('/auth/me');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<UserModel> handleAuthCallback(String code) async {
    try {
      final Response<dynamic> response = await _dio.get(
        '/auth/callback',
        queryParameters: <String, String>{'code': code},
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
          'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.badResponse:
        final int? statusCode = e.response?.statusCode;
        final String message =
            e.response?.data?['message'] ?? 'Server error occurred';
        return Exception('HTTP $statusCode: $message');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        return Exception('No internet connection');
      default:
        return Exception('An unexpected error occurred');
    }
  }
}
