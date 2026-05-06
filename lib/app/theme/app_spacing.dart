/// Smart Tourism Guide boşluk token'ları
/// Padding, margin, gap ve corner radius değerleri
abstract final class AppSpacing {
  // Spacing scale
  /// Çok küçük spacing — 4px (ikon arası, yoğun layout)
  static const double xs = 4.0;

  /// Küçük spacing — 8px (button padding, small gaps)
  static const double sm = 8.0;

  /// Orta spacing — 16px (standart padding, card içi)
  static const double md = 16.0;

  /// Büyük spacing — 24px (section gap, bottom sheet padding)
  static const double lg = 24.0;

  /// Çok büyük spacing — 32px (major layout gaps)
  static const double xl = 32.0;

  /// Ekstra çok büyük spacing — 48px (screen padding, full height gaps)
  static const double xxl = 48.0;

  // Border radius
  /// Sıkı radius — 8px (small button, tiny card)
  static const double radiusSm = 8.0;

  /// Orta radius — 12px (standart buton, input field)
  static const double radiusMd = 12.0;

  /// Büyük radius — 16px (card, modal bottom sheet)
  static const double radiusLg = 16.0;

  /// Çok büyük radius — 24px (dialog, large panel)
  static const double radiusXl = 24.0;

  /// Tam dairesel — 100px (avatar, circular button)
  static const double radiusCircle = 100.0;

  // Elevation / Shadow
  /// Kullanmayan elevation value
  static const double elevationNone = 0.0;

  /// Düşük elevation (hover state'ler)
  static const double elevationSm = 2.0;

  /// Orta elevation (expanded bottom sheet, modal)
  static const double elevationMd = 4.0;

  /// Yüksek elevation (floating action button, tooltip)
  static const double elevationLg = 8.0;

  /// Çok yüksek elevation (dialog üstü)
  static const double elevationXl = 12.0;

  // Icon size
  /// Küçük ikon (trailing, prefix)
  static const double iconSmall = 16.0;

  /// Orta ikon (button ikon, list item)
  static const double iconMedium = 24.0;

  /// Büyük ikon (app bar action)
  static const double iconLarge = 32.0;

  // Line height / text spacing
  /// Sıkı satır yüksekliği
  static const double lineHeightTight = 1.0;

  /// Orta satır yüksekliği
  static const double lineHeightNormal = 1.5;

  /// Gevşek satır yüksekliği
  static const double lineHeightLoose = 1.75;
}
