import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/storage/secure_storage.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/presentation/google_sign_in_helper.dart';
import 'package:mobile/features/routes/application/routes_provider.dart';
import 'package:mobile/features/routes/application/user_routes_provider.dart';
import 'package:mobile/features/quests/application/quests_provider.dart';
import 'package:mobile/features/quests/application/user_quests_provider.dart';
import 'package:mobile/features/user/application/profile_provider.dart';

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

    // Listen for token cleared events (e.g., from refresh interceptor)
    ref.onDispose(() {
      // Stream subscription is handled below
    });

    // Subscribe to token cleared events
    _secureStorage.onTokenCleared.listen((_) {
      debugPrint('AuthNotifier: token cleared event received, setting state to unauthenticated');
      state = const AsyncValue.data(false);
    });

    // On app startup, check if there's a valid token in storage
    return _restoreSession();
  }

  /// Restores session from stored tokens.
  ///
  /// Returns true if access token exists and is not expired, false otherwise.
  Future<bool> _restoreSession() async {
    try {
      final accessToken = await _secureStorage.getAccessToken();
      debugPrint('AuthNotifier: restoreSession - accessToken exists: ${accessToken != null}');
      
      if (accessToken == null || accessToken.isEmpty) {
        return false;
      }

      // Check if token is expired
      if (!_isTokenValid(accessToken)) {
        debugPrint('AuthNotifier: restoreSession - token is expired, clearing tokens');
        await _secureStorage.clearTokens();
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('AuthNotifier: restoreSession failed: $e');
      return false;
    }
  }

  /// Checks if a JWT token is still valid (not expired).
  ///
  /// Decodes the JWT payload and checks the 'exp' claim.
  bool _isTokenValid(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final map = jsonDecode(decoded) as Map<String, dynamic>;

      final exp = map['exp'] as int?;
      if (exp == null) return false;

      final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      final isValid = expiry.isAfter(DateTime.now());
      
      debugPrint('AuthNotifier: token expiry: $expiry, isValid: $isValid');
      return isValid;
    } catch (e) {
      debugPrint('AuthNotifier: token validation failed: $e');
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
      _clearUserCache();
    } catch (e) {
      // Reset to data(false) so the form remains visible
      state = const AsyncValue.data(false);
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
    String? phoneCountryCode,
    String? phoneNumber,
    DateTime? birthDate,
  }) async {
    state = const AsyncLoading();

    try {
      await _authRepository.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneCountryCode: phoneCountryCode,
        phoneNumber: phoneNumber,
        birthDate: birthDate,
      );

      // After successful registration, state is authenticated
      state = const AsyncValue.data(true);
      _clearUserCache();
    } catch (e) {
      // Reset to data(false) so the form remains visible
      state = const AsyncValue.data(false);
      rethrow;
    }
  }

  /// Login with Google OAuth.
  ///
  /// On success, tokens are stored and state becomes authenticated.
  /// On failure, state becomes error and exception is rethrown for UI to handle.
  Future<void> loginWithGoogle({required String idToken}) async {
    state = const AsyncLoading();

    try {
      await _authRepository.loginWithGoogle(idToken: idToken);

      // After successful login, state is authenticated
      state = const AsyncValue.data(true);
      _clearUserCache();
    } catch (e) {
      // Reset to data(false) so the form remains visible
      state = const AsyncValue.data(false);
      rethrow;
    }
  }

  /// Clears all user-specific cached providers to prevent stale data.
  void _clearUserCache() {
    ref.invalidate(profileProvider);
    ref.invalidate(routesProvider);
    ref.invalidate(routeDetailProvider);
    ref.invalidate(userRoutesProvider);
    ref.invalidate(questsProvider);
    ref.invalidate(questDetailProvider);
    ref.invalidate(userQuestsProvider);
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
      // Clear Google Sign-In session on device
      try {
        await GoogleSignInHelper().signOut().timeout(const Duration(seconds: 5));
      } catch (e) {
        debugPrint('AuthNotifier: Google sign-out failed: $e');
      }

      // Clear user-specific cache to prevent stale data on next login
      _clearUserCache();
      
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
