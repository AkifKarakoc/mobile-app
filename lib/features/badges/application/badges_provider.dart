import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/badges/data/badges_repository.dart';
import 'package:mobile/features/badges/data/dto/badge_response.dart';

final allBadgesProvider = FutureProvider<List<BadgeResponse>>((ref) async {
  final repository = ref.watch(badgesRepositoryProvider);
  return repository.getAllBadges();
});

final myBadgesProvider = FutureProvider<List<UserBadgeResponse>>((ref) async {
  final repository = ref.watch(badgesRepositoryProvider);
  return repository.getMyBadges();
});
