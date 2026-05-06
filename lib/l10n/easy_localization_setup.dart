import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'locale_provider.dart';

/// Initializes EasyLocalization for the application
/// This should be called early in main() before running the app
/// Example:
/// ```dart
/// await EasyLocalizationSetup.initialize();
/// runApp(const App());
/// ```
class EasyLocalizationSetup {
  /// Initialize EasyLocalization with default configuration
  static Future<void> initialize() async {
    await EasyLocalization.ensureInitialized();
  }

  /// Build the EasyLocalization wrapper widget
  /// This should wrap your MaterialApp/CupertinoApp
  static Widget buildWrapper({required Widget child}) {
    return EasyLocalization(
      supportedLocales: AppLocales.supportedLocales,
      path: 'assets/translations',
      fallbackLocale: AppLocales.fallbackLocale,
      startLocale: AppLocales.defaultLocale,
      saveLocale: false, // Let Riverpod manage locale state
      child: child,
    );
  }
}
