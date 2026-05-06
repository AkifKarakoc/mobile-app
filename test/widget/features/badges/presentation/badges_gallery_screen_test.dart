import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/features/badges/data/badges_repository.dart';
import 'package:mobile/features/badges/data/dto/badge_response.dart';
import 'package:mobile/features/badges/presentation/badges_gallery_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../test_helpers/pump_app.dart';

class MockBadgesRepository extends Mock implements BadgesRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBadgesRepository badgesRepository;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    badgesRepository = MockBadgesRepository();
  });

  List<Override> overrides() {
    return [
      badgesRepositoryProvider.overrideWithValue(badgesRepository),
    ];
  }

  group('BadgesGalleryScreen', () {
    testWidgets('displays loading indicator while loading all badges', (
      tester,
    ) async {
      final completer = Completer<List<BadgeResponse>>();
      when(() => badgesRepository.getAllBadges()).thenAnswer(
        (_) => completer.future,
      );
      when(() => badgesRepository.getMyBadges()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const BadgesGalleryScreen(),
        overrides: overrides(),
        settle: false,
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      completer.complete([]);
      await tester.pump();
    });

    testWidgets('displays badge grid when all badges load', (tester) async {
      final badges = [
        const BadgeResponse(
          id: 'badge-1',
          name: 'Explorer',
          description: 'Visit 10 places',
          iconName: 'explore',
          iconColor: '#CD7F32',
          tier: 'BRONZE',
          earnedByUser: true,
        ),
        const BadgeResponse(
          id: 'badge-2',
          name: 'Historian',
          description: 'Visit 5 museums',
          iconName: 'museum',
          iconColor: '#FFD700',
          tier: 'GOLD',
          earnedByUser: false,
        ),
      ];

      when(() => badgesRepository.getAllBadges()).thenAnswer((_) async => badges);
      when(() => badgesRepository.getMyBadges()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const BadgesGalleryScreen(),
        overrides: overrides(),
      );

      expect(find.text('Explorer'), findsOneWidget);
      expect(find.text('Historian'), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events), findsWidgets);
    });

    testWidgets('displays empty state when all badges list is empty', (
      tester,
    ) async {
      when(() => badgesRepository.getAllBadges()).thenAnswer((_) async => []);
      when(() => badgesRepository.getMyBadges()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const BadgesGalleryScreen(),
        overrides: overrides(),
      );

      expect(find.text('badges.empty_message'), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events_outlined), findsOneWidget);
    });

    testWidgets('displays error view when all badges provider fails', (
      tester,
    ) async {
      when(
        () => badgesRepository.getAllBadges(),
      ).thenThrow(Exception('network error'));
      when(() => badgesRepository.getMyBadges()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const BadgesGalleryScreen(),
        overrides: overrides(),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('displays my badges list when data loads', (tester) async {
      final myBadges = [
        UserBadgeResponse(
          id: 'ub-1',
          badgeId: 'badge-1',
          badgeName: 'Explorer',
          badgeDescription: 'Visit 10 places',
          badgeIconName: 'explore',
          badgeIconColor: '#CD7F32',
          earnedAt: DateTime(2026, 5, 1, 14, 30),
        ),
      ];

      when(() => badgesRepository.getAllBadges()).thenAnswer((_) async => []);
      when(() => badgesRepository.getMyBadges()).thenAnswer((_) async => myBadges);

      await pumpAppWidget(
        tester,
        child: const BadgesGalleryScreen(),
        overrides: overrides(),
      );

      await tester.tap(find.text('badges.my_badges'));
      await tester.pumpAndSettle();

      expect(find.text('Explorer'), findsOneWidget);
      expect(find.textContaining('badges.earned_at'), findsOneWidget);
    });

    testWidgets('displays empty state when my badges list is empty', (
      tester,
    ) async {
      when(() => badgesRepository.getAllBadges()).thenAnswer((_) async => []);
      when(() => badgesRepository.getMyBadges()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const BadgesGalleryScreen(),
        overrides: overrides(),
      );

      await tester.tap(find.text('badges.my_badges'));
      await tester.pumpAndSettle();

      expect(find.text('badges.empty_message'), findsOneWidget);
    });
  });
}
