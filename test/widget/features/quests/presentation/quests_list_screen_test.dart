import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/quests/data/dto/quest_detail_response.dart';
import 'package:mobile/features/quests/data/dto/quest_response.dart';
import 'package:mobile/features/quests/data/quests_repository.dart';
import 'package:mobile/features/quests/presentation/quests_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../test_helpers/pump_app.dart';

class MockQuestsRepository extends Mock implements QuestsRepository {}

class FakeQuestDetailNotifier extends FamilyAsyncNotifier<QuestDetailResponse, String> {
  @override
  Future<QuestDetailResponse> build(String arg) async {
    throw UnimplementedError();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockQuestsRepository questsRepository;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    registerFallbackValue(RequestOptions(path: '/'));
  });

  setUp(() {
    questsRepository = MockQuestsRepository();
  });

  List<Override> overrides() {
    return [
      questsRepositoryProvider.overrideWithValue(questsRepository),
    ];
  }

  group('QuestsListScreen', () {
    testWidgets('displays loading indicator while loading', (tester) async {
      final completer = Completer<List<QuestResponse>>();
      when(() => questsRepository.getAll()).thenAnswer((_) => completer.future);

      await pumpAppWidget(
        tester,
        child: const QuestsListScreen(),
        overrides: overrides(),
        settle: false,
      );

      expect(find.byType(AppLoadingIndicator), findsOneWidget);
      completer.complete([]);
      await tester.pump();
    });

    testWidgets('displays quest list when data loads', (tester) async {
      final quests = [
        const QuestResponse(
          id: 'q1',
          title: 'Konak Explorer',
          description: 'Explore the historic Konak district',
          expReward: 150,
          region: 'Konak',
          totalSteps: 5,
          userStatus: 'IN_PROGRESS',
        ),
        const QuestResponse(
          id: 'q2',
          title: 'Beach Adventure',
          description: 'Discover the beautiful beaches of Cesme',
          expReward: 200,
          region: 'Cesme',
          totalSteps: 3,
          userStatus: 'NOT_STARTED',
        ),
      ];

      when(() => questsRepository.getAll()).thenAnswer((_) async => quests);

      await pumpAppWidget(
        tester,
        child: const QuestsListScreen(),
        overrides: overrides(),
      );

      expect(find.text('Konak Explorer'), findsOneWidget);
      expect(find.text('Beach Adventure'), findsOneWidget);
      expect(find.text('Konak'), findsWidgets);
      expect(find.text('Cesme'), findsWidgets);
    });

    testWidgets('displays empty state when list is empty', (tester) async {
      when(() => questsRepository.getAll()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const QuestsListScreen(),
        overrides: overrides(),
      );

      expect(find.byType(EmptyState), findsOneWidget);
    });

    testWidgets('displays error view when repository throws', (tester) async {
      when(() => questsRepository.getAll()).thenThrow(Exception('Network error'));

      await pumpAppWidget(
        tester,
        child: const QuestsListScreen(),
        overrides: overrides(),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
