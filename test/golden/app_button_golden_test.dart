import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/theme/app_theme.dart';
import 'package:mobile/core/widgets/app_button.dart';

void main() {
  void setSurfaceSize(WidgetTester tester) {
    tester.view.physicalSize = const Size(400, 200);
    addTearDown(tester.view.resetPhysicalSize);
  }

  group('AppButton Golden Tests', () {
    testWidgets('AppButton.primary light theme matches golden', (
      WidgetTester tester,
    ) async {
      setSurfaceSize(tester);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Center(
              child: AppButton.primary(
                label: 'Primary Button',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden/app_button_primary_light.png'),
      );
    });

    testWidgets('AppButton.primary dark theme matches golden', (
      WidgetTester tester,
    ) async {
      setSurfaceSize(tester);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          home: Scaffold(
            body: Center(
              child: AppButton.primary(
                label: 'Primary Button',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden/app_button_primary_dark.png'),
      );
    });

    testWidgets('AppButton.secondary light theme matches golden', (
      WidgetTester tester,
    ) async {
      setSurfaceSize(tester);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Center(
              child: AppButton.secondary(
                label: 'Secondary Button',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden/app_button_secondary_light.png'),
      );
    });

    testWidgets('AppButton with icon light theme matches golden', (
      WidgetTester tester,
    ) async {
      setSurfaceSize(tester);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Center(
              child: AppButton.primary(
                label: 'Create',
                icon: Icons.add,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden/app_button_with_icon_light.png'),
      );
    });

    testWidgets('AppButton loading state light theme matches golden', (
      WidgetTester tester,
    ) async {
      setSurfaceSize(tester);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Center(
              child: AppButton.primary(
                label: 'Loading',
                isLoading: true,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden/app_button_loading_light.png'),
      );
    });

    testWidgets('AppButton disabled state light theme matches golden', (
      WidgetTester tester,
    ) async {
      setSurfaceSize(tester);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: Center(
              child: AppButton(
                label: 'Disabled',
                variant: AppButtonVariant.primary,
                onPressed: null,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(AppButton),
        matchesGoldenFile('golden/app_button_disabled_light.png'),
      );
    });
  });
}
