import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/quests/data/dto/verify_step_response.dart';
import 'package:mobile/features/quests/data/quests_api.dart';
import 'package:mobile/features/quests/data/quests_repository.dart';

class MockQuestsApi extends Mock implements QuestsApi {}

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

  group('QuestsRepository.verifyStep', () {
    test('returns APPROVED response on success', () async {
      final response = const VerifyStepResponse(
        verificationId: 'v1',
        status: 'APPROVED',
        confidenceScore: 0.95,
        expEarned: 10,
        questCompleted: false,
      );

      when(
        () => api.verifyStep(
          'q1',
          's1',
          38.4192,
          27.1287,
          any(),
        ),
      ).thenAnswer((_) async => response);

      final result = await repository.verifyStep(
        questId: 'q1',
        stepId: 's1',
        latitude: 38.4192,
        longitude: 27.1287,
      );

      expect(result.status, 'APPROVED');
      expect(result.confidenceScore, 0.95);
      expect(result.expEarned, 10);
      expect(result.questCompleted, false);
    });

    test('returns PENDING_REVIEW response on success', () async {
      final response = const VerifyStepResponse(
        verificationId: 'v2',
        status: 'PENDING_REVIEW',
        confidenceScore: 0.75,
        expEarned: 0,
        questCompleted: false,
      );

      when(
        () => api.verifyStep(
          'q1',
          's1',
          38.4192,
          27.1287,
          any(),
        ),
      ).thenAnswer((_) async => response);

      final result = await repository.verifyStep(
        questId: 'q1',
        stepId: 's1',
        latitude: 38.4192,
        longitude: 27.1287,
      );

      expect(result.status, 'PENDING_REVIEW');
      expect(result.confidenceScore, 0.75);
      expect(result.expEarned, 0);
    });

    test('throws ApiException on DioException', () async {
      when(
        () => api.verifyStep(
          'q1',
          's1',
          38.4192,
          27.1287,
          any(),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/quests/q1/steps/s1/verify'),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(
        () => repository.verifyStep(
          questId: 'q1',
          stepId: 's1',
          latitude: 38.4192,
          longitude: 27.1287,
        ),
        throwsA(isA<ApiException>()),
      );
    });

    test('throws ApiException on timeout', () async {
      when(
        () => api.verifyStep(
          'q1',
          's1',
          38.4192,
          27.1287,
          any(),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/quests/q1/steps/s1/verify'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(
        () => repository.verifyStep(
          questId: 'q1',
          stepId: 's1',
          latitude: 38.4192,
          longitude: 27.1287,
        ),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
