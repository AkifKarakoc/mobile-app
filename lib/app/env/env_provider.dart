import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'env.dart';

/// Riverpod provider for Env singleton
/// Should be overridden in main() with the loaded Env instance
final envProvider = Provider<Env>((ref) {
  throw UnimplementedError(
    'envProvider must be overridden in ProviderScope with the loaded Env instance. '
    'Call Env.load() in main() and pass it to ProviderScope overrides.',
  );
});
