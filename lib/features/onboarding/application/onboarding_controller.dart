import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/onboarding_storage.dart';

/// Onboarding controller — manages page navigation and completion
final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, int>((ref) {
      final storageAsync = ref.watch(onboardingStorageProvider);
      return OnboardingController(ref, storageAsync);
    });

class OnboardingController extends StateNotifier<int> {
  final Ref ref;
  final AsyncValue<OnboardingStorage> storageAsync;

  // Total pages in onboarding (0-indexed, so 3 pages: 0, 1, 2)
  static const int totalPages = 3;

  OnboardingController(this.ref, this.storageAsync) : super(0);

  /// Sync the controller with a page selected by user swiping.
  void setPage(int index) {
    if (index >= 0 && index < totalPages) {
      state = index;
    }
  }

  /// Move to the next page
  /// If on the last page, this is a no-op; use finish() instead
  void goToNextPage() {
    if (state < totalPages - 1) {
      state = state + 1;
    }
  }

  /// Move to the previous page
  /// If on the first page, this is a no-op
  void goToPreviousPage() {
    if (state > 0) {
      state = state - 1;
    }
  }

  /// Skip onboarding — mark as completed and trigger navigation
  /// The actual navigation (context.go) is handled by the UI
  Future<void> skip() async {
    await _markCompleted();
  }

  /// Finish onboarding (called from last page) — mark as completed
  /// The actual navigation (context.go) is handled by the UI
  Future<void> finish() async {
    await _markCompleted();
  }

  /// Mark onboarding as completed in storage
  Future<void> _markCompleted() async {
    final storage = storageAsync.maybeWhen(data: (s) => s, orElse: () => null);

    if (storage != null) {
      await storage.markCompleted();
      // Invalidate the completion provider to refresh other listeners
      ref.invalidate(isOnboardingCompletedProvider);
    }
  }
}
