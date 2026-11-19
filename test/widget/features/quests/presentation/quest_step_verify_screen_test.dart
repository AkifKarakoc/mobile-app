import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/quests/data/quests_repository.dart';
import 'package:mobile/features/quests/presentation/quest_step_verify_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../test_helpers/pump_app.dart';

class MockQuestsRepository extends Mock implements QuestsRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const permissionChannel = MethodChannel('flutter.baseflow.com/permissions/methods');
  late MockQuestsRepository questsRepository;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    registerFallbackValue(RequestOptions(path: '/'));
  });

  setUp(() {
    questsRepository = MockQuestsRepository();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(permissionChannel, (MethodCall call) async {
      switch (call.method) {
        case 'checkPermissionStatus':
          return PermissionStatus.denied.index;
        case 'requestPermissions':
          return <int, int>{
            Permission.location.value: PermissionStatus.denied.index,
            Permission.camera.value: PermissionStatus.denied.index,
          };
        case 'openAppSettings':
          return true;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(permissionChannel, null);
  });

  List<Override> overrides() {
    return [
      questsRepositoryProvider.overrideWithValue(questsRepository),
    ];
  }

  group('QuestStepVerifyScreen', () {
    testWidgets('renders app bar with title', (tester) async {
      await pumpAppWidget(
        tester,
        child: const QuestStepVerifyScreen(
          questId: 'q1',
          stepId: 's1',
        ),
        overrides: overrides(),
      );

      await tester.pumpAndSettle();
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('renders back button', (tester) async {
      await pumpAppWidget(
        tester,
        child: const QuestStepVerifyScreen(
          questId: 'q1',
          stepId: 's1',
        ),
        overrides: overrides(),
      );

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('renders camera placeholder area', (tester) async {
      await pumpAppWidget(
        tester,
        child: const QuestStepVerifyScreen(
          questId: 'q1',
          stepId: 's1',
        ),
        overrides: overrides(),
      );

      expect(find.byIcon(Icons.camera_alt_outlined), findsWidgets);
    });

    testWidgets('renders GPS status area', (tester) async {
      await pumpAppWidget(
        tester,
        child: const QuestStepVerifyScreen(
          questId: 'q1',
          stepId: 's1',
        ),
        overrides: overrides(),
      );

      expect(find.byIcon(Icons.location_off_outlined), findsOneWidget);
    });

    testWidgets('renders action buttons', (tester) async {
      await pumpAppWidget(
        tester,
        child: const QuestStepVerifyScreen(
          questId: 'q1',
          stepId: 's1',
        ),
        overrides: overrides(),
      );

      expect(find.byType(AppButton), findsNWidgets(2));
    });

    testWidgets('submit button is disabled initially', (tester) async {
      await pumpAppWidget(
        tester,
        child: const QuestStepVerifyScreen(
          questId: 'q1',
          stepId: 's1',
        ),
        overrides: overrides(),
      );

      await tester.pumpAndSettle();
      final buttons = tester.widgetList<AppButton>(find.byType(AppButton)).toList();
      expect(buttons.length, greaterThanOrEqualTo(1));

      final submitButton = buttons.where(
        (b) => b.label.contains('Gönder') || b.label.contains('submit'),
      ).firstOrNull;

      expect(submitButton, isNotNull);
      expect(submitButton!.onPressed, isNull);
    });
  });
}
