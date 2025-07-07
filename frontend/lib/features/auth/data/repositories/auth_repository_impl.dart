import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freeze/core/error/failures.dart';
import 'package:freeze/features/auth/domain/entities/user.dart';
import 'package:freeze/features/auth/domain/repositories/auth_repository.dart';
import 'package:freeze/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:freeze/features/auth/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  @override
  Future<Either<Failure, String>> getAuthUrl() async {
    try {
      final authUrl = await remoteDataSource.getAuthUrl();
      return Right(authUrl);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      await _saveUserData(userModel);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> handleAuthCallback(String code) async {
    try {
      final userModel = await remoteDataSource.handleAuthCallback(code);
      await _saveUserData(userModel);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await _clearAuth();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await secureStorage.read(key: _tokenKey);
      return Right(token != null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<void> _saveUserData(UserModel user) async {
    final userData =
        'id:${user.id},githubId:${user.githubId},username:${user.username},email:${user.email},avatarUrl:${user.avatarUrl},createdAt:${user.createdAt.toIso8601String()},updatedAt:${user.updatedAt.toIso8601String()}';
    await secureStorage.write(key: _userKey, value: userData);
  }

  Future<void> _clearAuth() async {
    await secureStorage.delete(key: _tokenKey);
    await secureStorage.delete(key: _userKey);
  }
}
