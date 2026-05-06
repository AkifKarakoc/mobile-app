import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/core/storage/secure_storage.dart';
import 'package:mobile/features/auth/data/auth_api.dart';
import 'package:mobile/features/auth/data/dto/login_request.dart';
import 'package:mobile/features/auth/data/dto/login_response.dart';
import 'package:mobile/features/auth/data/dto/register_request.dart';
import 'package:mobile/features/auth/data/dto/register_response.dart';
import 'package:mobile/features/auth/data/dto/refresh_request.dart';

/// Abstract repository interface for authentication operations.
abstract class AuthRepository {
  /// Register a new user with email and password.
  ///
  /// Saves access and refresh tokens to secure storage on success.
  /// Throws [ApiException] on failure (validation, network, server error).
  Future<RegisterResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    String? preferredLanguage,
    String? ageGroup,
  });

  /// Login with email and password.
  ///
  /// Saves access and refresh tokens to secure storage on success.
  /// Throws [ApiException] on failure (401, network, server error).
  Future<LoginResponse> login({
    required String email,
    required String password,
  });

  /// Refresh access token using refresh token.
  ///
  /// Updates both tokens in secure storage on success.
  /// Throws [ApiException] on failure.
  Future<void> refreshTokens();

  /// Logout the current user.
  ///
  /// Calls the backend logout endpoint and clears tokens from secure storage.
  /// If the API call fails, tokens are still cleared (best-effort).
  /// Never throws; any errors are logged internally.
  Future<void> logout();
}

/// Concrete implementation of [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthApi api,
    required SecureStorage secureStorage,
  }) : _api = api,
       _secureStorage = secureStorage;

  final AuthApi _api;
  final SecureStorage _secureStorage;

  @override
  Future<RegisterResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    String? preferredLanguage,
    String? ageGroup,
  }) async {
    try {
      final request = RegisterRequest(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        preferredLanguage: preferredLanguage,
        ageGroup: ageGroup,
      );

      final response = await _api.register(request);

      // Save tokens to secure storage
      await Future.wait([
        _secureStorage.saveAccessToken(response.accessToken),
        _secureStorage.saveRefreshToken(response.refreshToken),
      ]);

      return response;
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _api.login(request);

      // Save tokens to secure storage
      await Future.wait([
        _secureStorage.saveAccessToken(response.accessToken),
        _secureStorage.saveRefreshToken(response.refreshToken),
      ]);

      return response;
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<void> refreshTokens() async {
    try {
      final currentRefreshToken = await _secureStorage.getRefreshToken();
      if (currentRefreshToken == null) {
        throw ApiException.unauthorized('No refresh token available');
      }

      final request = RefreshRequest(refreshToken: currentRefreshToken);
      final response = await _api.refresh(request);

      // Update tokens in secure storage
      await Future.wait([
        _secureStorage.saveAccessToken(response.accessToken),
        _secureStorage.saveRefreshToken(response.refreshToken),
      ]);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Attempt to notify backend (with timeout to prevent hanging)
      await _api.logout().timeout(const Duration(seconds: 5));
    } catch (e) {
      // Ignore errors: best-effort logout
    }

    try {
      // Always attempt to clear tokens from secure storage.
      await _secureStorage.clearTokens();
    } catch (e) {
      // Ignore storage cleanup errors as well; logout must remain best-effort.
    }
  }
}

/// Riverpod provider for [AuthRepository].
///
/// Creates an [AuthRepositoryImpl] using the configured [Dio] client
/// and [SecureStorage] instance.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioClientProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  final authApi = AuthApi(dio);
  return AuthRepositoryImpl(api: authApi, secureStorage: secureStorage);
});
