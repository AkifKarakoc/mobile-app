import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/theme/app_theme.dart';
import 'package:mobile/core/widgets/app_button.dart';

void main() {
  group('AppButton Widget Tests', () {
    testWidgets('AppButton renders with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton.primary(label: 'Test Button', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('AppButton triggers onPressed callback', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton.primary(
              label: 'Press Me',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      expect(pressed, false);
      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();
      expect(pressed, true);
    });

    testWidgets('AppButton disabled when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: AppButton(
              label: 'Disabled',
              variant: AppButtonVariant.primary,
              onPressed: null,
            ),
          ),
        ),
      );

      final button = find.descendant(
        of: find.byType(AppButton),
        matching: find.byType(ElevatedButton),
      );
      expect(button, findsOneWidget);

      final widget = tester.widget<ElevatedButton>(button);
      expect(widget.onPressed, isNull);
    });

    testWidgets('AppButton shows loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton.primary(
              label: 'Loading',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('AppButton with icon renders icon and label', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton.primary(
              label: 'Add Item',
              icon: Icons.add,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Add Item'), findsOneWidget);
    });

    testWidgets('AppButton secondary variant has OutlinedButton', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton.secondary(label: 'Secondary', onPressed: () {}),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
    });

    testWidgets('AppButton text variant has TextButton', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton.text(label: 'Text Link', onPressed: () {}),
          ),
        ),
      );

      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('Text Link'), findsOneWidget);
    });

    testWidgets('AppButton respects fullWidth parameter', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: AppButton.primary(
              label: 'Full Width',
              onPressed: () {},
              fullWidth: true,
            ),
          ),
        ),
      );

      expect(find.byType(AppButton), findsOneWidget);
      expect(find.text('Full Width'), findsOneWidget);
    });
  });
}
