import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/storage/secure_storage.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';

/// Notifier for authentication state management.
///
/// Manages user authentication state, token persistence, and login/register/logout flows.
/// State is [AsyncValue<bool>] where true indicates authenticated, false indicates unauthenticated.
class AuthNotifier extends AsyncNotifier<bool> {
  late final AuthRepository _authRepository;
  late final SecureStorage _secureStorage;

  @override
  FutureOr<bool> build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _secureStorage = ref.watch(secureStorageProvider);

    // On app startup, check if there's a valid token in secure storage
    return _restoreSession();
  }

  /// Restores session from stored tokens.
  ///
  /// Returns true if access token exists, false otherwise.
  /// In a real scenario, you might decode the JWT to check expiry.
  Future<bool> _restoreSession() async {
    try {
      final accessToken = await _secureStorage.getAccessToken();
      return accessToken != null;
    } catch (e) {
      // Log error but don't fail
      return false;
    }
  }

  /// Login with email and password.
  ///
  /// On success, tokens are stored and state becomes authenticated.
  /// On failure, state becomes error and exception is rethrown for UI to handle.
  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    try {
      await _authRepository.login(email: email, password: password);

      // After successful login, state is authenticated
      state = const AsyncValue.data(true);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  /// Register a new user with email and password.
  ///
  /// On success, tokens are stored and state becomes authenticated.
  /// On failure, state becomes error and exception is rethrown for UI to handle.
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = const AsyncLoading();

    try {
      await _authRepository.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      // After successful registration, state is authenticated
      state = const AsyncValue.data(true);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  /// Logout the current user.
  ///
  /// Clears tokens and sets state to unauthenticated.
  /// Never throws; errors are logged internally in the repository.
  Future<void> logout() async {
    try {
      await _authRepository.logout().timeout(const Duration(seconds: 10));
    } catch (e) {
      // Logout is best-effort: callers should end in an unauthenticated state.
    } finally {
      // Always set state to unauthenticated, regardless of API outcome
      state = const AsyncValue.data(false);
    }
  }
}

/// Riverpod provider for [AuthNotifier].
///
/// Manages authentication state as [AsyncValue<bool>].
/// true = authenticated (has valid token), false = unauthenticated.
final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, bool>(
  AuthNotifier.new,
);

/// Convenience provider to check if user is authenticated.
///
/// Usage: `ref.watch(isAuthenticatedProvider)`
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref
      .watch(authNotifierProvider)
      .maybeWhen(
        data: (isAuthenticated) => isAuthenticated,
        orElse: () => false,
      );
});
