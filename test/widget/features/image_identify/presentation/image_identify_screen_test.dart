import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/features/image_identify/data/image_identify_repository.dart';
import 'package:mobile/features/image_identify/presentation/image_identify_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../test_helpers/pump_app.dart';

class MockImageIdentifyRepository extends Mock
    implements ImageIdentifyRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockImageIdentifyRepository mockRepository;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    registerFallbackValue(RequestOptions(path: '/'));
    registerFallbackValue(
      MultipartFile.fromBytes([0, 1, 2], filename: 'test.jpg'),
    );
  });

  setUp(() {
    mockRepository = MockImageIdentifyRepository();
  });

  List<Override> overrides() {
    return [
      imageIdentifyRepositoryProvider.overrideWithValue(mockRepository),
    ];
  }

  group('ImageIdentifyScreen', () {
    testWidgets('displays title in AppBar', (tester) async {
      await pumpAppWidget(
        tester,
        child: const ImageIdentifyScreen(),
        overrides: overrides(),
        settle: false,
      );

      expect(find.text('image_identify.title'.tr()), findsOneWidget);
    });

    testWidgets('displays camera icon and take photo text', (tester) async {
      await pumpAppWidget(
        tester,
        child: const ImageIdentifyScreen(),
        overrides: overrides(),
        settle: false,
      );

      expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
      expect(find.text('image_identify.take_photo'.tr()), findsWidgets);
    });

    testWidgets('displays identify button', (tester) async {
      await pumpAppWidget(
        tester,
        child: const ImageIdentifyScreen(),
        overrides: overrides(),
        settle: false,
      );

      expect(find.byType(AppButton), findsOneWidget);
      expect(find.text('image_identify.identify'.tr()), findsOneWidget);
    });

    testWidgets('displays empty state when no photo selected', (tester) async {
      await pumpAppWidget(
        tester,
        child: const ImageIdentifyScreen(),
        overrides: overrides(),
        settle: false,
      );

      expect(find.byType(EmptyState), findsOneWidget);
    });

    testWidgets('displays location loading indicator', (tester) async {
      await pumpAppWidget(
        tester,
        child: const ImageIdentifyScreen(),
        overrides: overrides(),
        settle: false,
      );

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
  });
}
