import 'package:easy_localization/easy_localization.dart';

/// Shared HTTP headers for public open-licensed image CDNs (e.g. Wikimedia Commons)
/// that throttle or reject bare default HTTP client user-agents.
const Map<String, String> kNetworkImageHeaders = {
  'User-Agent': 'TouDoApp/1.0 (https://github.com/AkifKarakoc/toudo-mobile)',
};

const Map<String, String> _englishCategoryKeys = {
  'LANDMARK': 'places.categories.landmark',
  'MUSEUM': 'places.categories.museum',
  'RESTAURANT': 'places.categories.restaurant',
  'CAFE': 'places.categories.cafe',
  'PARK': 'places.categories.park',
  'BEACH': 'places.categories.beach',
  'HISTORICAL': 'places.categories.historical',
  'HISTORIC': 'places.categories.historical',
  'NATURE': 'places.categories.nature',
  'SHOPPING': 'places.categories.shopping',
  'RELIGIOUS': 'places.categories.religious',
  'ENTERTAINMENT': 'places.categories.entertainment',
  'OTHER': 'places.categories.other',
};

const Map<String, String> _turkishCategoryLabels = {
  'tarihi_yapi': 'Tarihi Yapı',
  'müze': 'Müze',
  'muze': 'Müze',
  'sanayi_mirası': 'Sanayi Mirası',
  'sanayi_mirasi': 'Sanayi Mirası',
  'okul': 'Okul',
  'cami': 'Cami',
  'hamam': 'Hamam',
  'kale': 'Kale',
  'tarihi_otel': 'Tarihi Otel',
  'antik_alan': 'Antik Alan',
  'konak': 'Konak',
  'kilise': 'Kilise',
  'sinagog': 'Sinagog',
  'türbe': 'Türbe',
  'turbe': 'Türbe',
  'kütüphane': 'Kütüphane',
  'kutuphane': 'Kütüphane',
  'kıraathane': 'Kıraathane',
  'kiraathane': 'Kıraathane',
  'tren_garı': 'Tren Garı',
  'tren_gari': 'Tren Garı',
  'sahil_şeridi': 'Sahil Şeridi',
  'sahil_seridi': 'Sahil Şeridi',
  'çarşı': 'Çarşı',
  'carsi': 'Çarşı',
  'kule': 'Kule',
  'restoran': 'Restoran',
  'kafe': 'Kafe',
  'plaj': 'Plaj',
};

/// Formats raw English or Turkish backend place categories for display.
String formatPlaceCategoryLabel(String? category) {
  if (category == null || category.trim().isEmpty) {
    return 'places.categories.other'.tr();
  }

  final trimmed = category.trim();
  final englishKey = _englishCategoryKeys[trimmed.toUpperCase()];
  if (englishKey != null) {
    return englishKey.tr();
  }

  final turkishLabel = _turkishCategoryLabels[trimmed.toLowerCase()];
  if (turkishLabel != null) {
    return turkishLabel;
  }

  final words = trimmed
      .split(RegExp(r'[_\s]+'))
      .where((word) => word.isNotEmpty)
      .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
      .join(' ');
  return words.isEmpty ? 'places.categories.other'.tr() : words;
}
