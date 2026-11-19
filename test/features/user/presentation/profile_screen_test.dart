import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/user/application/profile_provider.dart';
import 'package:mobile/features/user/data/dto/user_response.dart';
import 'package:mobile/features/user/presentation/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test_helpers/pump_app.dart';

class TestProfileNotifier extends ProfileNotifier {
  TestProfileNotifier(this.profileBuilder);

  final FutureOr<UserResponse?> Function() profileBuilder;

  @override
  FutureOr<UserResponse?> build() => profileBuilder();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  final testUser = UserResponse(
    id: '123',
    email: 'test@example.com',
    firstName: 'John',
    lastName: 'Doe',
    profilePhotoUrl: null,
    preferredLanguage: 'tr',
    role: 'TOURIST',
    expPoints: 750,
    level: 2,
  );

  group('ProfileScreen', () {
    testWidgets('displays loading indicator while loading', (tester) async {
      final profileCompleter = Completer<UserResponse?>();

      await pumpAppWidget(
        tester,
        child: const ProfileScreen(),
        settle: false,
        overrides: [
          profileProvider.overrideWith(
            () => TestProfileNotifier(() => profileCompleter.future),
          ),
        ],
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      profileCompleter.complete(testUser);
      await tester.pump();
    });

    testWidgets('displays profile data when loaded', (tester) async {
      await pumpAppWidget(
        tester,
        child: const ProfileScreen(),
        overrides: [
          profileProvider.overrideWith(
            () => TestProfileNotifier(() => testUser),
          ),
        ],
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text(testUser.email), findsOneWidget);
    });

    testWidgets('displays error view on error', (tester) async {
      await pumpAppWidget(
        tester,
        child: const ProfileScreen(),
        overrides: [
          profileProvider.overrideWith(
            () => TestProfileNotifier(() => throw Exception('Network error')),
          ),
        ],
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('has action buttons when data loads', (tester) async {
      await pumpAppWidget(
        tester,
        child: const ProfileScreen(),
        overrides: [
          profileProvider.overrideWith(
            () => TestProfileNotifier(() => testUser),
          ),
        ],
      );

      expect(find.byIcon(Icons.flag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.route_outlined), findsOneWidget);
      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
      expect(find.byIcon(Icons.logout), findsOneWidget);
    });
  });
}
