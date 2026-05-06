import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/widgets/level_ring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test_helpers/pump_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('LevelRing Widget Tests', () {
    testWidgets('renders level 1 with label', (tester) async {
      await pumpAppWidget(tester, child: const LevelRing(level: 1));

      expect(find.text('1'), findsOneWidget);
      expect(find.text('common.level'.tr()), findsOneWidget);
    });

    testWidgets('renders level 10 with label', (tester) async {
      await pumpAppWidget(tester, child: const LevelRing(level: 10));

      expect(find.text('10'), findsOneWidget);
      expect(find.text('common.level'.tr()), findsOneWidget);
    });

    testWidgets('hides label when showLabel is false', (tester) async {
      await pumpAppWidget(
        tester,
        child: const LevelRing(level: 5, showLabel: false),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.text('common.level'.tr()), findsNothing);
    });

    testWidgets('renders CustomPaint for ring', (tester) async {
      await pumpAppWidget(tester, child: const LevelRing(level: 7));

      expect(find.byType(CustomPaint), findsOneWidget);
    });
  });
}
