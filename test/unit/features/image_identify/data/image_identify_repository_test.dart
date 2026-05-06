import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/features/image_identify/data/dto/image_analysis_response.dart';
import 'package:mobile/features/image_identify/data/image_identify_api.dart';
import 'package:mobile/features/image_identify/data/image_identify_repository.dart';

class MockImageIdentifyApi extends Mock implements ImageIdentifyApi {}

void main() {
  late MockImageIdentifyApi mockApi;
  late ImageIdentifyRepository repository;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: '/images/identify'));
    registerFallbackValue(
      MultipartFile.fromBytes([0, 1, 2], filename: 'test.jpg'),
    );
  });

  setUp(() {
    mockApi = MockImageIdentifyApi();
    repository = ImageIdentifyRepositoryImpl(mockApi);
  });

  group('identifyImage', () {
    test('returns analysis result on successful API call', () async {
      final response = const ImageAnalysisResponse(
        placeId: null,
        placeName: 'Stub - AI service not connected',
        confidence: 0.0,
        description: 'Test description',
        imageUrl: 'https://example.com/photo.jpg',
      );

      when(
        () => mockApi.identifyImage(
          any(),
          any(),
          any(),
        ),
      ).thenAnswer((_) async => response);

      final multipartFile = MultipartFile.fromBytes(
        [0, 1, 2],
        filename: 'test.jpg',
      );

      final result = await repository.identifyImage(
        photo: multipartFile,
        latitude: 38.4192,
        longitude: 27.1287,
      );

      expect(result.placeName, equals('Stub - AI service not connected'));
      expect(result.confidence, equals(0.0));
      expect(result.description, equals('Test description'));
      verify(
        () => mockApi.identifyImage(
          any(),
          38.4192,
          27.1287,
        ),
      ).called(1);
    });

    test('throws NetworkException on connection timeout', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/images/identify'),
        type: DioExceptionType.connectionTimeout,
        message: 'Connection timeout',
      );

      when(
        () => mockApi.identifyImage(
          any(),
          any(),
          any(),
        ),
      ).thenThrow(dioException);

      final multipartFile = MultipartFile.fromBytes(
        [0, 1, 2],
        filename: 'test.jpg',
      );

      expect(
        () => repository.identifyImage(
          photo: multipartFile,
          latitude: 38.4192,
          longitude: 27.1287,
        ),
        throwsA(isA<NetworkException>()),
      );
    });

    test('throws NetworkException on connection error', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/images/identify'),
        type: DioExceptionType.connectionError,
        message: 'Connection error',
      );

      when(
        () => mockApi.identifyImage(
          any(),
          any(),
          any(),
        ),
      ).thenThrow(dioException);

      final multipartFile = MultipartFile.fromBytes(
        [0, 1, 2],
        filename: 'test.jpg',
      );

      expect(
        () => repository.identifyImage(
          photo: multipartFile,
          latitude: 38.4192,
          longitude: 27.1287,
        ),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
