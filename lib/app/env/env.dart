import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration abstract class
/// Subclasses (EnvDev, EnvProd) implement environment-specific values
abstract class Env {
  /// API base URL (backend REST endpoints)
  String get apiBaseUrl;

  /// Chatbot service base URL (FastAPI)
  String get chatbotBaseUrl;

  /// Google Maps API key
  String get googleMapsApiKey;

  /// Google OAuth Client ID (for Google Sign-In)
  String get googleClientId;

  /// Environment name (dev, prod)
  String get name;

  /// Load environment based on --dart-define=ENV=dev|prod
  /// Defaults to 'dev' if ENV not specified
  static Future<Env> load() async {
    final envName = const String.fromEnvironment('ENV', defaultValue: 'dev');

    // Load .env.{dev|prod} file
    final envFileName = '.env.$envName';
    await dotenv.load(fileName: envFileName);

    // Return appropriate implementation
    if (envName == 'prod') {
      return EnvProd();
    } else {
      return EnvDev();
    }
  }
}

/// Development environment configuration
class EnvDev implements Env {
  @override
  String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://159.65.127.73:8080/api/v1';

  @override
  String get chatbotBaseUrl =>
      dotenv.env['CHATBOT_BASE_URL'] ?? 'http://159.65.127.73:8000';

  @override
  String get googleMapsApiKey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  @override
  String get googleClientId => dotenv.env['GOOGLE_CLIENT_ID'] ?? '';

  @override
  String get name => 'dev';
}

/// Production environment configuration
class EnvProd implements Env {
  @override
  String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.tourguide.example/api/v1';

  @override
  String get chatbotBaseUrl =>
      dotenv.env['CHATBOT_BASE_URL'] ?? 'https://chatbot.tourguide.example';

  @override
  String get googleMapsApiKey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  @override
  String get googleClientId => dotenv.env['GOOGLE_CLIENT_ID'] ?? '';

  @override
  String get name => 'prod';
}
