import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/onboarding/presentation/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test_helpers/pump_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('OnboardingScreen Widget Tests', () {
    testWidgets('builds the onboarding carousel', (tester) async {
      await pumpAppWidget(tester, child: const OnboardingScreen());
      await pumpUntilFound(tester, find.byType(PageView));

      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets('displays first page content on init', (tester) async {
      await pumpAppWidget(tester, child: const OnboardingScreen());
      await pumpUntilFound(tester, find.byIcon(Icons.travel_explore));

      expect(find.byIcon(Icons.travel_explore), findsOneWidget);
      expect(find.text('onboarding.skip'.tr()), findsOneWidget);
    });

    testWidgets('shows skip button on first page', (tester) async {
      await pumpAppWidget(tester, child: const OnboardingScreen());
      final skipButton = find.text('onboarding.skip'.tr());
      await pumpUntilFound(tester, skipButton);

      expect(skipButton, findsOneWidget);
    });

    testWidgets('page indicator shows 3 dots', (tester) async {
      await pumpAppWidget(tester, child: const OnboardingScreen());
      await pumpUntilFound(tester, find.byType(AnimatedContainer));

      // Page indicator uses AnimatedContainer for dots
      expect(find.byType(AnimatedContainer), findsNWidgets(3));
    });

    testWidgets('next button text shows on first page', (tester) async {
      await pumpAppWidget(tester, child: const OnboardingScreen());
      final nextButton = find.text('onboarding.next'.tr());
      await pumpUntilFound(tester, nextButton);

      expect(nextButton, findsOneWidget);
    });

    testWidgets('PageView is configured for the onboarding pages', (
      tester,
    ) async {
      await pumpAppWidget(tester, child: const OnboardingScreen());
      await pumpUntilFound(tester, find.byType(PageView));

      expect(find.byType(PageView), findsOneWidget);
      expect(find.byIcon(Icons.travel_explore), findsOneWidget);
    });
  });
}
