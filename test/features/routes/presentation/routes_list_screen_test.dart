import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/routes/data/dto/route_response.dart';
import 'package:mobile/features/routes/data/routes_repository.dart';
import 'package:mobile/features/routes/presentation/routes_list_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test_helpers/pump_app.dart';

class MockRoutesRepository extends Mock implements RoutesRepository {}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('RoutesListScreen', () {
    testWidgets('shows route list when data is available', (tester) async {
      final mockRepository = MockRoutesRepository();
      final routes = [
        RouteResponse(
          id: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
          name: 'Historic Izmir Tour',
          description: 'Explore the historic sites of Izmir',
          createdAt: DateTime(2026, 5, 1),
          centerLatitude: 38.4192,
          centerLongitude: 27.1287,
          radiusMeters: 5000,
          estimatedMinutes: 120,
          expReward: 150,
          totalStops: 5,
          places: [],
        ),
      ];
      when(() => mockRepository.getAll()).thenAnswer((_) async => routes);

      await pumpAppWidget(
        tester,
        child: const RoutesListScreen(),
        overrides: [
          routesRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      expect(find.text('Historic Izmir Tour'), findsOneWidget);
      expect(find.textContaining('routes.stops'), findsOneWidget);
      expect(find.textContaining('routes.minutes'), findsOneWidget);
      expect(find.textContaining('routes.xp_reward'), findsOneWidget);
    });

    testWidgets('shows empty state when no routes', (tester) async {
      final mockRepository = MockRoutesRepository();
      when(() => mockRepository.getAll()).thenAnswer((_) async => []);

      await pumpAppWidget(
        tester,
        child: const RoutesListScreen(),
        overrides: [
          routesRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      expect(find.byType(EmptyState), findsOneWidget);
      expect(find.text('routes.empty_message'.tr()), findsOneWidget);
    });

    testWidgets('shows error view on failure', (tester) async {
      final mockRepository = MockRoutesRepository();
      when(() => mockRepository.getAll()).thenThrow(
        const ApiException.network('Connection timeout'),
      );

      await pumpAppWidget(
        tester,
        child: const RoutesListScreen(),
        overrides: [
          routesRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('shows loading indicator initially', (tester) async {
      final mockRepository = MockRoutesRepository();
      final completer = Completer<List<RouteResponse>>();
      when(() => mockRepository.getAll()).thenAnswer((_) async => completer.future);

      await pumpAppWidget(
        tester,
        child: const RoutesListScreen(),
        overrides: [
          routesRepositoryProvider.overrideWithValue(mockRepository),
        ],
        settle: false,
      );
      await tester.pump();

      expect(find.byType(AppLoadingIndicator), findsOneWidget);

      completer.complete([]);
      await tester.pump();
    });
  });
}
