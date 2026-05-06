import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/widgets/app_text_field.dart';
import 'package:mobile/features/auth/application/auth_notifier.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/data/dto/login_response.dart';
import 'package:mobile/features/auth/presentation/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test_helpers/pump_app.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class TestAuthNotifier extends AuthNotifier {
  TestAuthNotifier(this.repository);

  final AuthRepository repository;

  @override
  bool build() => false;

  @override
  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    try {
      await repository.login(email: email, password: password);
      state = const AsyncValue.data(true);
    } catch (_) {
      state = const AsyncValue.data(false);
      rethrow;
    }
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('LoginScreen', () {
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
    });

    List<Override> authOverrides() => [
      authNotifierProvider.overrideWith(
        () => TestAuthNotifier(mockAuthRepository),
      ),
    ];

    testWidgets('displays email and password fields', (tester) async {
      await pumpAppWidget(
        tester,
        child: const LoginScreen(),
        overrides: authOverrides(),
      );
      await pumpUntilFound(tester, find.byType(AppTextField));

      expect(find.byType(AppTextField), findsNWidgets(2));
    });

    testWidgets('shows validation error for empty email', (tester) async {
      await pumpAppWidget(
        tester,
        child: const LoginScreen(),
        overrides: authOverrides(),
      );
      final submitButton = find.text('auth.submit_login'.tr());
      await pumpUntilFound(tester, submitButton);

      await tester.tap(submitButton);
      await tester.pump();

      expect(find.text('auth.validation_email_required'.tr()), findsOneWidget);
    });

    testWidgets('shows validation error for invalid email format', (
      tester,
    ) async {
      await pumpAppWidget(
        tester,
        child: const LoginScreen(),
        overrides: authOverrides(),
      );
      await pumpUntilFound(tester, find.byType(TextFormField));

      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.tap(find.text('auth.submit_login'.tr()));
      await tester.pump();

      expect(find.text('auth.validation_email_invalid'.tr()), findsOneWidget);
    });

    testWidgets('shows validation error for short password', (tester) async {
      await pumpAppWidget(
        tester,
        child: const LoginScreen(),
        overrides: authOverrides(),
      );
      await pumpUntilFound(tester, find.byType(TextFormField));

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.first, 'test@example.com');
      await tester.enterText(textFields.last, 'short');
      await tester.tap(find.text('auth.submit_login'.tr()));
      await tester.pump();

      expect(find.text('auth.validation_password_min'.tr()), findsOneWidget);
    });

    testWidgets('calls login when form is valid and submitted', (tester) async {
      final loginCompleter = Completer<LoginResponse>();
      when(
        () => mockAuthRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) => loginCompleter.future);

      await pumpAppWidget(
        tester,
        child: const LoginScreen(),
        overrides: authOverrides(),
      );
      await pumpUntilFound(tester, find.byType(TextFormField));

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.first, 'test@example.com');
      await tester.enterText(textFields.last, 'password123');
      await tester.tap(find.text('auth.submit_login'.tr()));
      await tester.pump();

      verify(
        () => mockAuthRepository.login(
          email: 'test@example.com',
          password: 'password123',
        ),
      ).called(1);
      loginCompleter.complete(
        const LoginResponse(
          accessToken: 'token',
          refreshToken: 'refresh',
          role: 'TOURIST',
        ),
      );
      await tester.pump();
    });

    testWidgets('shows error message on login failure', (tester) async {
      when(
        () => mockAuthRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const UnauthorizedException('Invalid credentials'));

      await pumpAppWidget(
        tester,
        child: const LoginScreen(),
        overrides: authOverrides(),
      );
      await pumpUntilFound(tester, find.byType(TextFormField));

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.first, 'test@example.com');
      await tester.enterText(textFields.last, 'wrongpassword');
      await tester.tap(find.text('auth.submit_login'.tr()));
      await tester.pump();

      expect(find.text('auth.error_invalid_credentials'.tr()), findsOneWidget);
    });

    testWidgets('forgot password link is tappable', (tester) async {
      await pumpAppWidget(
        tester,
        child: const LoginScreen(),
        overrides: authOverrides(),
      );
      final forgotPasswordButton = find.text('auth.forgot_password'.tr());
      await pumpUntilFound(tester, forgotPasswordButton);

      expect(forgotPasswordButton, findsOneWidget);
    });
  });
}
