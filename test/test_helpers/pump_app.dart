import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/theme/app_theme.dart';

class _TestAssetLoader extends AssetLoader {
  const _TestAssetLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return SynchronousFuture<Map<String, dynamic>>(_translations);
  }

  static final Map<String, dynamic> _translations = <String, dynamic>{
    'common': {
      'ok': 'Tamam',
      'cancel': 'İptal',
      'delete': 'Sil',
      'retry': 'Tekrar Dene',
      'loading': 'Yükleniyor',
      'error_generic': 'Bir hata oluştu',
      'error_network': 'Ağ bağlantısı yok',
      'level': 'Seviye',
      'xp': 'XP',
      'xp_progress': '{current} / {required} XP',
      'more_badges': '+{count} daha',
      'empty_generic': 'İçerik bulunamadı',
    },
    'auth': {
      'login_title': 'Giriş Yap',
      'email_label': 'E-posta',
      'email_hint': 'ornek@email.com',
      'password_label': 'Şifre',
      'password_hint': 'En az 8 karakter',
      'forgot_password': 'Şifremi unuttum',
      'no_account': 'Hesabın yok mu? Kayıt ol',
      'submit_login': 'Giriş Yap',
      'validation_email_required': 'E-posta gerekli',
      'validation_email_invalid': 'Geçersiz e-posta',
      'validation_password_required': 'Şifre gerekli',
      'validation_password_min': 'Şifre en az 8 karakter olmalı',
      'error_invalid_credentials': 'E-posta veya şifre yanlış',
    },
    'onboarding': {
      'skip': 'Atla',
      'next': 'İleri',
      'previous': 'Geri',
      'finish': 'Başla',
      'page1_title': "İzmir'i Keşfedin",
      'page1_description': 'Harika mekanları keşfedin',
      'page2_title': 'Görevler ve Rotalar',
      'page2_description': 'Görevleri tamamlayın',
      'page3_title': 'Yapay Zeka Rehberin Yanında',
      'page3_description': 'Kişiselleştirilmiş öneriler alın',
    },
    'profile': {
      'title': 'Profil',
      'edit': 'Profili Düzenle',
      'favorites': 'Favorilerim',
      'routes': 'Rotalar',
      'quests': 'Görevler',
      'badges': 'Rozetlerim',
      'todos': 'Yapılacaklar',
      'logout': 'Çıkış Yap',
      'level': 'Seviye {level}',
      'xp_label': 'XP: {xp}',
    },
    'settings': {'title': 'Ayarlar'},
    'badges': {
      'gallery_title': 'Rozetler',
      'all_badges': 'Tüm Rozetler',
      'my_badges': 'Rozetlerim',
      'empty_message': 'Henüz rozet bulunmuyor',
      'earned_at': 'Kazanıldı',
      'tier_bronze': 'Bronz',
      'tier_silver': 'Gümüş',
      'tier_gold': 'Altın',
      'locked': 'Kilitli',
    },
    'routes': {
      'list_title': 'Rotalar',
      'empty_message': 'Henüz rota bulunmuyor',
      'stops': 'durak',
      'minutes': 'dk',
      'xp_reward': 'XP',
      'detail_title': 'Rota Detayı',
      'duration': 'Süre',
      'reward': 'Ödül',
      'stops_title': 'Duraklar',
      'stop_notes': 'Notlar',
    },
    'quests': {
      'list_title': 'Görevler',
      'empty_message': 'Henüz görev bulunmuyor',
      'steps': 'adım',
      'xp_reward': 'XP',
      'not_started': 'Başlanmadı',
      'in_progress': 'Devam Ediyor',
      'completed': 'Tamamlandı',
      'detail_title': 'Görev Detayı',
      'region': 'Bölge',
      'reward': 'Ödül',
      'steps_title': 'Adımlar',
      'hint': 'İpucu',
      'requires_photo': 'Fotoğraf Gerekli',
      'not_completed': 'Tamamlanmadı',
    },
    'quest_verify': {
      'title': 'Adım Doğrula',
      'camera_permission': 'Kamera izni gerekli',
      'location_permission': 'Konum izni gerekli',
      'location_accuracy': 'Konum hassasiyeti: {accuracy}m',
      'taking_photo': 'Fotoğraf çekiliyor...',
      'sending': 'Gönderiliyor...',
      'take_photo': 'Fotoğraf Çek',
      'retake_photo': 'Yeniden Çek',
      'submit': 'Gönder',
      'approved_title': 'Tebrikler!',
      'approved_message': 'Adım başarıyla doğrulandı',
      'exp_earned': 'Kazanılan XP',
      'pending_title': 'İnceleme Bekliyor',
      'pending_message': 'Fotoğrafınız moderatör onayına gönderildi',
      'rejected_title': 'Doğrulanamadı',
      'rejected_message': 'Fotoğrafınız doğrulanamadı, tekrar deneyin',
      'continue': 'Devam Et',
      'ok': 'Tamam',
      'retry': 'Tekrar Dene',
      'gps_error': 'Konum alınamadı',
      'gps_accuracy_error': 'Konum hassasiyeti yetersiz',
    },
    'image_identify': {
      'title': 'Fotoğrafla Yer Tanıma',
      'take_photo': 'Fotoğraf Çek',
      'choose_gallery': 'Galeriden Seç',
      'identify': 'Tanı',
      'identifying': 'Tanımlanıyor...',
      'result_title': 'Tanıma Sonucu',
      'place_name': 'Yer Adı',
      'confidence': 'Güven Skoru',
      'description': 'Açıklama',
      'unknown_place': 'Tanınamadı',
      'low_confidence': 'Düşük güven skoru',
      'camera_permission': 'Kamera izni gerekli',
      'gallery_permission': 'Galeri izni gerekli',
      'location_permission': 'Konum alınıyor...',
      'no_photo': 'Lütfen bir fotoğraf çekin veya seçin',
      'gps_error': 'Konum alınamadı',
    },
    'favorites': {
      'title': 'Favorilerim',
      'empty': 'Henüz favori yok',
      'empty_description': 'Favori mekan eklediğinizde burada görünecek',
      'remove': 'Kaldır',
      'remove_confirm': 'Bu favori listeden kaldırılsın mı?',
      'removed': 'Favorilerden kaldırıldı',
      'saved_at': 'Eklendi: {date}',
      'unknown_place': 'Bilinmeyen Yer',
    },
    'places': {
      'map': {
        'title': 'Yakındaki Yerler',
        'empty_title': 'Yakında yer bulunamadı',
        'empty_description': 'Mevcut konumunuzdan tekrar deneyin.',
      },
      'search': {
        'title': 'Yer Ara',
        'hint': 'Yer, müze veya mahalle ara',
        'no_results_title': 'Sonuç bulunamadı',
        'no_results_description': 'Farklı bir yer adı veya kategori deneyin.',
      },
    },
    'place_detail': {
      'title': 'Yer Detayı',
      'tab_info': 'Bilgi',
      'tab_reviews': 'Yorumlar',
      'tab_photos': 'Fotoğraflar',
      'reviews_empty_title': 'Henüz yorum yok',
      'reviews_empty_description': 'Yorumlar Sprint 3 kapsamında eklenecek.',
      'photos_empty_title': 'Fotoğraf yok',
      'photos_empty_description': 'Bu yer için henüz fotoğraf bulunmuyor.',
    },
    'chat': {
      'title': 'Sohbet',
      'type_message': 'Mesajınızı yazın...',
      'send': 'Gönder',
      'typing': 'Yazıyor...',
      'delete_session': 'Sohbeti Sil',
      'delete_confirm': 'Bu sohbet silinsin mi?',
      'send_error': 'Mesaj gönderilemedi',
      'sessions_title': 'Sohbetler',
      'new_session': 'Yeni Sohbet',
      'empty_title': 'Henüz sohbet yok',
      'empty_description': 'Yeni bir sohbet başlatarak AI rehberinizle konuşmaya başlayın',
      'start_chat': 'Sohbet Başlat',
      'deleted': 'Sohbet silindi',
      'language_tr': 'Türkçe',
      'language_en': 'İngilizce',
      'language_de': 'Almanca',
      'new_chat': 'Yeni sohbet',
      'time_ago': '{time} önce',
      'today': 'Bugün',
      'yesterday': 'Dün',
    },
    'todos': {
      'title': 'Yapılacaklar',
      'add_todo': 'Yeni Ekle',
      'empty_title': 'Henüz yapılacak yok',
      'empty_description': 'Yeni bir yapılacak ekleyerek başlayın',
      'hint': 'Ne yapacaksınız?',
      'add': 'Ekle',
      'cancel': 'İptal',
      'delete': 'Sil',
      'delete_confirm': 'Bu yapılacak silinsin mi?',
      'deleted': 'Yapılacak silindi',
      'all': 'Tümü',
      'active': 'Aktif',
      'completed': 'Tamamlanan',
      'place_link': 'Yere git',
      'error_add': 'Yapılacak eklenemedi',
      'error_update': 'Yapılacak güncellenemedi',
      'error_delete': 'Yapılacak silinemedi',
    },
    'notifications': {
      'title': 'Bildirimler',
      'empty_title': 'Bildirim yok',
      'empty_description': 'Henüz bildirim bulunmuyor',
      'mark_all_read': 'Tümünü okundu işaretle',
      'just_now': 'Az önce',
      'minutes_ago': '{count} dakika önce',
      'hours_ago': '{count} saat önce',
      'days_ago': '{count} gün önce',
    },
  };
}

/// Test helper: pumps the given widget inside the same providers/wrappers
/// the real app uses (Riverpod, EasyLocalization, MaterialApp + theme).
///
/// Always call this instead of `tester.pumpWidget(child)` directly in widget
/// tests — otherwise `.tr()` calls return the raw key, theme is missing,
/// `Navigator` context is absent, and finders silently fail with "0 widgets".
///
/// Example:
/// ```dart
/// testWidgets('login screen renders form fields', (tester) async {
///   await pumpAppWidget(tester, child: const LoginScreen());
///   expect(find.byType(AppTextField), findsNWidgets(2));
/// });
/// ```
///
/// [overrides] — optional Riverpod provider overrides for mocking.
/// [locale] — defaults to Turkish (matches app default).
Future<void> pumpAppWidget(
  WidgetTester tester, {
  required Widget child,
  List<Override> overrides = const [],
  Locale locale = const Locale('tr'),
  bool settle = true,
}) async {
  // EasyLocalization.ensureInitialized must run once before its widget is
  // mounted; idempotent across calls.
  await EasyLocalization.ensureInitialized();

  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: EasyLocalization(
        path: 'assets/translations',
        assetLoader: const _TestAssetLoader(),
        supportedLocales: const [Locale('tr'), Locale('en'), Locale('de')],
        fallbackLocale: const Locale('en'),
        startLocale: locale,
        // Disable persistence in tests
        saveLocale: false,
        child: Builder(
          builder: (ctx) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            localizationsDelegates: ctx.localizationDelegates,
            supportedLocales: ctx.supportedLocales,
            locale: ctx.locale,
            home: child,
          ),
        ),
      ),
    ),
  );

  if (settle) {
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
  } else {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Pumps the widget tree until [finder] resolves to at least one match
/// or [maxPumps] is exhausted.
Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  int maxPumps = 20,
}) async {
  for (var i = 0; i < maxPumps; i++) {
    if (finder.evaluate().isNotEmpty) {
      return;
    }
    await tester.pump(const Duration(milliseconds: 50));
  }
  expect(finder, findsWidgets);
}
