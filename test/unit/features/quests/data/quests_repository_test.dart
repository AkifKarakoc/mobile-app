import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/quests/data/dto/quest_detail_response.dart';
import 'package:mobile/features/quests/data/dto/quest_response.dart';
import 'package:mobile/features/quests/data/quests_api.dart';
import 'package:mobile/features/quests/data/quests_repository.dart';

class MockQuestsApi extends Mock implements QuestsApi {}

class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockQuestsApi api;
  late QuestsRepository repository;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/'));
  });

  setUp(() {
    api = MockQuestsApi();
    repository = QuestsRepositoryImpl(api);
  });

  group('QuestsRepository', () {
    group('getAll', () {
      test('returns list of quests on success', () async {
        final quests = [
          const QuestResponse(
            id: 'q1',
            title: 'Quest 1',
            description: 'Description 1',
            expReward: 100,
            region: 'Konak',
            totalSteps: 5,
            userStatus: 'NOT_STARTED',
          ),
          const QuestResponse(
            id: 'q2',
            title: 'Quest 2',
            description: 'Description 2',
            expReward: 200,
            region: 'Bornova',
            totalSteps: 3,
            userStatus: 'IN_PROGRESS',
          ),
        ];

        when(() => api.getAll()).thenAnswer((_) async => quests);

        final result = await repository.getAll();

        expect(result, hasLength(2));
        expect(result[0].id, 'q1');
        expect(result[1].region, 'Bornova');
      });

      test('throws ApiException on DioException', () async {
        when(() => api.getAll()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/quests'),
            type: DioExceptionType.connectionError,
          ),
        );

        expect(
          () => repository.getAll(),
          throwsA(isA<ApiException>()),
        );
      });
    });

    group('getById', () {
      test('returns quest detail on success', () async {
        final detail = QuestDetailResponse(
          id: 'q1',
          title: 'Quest 1',
          description: 'Description 1',
          expReward: 100,
          region: 'Konak',
          steps: [
            const StepResponse(
              id: 's1',
              placeId: 'p1',
              stepOrder: 1,
              hint: 'Find the tower',
              requiresPhoto: true,
              isCompleted: false,
            ),
            const StepResponse(
              id: 's2',
              placeId: 'p2',
              stepOrder: 2,
              hint: 'Visit the museum',
              requiresPhoto: false,
              isCompleted: true,
            ),
          ],
          userStatus: 'IN_PROGRESS',
        );

        when(() => api.getById('q1')).thenAnswer((_) async => detail);

        final result = await repository.getById('q1');

        expect(result.id, 'q1');
        expect(result.steps, hasLength(2));
        expect(result.steps[0].hint, 'Find the tower');
        expect(result.steps[1].isCompleted, true);
      });

      test('throws ApiException on DioException', () async {
        when(() => api.getById('q1')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/quests/q1'),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        expect(
          () => repository.getById('q1'),
          throwsA(isA<ApiException>()),
        );
      });
    });
  });
}
