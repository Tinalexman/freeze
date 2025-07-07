import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freeze/core/error/failures.dart';
import 'package:freeze/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:freeze/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:freeze/features/auth/domain/entities/user.dart';
import 'package:freeze/features/auth/domain/repositories/auth_repository.dart';
import 'package:freeze/features/auth/domain/usecases/get_auth_url.dart';

// Providers
final Provider<AuthRemoteDataSource> authRemoteDataSourceProvider =
    Provider<AuthRemoteDataSource>((Ref ref) {
      return AuthRemoteDataSourceImpl();
    });

final Provider<FlutterSecureStorage> secureStorageProvider =
    Provider<FlutterSecureStorage>((Ref ref) {
      return const FlutterSecureStorage();
    });

final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>((Ref ref) {
      final AuthRemoteDataSource remoteDataSource = ref.watch(
        authRemoteDataSourceProvider,
      );
      final FlutterSecureStorage secureStorage = ref.watch(
        secureStorageProvider,
      );
      return AuthRepositoryImpl(
        remoteDataSource: remoteDataSource,
        secureStorage: secureStorage,
      );
    });

final Provider<GetAuthUrl> getAuthUrlProvider = Provider<GetAuthUrl>((Ref ref) {
  final AuthRepository repository = ref.watch(authRepositoryProvider);
  return GetAuthUrl(repository);
});

// Auth State
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final String username;
  final String email;
  final String avatarUrl;

  const AuthAuthenticated({
    required this.username,
    required this.email,
    required this.avatarUrl,
  });
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthInitial()) {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    final Either<Failure, bool> isAuthResult = await _authRepository
        .isAuthenticated();
    isAuthResult.fold((Failure failure) => state = AuthError(failure.message), (
      bool isAuthenticated,
    ) {
      if (isAuthenticated) {
        _getCurrentUser();
      } else {
        state = const AuthUnauthenticated();
      }
    });
  }

  Future<void> _getCurrentUser() async {
    state = const AuthLoading();
    final Either<Failure, User> result = await _authRepository.getCurrentUser();
    result.fold(
      (Failure failure) => state = AuthError(failure.message),
      (User user) => state = AuthAuthenticated(
        username: user.username,
        email: user.email,
        avatarUrl: user.avatarUrl,
      ),
    );
  }

  Future<void> login() async {
    state = const AuthLoading();
    final Either<Failure, String> result = await _authRepository.getAuthUrl();
    result.fold((Failure failure) => state = AuthError(failure.message), (
      String authUrl,
    ) {
      // Handle auth URL (e.g., launch browser)
      state = const AuthUnauthenticated();
    });
  }

  Future<void> handleAuthCallback(String code) async {
    state = const AuthLoading();
    final Either<Failure, User> result = await _authRepository
        .handleAuthCallback(code);
    result.fold(
      (Failure failure) => state = AuthError(failure.message),
      (User user) => state = AuthAuthenticated(
        username: user.username,
        email: user.email,
        avatarUrl: user.avatarUrl,
      ),
    );
  }

  Future<void> logout() async {
    state = const AuthLoading();
    final Either<Failure, void> result = await _authRepository.logout();
    result.fold(
      (Failure failure) => state = AuthError(failure.message),
      (void _) => state = const AuthUnauthenticated(),
    );
  }
}

final StateNotifierProvider<AuthNotifier, AuthState> authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((Ref ref) {
      final AuthRepository repository = ref.watch(authRepositoryProvider);
      return AuthNotifier(repository);
    });
