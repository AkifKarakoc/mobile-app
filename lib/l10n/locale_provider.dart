import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Current locale state for screens that need to react outside
/// EasyLocalization's BuildContext-driven API.
final currentLocaleProvider = StateProvider<Locale>((ref) {
  return AppLocales.defaultLocale;
});

/// Supported locales for the application.
abstract final class AppLocales {
  static const List<Locale> supportedLocales = [
    Locale('tr'),
    Locale('en'),
    Locale('de'),
  ];

  static const Locale defaultLocale = Locale('tr');
  static const Locale fallbackLocale = Locale('en');

  static bool isSupported(Locale locale) {
    return supportedLocales.contains(locale);
  }

  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'tr':
        return 'Turkce';
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      default:
        return locale.languageCode;
    }
  }
}
