import 'package:dartz/dartz.dart';
import 'package:freeze/core/error/failures.dart';
import 'package:freeze/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> getAuthUrl();
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> handleAuthCallback(String code);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isAuthenticated();
}
