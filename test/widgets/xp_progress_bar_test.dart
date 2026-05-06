import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/widgets/xp_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test_helpers/pump_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('XPProgressBar Widget Tests', () {
    testWidgets('renders empty bar at 0/1000 XP', (tester) async {
      await pumpAppWidget(
        tester,
        child: const XPProgressBar(currentXP: 0, requiredXP: 1000),
      );

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.text('common.xp_progress'.tr(args: ['0', '1000'])), findsOneWidget);
    });

    testWidgets('renders half-filled bar at 500/1000 XP', (tester) async {
      await pumpAppWidget(
        tester,
        child: const XPProgressBar(currentXP: 500, requiredXP: 1000),
      );

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.text('common.xp_progress'.tr(args: ['500', '1000'])), findsOneWidget);

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, 0.5);
    });

    testWidgets('renders full bar at 1000/1000 XP', (tester) async {
      await pumpAppWidget(
        tester,
        child: const XPProgressBar(currentXP: 1000, requiredXP: 1000),
      );

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.text('common.xp_progress'.tr(args: ['1000', '1000'])), findsOneWidget);

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, 1.0);
    });

    testWidgets('hides label when showLabel is false', (tester) async {
      await pumpAppWidget(
        tester,
        child: const XPProgressBar(
          currentXP: 250,
          requiredXP: 1000,
          showLabel: false,
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.text('common.xp_progress'.tr(args: ['250', '1000'])), findsNothing);
    });

    testWidgets('clamps progress above 100%', (tester) async {
      await pumpAppWidget(
        tester,
        child: const XPProgressBar(currentXP: 1500, requiredXP: 1000),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, 1.0);
    });

    testWidgets('handles zero requiredXP gracefully', (tester) async {
      await pumpAppWidget(
        tester,
        child: const XPProgressBar(currentXP: 100, requiredXP: 0),
      );

      final indicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(indicator.value, 0.0);
    });
  });
}
