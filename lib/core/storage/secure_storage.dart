import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper around [SharedPreferences] for token management.
///
/// Uses SharedPreferences instead of FlutterSecureStorage for better
/// emulator compatibility. Tokens are stored as plain strings.
class SecureStorage {
  SecureStorage._(this._prefs);

  final SharedPreferences _prefs;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  /// Stream controller for token cleared events.
  /// Listeners (like AuthNotifier) can use this to react to token clearance.
  final _tokenClearedController = StreamController<void>.broadcast();

  /// Stream that emits when tokens are cleared.
  Stream<void> get onTokenCleared => _tokenClearedController.stream;

  /// Singleton instance - initialized once and reused.
  static SecureStorage? _instance;

  /// Gets or creates the singleton instance.
  static Future<SecureStorage> getInstance() async {
    if (_instance == null) {
      final prefs = await SharedPreferences.getInstance();
      _instance = SecureStorage._(prefs);
      debugPrint('SecureStorage: initialized singleton');
    }
    return _instance!;
  }

  /// Saves the access token.
  Future<void> saveAccessToken(String token) async {
    await _prefs.setString(_accessTokenKey, token);
    debugPrint('SecureStorage: saved access_token');
  }

  /// Retrieves the access token.
  Future<String?> getAccessToken() async {
    final token = _prefs.getString(_accessTokenKey);
    debugPrint('SecureStorage: getAccessToken - exists: ${token != null}');
    return token;
  }

  /// Saves the refresh token.
  Future<void> saveRefreshToken(String token) async {
    await _prefs.setString(_refreshTokenKey, token);
    debugPrint('SecureStorage: saved refresh_token');
  }

  /// Retrieves the refresh token.
  Future<String?> getRefreshToken() async {
    final token = _prefs.getString(_refreshTokenKey);
    debugPrint('SecureStorage: getRefreshToken - exists: ${token != null}');
    return token;
  }

  /// Clears both access and refresh tokens.
  Future<void> clearTokens() async {
    await Future.wait([
      _prefs.remove(_accessTokenKey),
      _prefs.remove(_refreshTokenKey),
    ]);
    debugPrint('SecureStorage: cleared tokens');
    // Notify listeners that tokens were cleared
    _tokenClearedController.add(null);
  }

  /// Disposes the stream controller.
  void dispose() {
    _tokenClearedController.close();
  }
}

/// Riverpod provider for [SecureStorage].
///
/// Returns the singleton instance. SecureStorage is initialized in main()
/// before the app starts, so this provider is always ready.
final secureStorageProvider = Provider<SecureStorage>((ref) {
  final instance = SecureStorage._instance;
  if (instance == null) {
    throw StateError('SecureStorage not initialized. Call SecureStorage.getInstance() in main().');
  }
  return instance;
});
