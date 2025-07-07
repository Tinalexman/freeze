import 'package:dartz/dartz.dart';
import 'package:freeze/core/error/failures.dart';
import 'package:freeze/features/auth/domain/repositories/auth_repository.dart';

class GetAuthUrl {
  final AuthRepository repository;

  GetAuthUrl(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getAuthUrl();
  }
}
