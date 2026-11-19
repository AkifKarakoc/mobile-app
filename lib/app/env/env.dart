import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration abstract class.
/// Subclasses (EnvDev, EnvProd) implement environment-specific values.
abstract class Env {
  /// API base URL (backend REST endpoints)
  String get apiBaseUrl;

  /// Chatbot service base URL
  String get chatbotBaseUrl;

  /// Google Maps API key
  String get googleMapsApiKey;

  /// Google OAuth Client ID (for Google Sign-In)
  String get googleClientId;

  /// Environment name (dev, prod)
  String get name;

  /// Load environment based on --dart-define=ENV=dev|prod.
  /// Defaults to 'dev' if ENV is not specified. Missing .env files fall back
  /// gracefully to local defaults or --dart-define overrides.
  static Future<Env> load() async {
    const envName = String.fromEnvironment('ENV', defaultValue: 'dev');
    final envFileName = '.env.$envName';

    try {
      await dotenv.load(fileName: envFileName);
    } catch (_) {
      dotenv.testLoad(fileInput: '');
    }

    if (envName == 'prod') {
      return EnvProd();
    }
    return EnvDev();
  }
}

String? _envValue(String key, String dartDefineValue) {
  if (dartDefineValue.isNotEmpty) {
    return dartDefineValue;
  }
  if (!dotenv.isInitialized) {
    return null;
  }
  final value = dotenv.env[key];
  return (value == null || value.trim().isEmpty) ? null : value.trim();
}

String _localHost() {
  if (!kIsWeb && Platform.isAndroid) {
    return '10.0.2.2';
  }
  return 'localhost';
}

/// Development environment configuration
class EnvDev implements Env {
  static const String _defineApiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String _defineChatbotBaseUrl = String.fromEnvironment('CHATBOT_BASE_URL');
  static const String _defineMapsKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');
  static const String _defineGoogleClientId = String.fromEnvironment('GOOGLE_CLIENT_ID');

  @override
  String get apiBaseUrl =>
      _envValue('API_BASE_URL', _defineApiBaseUrl) ??
      'http://${_localHost()}:8080/api/v1';

  @override
  String get chatbotBaseUrl =>
      _envValue('CHATBOT_BASE_URL', _defineChatbotBaseUrl) ??
      'http://${_localHost()}:8000';

  @override
  String get googleMapsApiKey =>
      _envValue('GOOGLE_MAPS_API_KEY', _defineMapsKey) ?? '';

  @override
  String get googleClientId =>
      _envValue('GOOGLE_CLIENT_ID', _defineGoogleClientId) ?? '';

  @override
  String get name => 'dev';
}

/// Production environment configuration
class EnvProd implements Env {
  static const String _defineApiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String _defineChatbotBaseUrl = String.fromEnvironment('CHATBOT_BASE_URL');
  static const String _defineMapsKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');
  static const String _defineGoogleClientId = String.fromEnvironment('GOOGLE_CLIENT_ID');

  @override
  String get apiBaseUrl =>
      _envValue('API_BASE_URL', _defineApiBaseUrl) ??
      'https://api.tourguide.example/api/v1';

  @override
  String get chatbotBaseUrl =>
      _envValue('CHATBOT_BASE_URL', _defineChatbotBaseUrl) ??
      'https://chatbot.tourguide.example';

  @override
  String get googleMapsApiKey =>
      _envValue('GOOGLE_MAPS_API_KEY', _defineMapsKey) ?? '';

  @override
  String get googleClientId =>
      _envValue('GOOGLE_CLIENT_ID', _defineGoogleClientId) ?? '';

  @override
  String get name => 'prod';
}
