import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/widgets/badge_shelf.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test_helpers/pump_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('BadgeShelf Widget Tests', () {
    testWidgets('renders empty state for empty list', (tester) async {
      await pumpAppWidget(
        tester,
        child: const BadgeShelf(badges: []),
      );

      expect(find.text('common.empty_generic'.tr()), findsOneWidget);
    });

    testWidgets('renders 3 badges', (tester) async {
      final badges = [
        const BadgeSummary(
          id: 'b1',
          name: 'Explorer',
          iconColor: '#FFD700',
          tier: 'gold',
        ),
        const BadgeSummary(
          id: 'b2',
          name: 'Traveler',
          iconColor: '#C0C0C0',
          tier: 'silver',
        ),
        const BadgeSummary(
          id: 'b3',
          name: 'Scout',
          iconColor: '#CD7F32',
          tier: 'bronze',
        ),
      ];

      await pumpAppWidget(tester, child: BadgeShelf(badges: badges));

      expect(find.byType(Icon), findsNWidgets(3));
      expect(find.byIcon(Icons.emoji_events), findsNWidgets(3));
    });

    testWidgets('shows +N when badges exceed maxDisplay', (tester) async {
      final badges = List.generate(
        8,
        (i) => BadgeSummary(
          id: 'b$i',
          name: 'Badge $i',
          iconColor: '#FFD700',
          tier: 'gold',
        ),
      );

      await pumpAppWidget(
        tester,
        child: BadgeShelf(badges: badges, maxDisplay: 5),
      );

      expect(find.text('common.more_badges'.tr(args: ['3'])), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events), findsNWidgets(5));
    });

    testWidgets('unearned badges have reduced opacity', (tester) async {
      final badges = [
        const BadgeSummary(
          id: 'b1',
          name: 'Earned',
          iconColor: '#FFD700',
          tier: 'gold',
        ),
        const BadgeSummary(
          id: 'b2',
          name: 'Unearned',
          iconColor: '#C0C0C0',
          tier: null,
        ),
      ];

      await pumpAppWidget(tester, child: BadgeShelf(badges: badges));

      final opacityWidgets = tester.widgetList<Opacity>(find.byType(Opacity));
      expect(opacityWidgets.length, 2);

      final earnedOpacity = opacityWidgets.first;
      final unearnedOpacity = opacityWidgets.last;

      expect(earnedOpacity.opacity, 1.0);
      expect(unearnedOpacity.opacity, 0.4);
    });

    testWidgets('renders with default maxDisplay of 5', (tester) async {
      final badges = List.generate(
        10,
        (i) => BadgeSummary(
          id: 'b$i',
          name: 'Badge $i',
          iconColor: '#FFD700',
          tier: 'gold',
        ),
      );

      await pumpAppWidget(tester, child: BadgeShelf(badges: badges));

      expect(find.byIcon(Icons.emoji_events), findsNWidgets(5));
      expect(find.text('common.more_badges'.tr(args: ['5'])), findsOneWidget);
    });
  });
}
