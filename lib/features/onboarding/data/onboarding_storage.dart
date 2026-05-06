import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// OnboardingStorage — SharedPreferences wrapper for onboarding completion state
class OnboardingStorage {
  static const String _key = 'onboarding_completed';

  final SharedPreferences _prefs;

  const OnboardingStorage(this._prefs);

  /// Check if onboarding has been completed
  Future<bool> isOnboardingCompleted() async {
    return _prefs.getBool(_key) ?? false;
  }

  /// Mark onboarding as completed
  Future<void> markCompleted() async {
    await _prefs.setBool(_key, true);
  }

  /// Reset onboarding state (for development/testing)
  Future<void> reset() async {
    await _prefs.remove(_key);
  }
}

/// Riverpod provider for OnboardingStorage
/// Using keepAlive to maintain state across navigation
final onboardingStorageProvider = FutureProvider<OnboardingStorage>((
  ref,
) async {
  final prefs = await SharedPreferences.getInstance();
  return OnboardingStorage(prefs);
});

/// Provider to check if onboarding is completed
final isOnboardingCompletedProvider = FutureProvider<bool>((ref) async {
  final storage = await ref.watch(onboardingStorageProvider.future);
  return storage.isOnboardingCompleted();
});
