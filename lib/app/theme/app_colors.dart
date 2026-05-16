import 'package:flutter/material.dart';

/// Smart Tourism Guide renk paleti
/// Light ve dark tema renkleri — Travel App (Sky Blue + Ocean)
abstract final class AppColors {
  // Light tema — Primary
  /// Sky Blue — Gökyüzü, deniz, güven hissi (Travel App paleti)
  static const Color primaryLight = Color(0xFF0369A1);

  /// Sky Blue koyu varyasyonu
  static const Color primaryDarkLight = Color(0xFF075985);

  // Light tema — Secondary
  /// Ocean Blue — Deniz mavisi, macera hissi
  static const Color secondaryLight = Color(0xFF0EA5E9);

  /// Ocean Blue koyu varyasyonu
  static const Color secondaryDarkLight = Color(0xFF0284C7);

  // Light tema — Surface & Background
  /// Hafif gri arka plan
  static const Color backgroundLight = Color(0xFFFAFAFA);

  /// Kart ve panel arka planı
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// Hafif gri kenarlıklar
  static const Color surfaceVariantLight = Color(0xFFF3F4F6);

  // Light tema — Text
  /// Birincil metin rengi
  static const Color textPrimaryLight = Color(0xFF111827);

  /// İkincil metin (hints, labels)
  static const Color textSecondaryLight = Color(0xFF6B7280);

  /// Tercier metin (çok soluk)
  static const Color textTertiary = Color(0xFF9CA3AF);

  // Light tema — State
  /// Başarı/onay rengi
  static const Color successLight = Color(0xFF10B981);

  /// Uyarı rengi — Amber (güneş/gündoğumu)
  static const Color warningLight = Color(0xFFF59E0B);

  /// Hata/kırmızı
  static const Color errorLight = Color(0xFFDC2626);

  /// Bilgi/mavi
  static const Color infoLight = Color(0xFF3B82F6);

  /// Divider ve çizgiler
  static const Color dividerLight = Color(0xFFE5E7EB);

  // Dark tema — Primary
  /// Sky Blue dark versiyonu (daha açık)
  static const Color primaryDark = Color(0xFF38BDF8);

  /// Sky Blue daha açık varyasyonu (dark'ta)
  static const Color primaryVariantDark = Color(0xFF7DD3FC);

  // Dark tema — Secondary
  /// Ocean Blue dark versiyonu
  static const Color secondaryDark = Color(0xFF7DD3FC);

  // Dark tema — Surface & Background
  /// Dark arka plan (very dark)
  static const Color backgroundDark = Color(0xFF0F172A);

  /// Dark tema surface (cards, panels)
  static const Color surfaceDark = Color(0xFF1E293B);

  /// Dark tema surface variant
  static const Color surfaceVariantDark = Color(0xFF334155);

  // Dark tema — Text
  /// Birincil metin dark
  static const Color textPrimaryDark = Color(0xFFF8FAFC);

  /// İkincil metin dark
  static const Color textSecondaryDark = Color(0xFFCBD5E1);

  // Dark tema — State
  /// Başarı dark
  static const Color successDark = Color(0xFF34D399);

  /// Uyarı dark
  static const Color warningDark = Color(0xFFFCD34D);

  /// Hata dark
  static const Color errorDark = Color(0xFFF87171);

  /// Bilgi dark
  static const Color infoDark = Color(0xFF60A5FA);

  /// Divider dark
  static const Color dividerDark = Color(0xFF475569);

  // Transparency variants (Light)
  /// 50% opaklık
  static const Color textPrimaryLight50 = Color(0x80111827);

  /// 30% opaklık
  static const Color textPrimaryLight30 = Color(0x4D111827);

  // Transparency variants (Dark)
  /// 50% opaklık dark
  static const Color textPrimaryDark50 = Color(0x80F8FAFC);
}
