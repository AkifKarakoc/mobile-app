import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/env/env.dart';
import 'app/env/env_provider.dart';
import 'app/app.dart';
import 'core/fcm/fcm_manager.dart';
import 'l10n/easy_localization_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalizationSetup.initialize();

  final env = await Env.load();

  // Initialize Firebase & FCM (non-blocking, fail-safe)
  try {
    final container = ProviderContainer(overrides: [envProvider.overrideWithValue(env)]);
    await container.read(fcmManagerProvider).initialize().timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            debugPrint('FCM initialization timed out, continuing without FCM');
          },
        );
    container.dispose();
  } catch (e) {
    debugPrint('FCM initialization failed: $e, continuing without FCM');
  }

  runApp(
    ProviderScope(
      overrides: [envProvider.overrideWithValue(env)],
      child: EasyLocalization(
        supportedLocales: const [Locale('tr'), Locale('en'), Locale('de')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('tr'),
        saveLocale: false,
        child: const App(),
      ),
    ),
  );
}
