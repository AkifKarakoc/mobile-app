import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/user/data/dto/user_response.dart';
import 'package:mobile/features/user/data/dto/update_user_request.dart';
import 'package:mobile/features/user/data/user_repository.dart';

/// Profile notifier — manages user profile state
class ProfileNotifier extends AsyncNotifier<UserResponse?> {
  late final IUserRepository _repository;

  @override
  FutureOr<UserResponse?> build() {
    _repository = ref.watch(userRepositoryProvider);
    return _loadProfile();
  }

  /// Load profile from API
  Future<UserResponse?> _loadProfile() async {
    return await _repository.getProfile();
  }

  /// Reload profile
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadProfile());
  }

  /// Update profile information
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? preferredLanguage,
    String? ageGroup,
  }) async {
    final request = UpdateUserRequest(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      preferredLanguage: preferredLanguage,
      ageGroup: ageGroup,
    );

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.updateProfile(request));
  }

  /// Upload profile photo
  Future<void> uploadPhoto(File file) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.uploadPhoto(file));
  }
}

/// Profile async notifier provider — cached globally
final profileProvider = AsyncNotifierProvider<ProfileNotifier, UserResponse?>(
  ProfileNotifier.new,
);

/// Watch profile provider for UI consumption
final currentUserProvider = FutureProvider<UserResponse?>((ref) async {
  final profile = ref.watch(profileProvider);
  return profile.maybeWhen(data: (user) => user, orElse: () => null);
});
