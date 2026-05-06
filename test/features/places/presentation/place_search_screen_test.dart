import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/places/application/place_search_provider.dart';
import 'package:mobile/features/places/data/dto/place_response.dart';
import 'package:mobile/features/places/presentation/place_search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test_helpers/pump_app.dart';

class TestPlaceSearchNotifier extends PlaceSearchNotifier {
  TestPlaceSearchNotifier(this.initialState)
    : super(debounceDuration: Duration.zero);

  final PlaceSearchState initialState;

  @override
  PlaceSearchState build() => initialState;

  @override
  void updateQuery(String query) {
    state = state.copyWith(query: query);
  }

  @override
  Future<void> searchFromRecent(String query) async {
    state = state.copyWith(query: query);
  }

  @override
  Future<void> clearRecentSearches() async {
    state = state.copyWith(recentSearches: const AsyncValue.data([]));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('PlaceSearchScreen', () {
    List<Override> overrides(PlaceSearchState state) {
      return [
        placeSearchProvider.overrideWith(() => TestPlaceSearchNotifier(state)),
      ];
    }

    testWidgets('renders recent searches when query is empty', (tester) async {
      const state = PlaceSearchState(
        query: '',
        results: AsyncValue.data([]),
        recentSearches: AsyncValue.data(['Saat Kulesi', 'Agora']),
      );

      await pumpAppWidget(
        tester,
        child: const PlaceSearchScreen(),
        overrides: overrides(state),
      );
      await pumpUntilFound(tester, find.text('Saat Kulesi'));

      expect(find.text('Saat Kulesi'), findsOneWidget);
      expect(find.text('Agora'), findsOneWidget);
    });

    testWidgets('renders search results', (tester) async {
      const state = PlaceSearchState(
        query: 'agora',
        results: AsyncValue.data([
          PlaceResponse(
            id: 'place-1',
            nameTr: 'Agora Açık Hava Müzesi',
            nameEn: 'Agora Open Air Museum',
            category: 'MUSEUM',
            avgRating: 4.6,
            distance: 850,
          ),
        ]),
        recentSearches: AsyncValue.data([]),
      );

      await pumpAppWidget(
        tester,
        child: const PlaceSearchScreen(),
        overrides: overrides(state),
      );
      await pumpUntilFound(tester, find.text('Agora Açık Hava Müzesi'));

      expect(find.text('Agora Açık Hava Müzesi'), findsOneWidget);
    });

    testWidgets('tapping a recent search updates the field', (tester) async {
      const state = PlaceSearchState(
        query: '',
        results: AsyncValue.data([]),
        recentSearches: AsyncValue.data(['Agora']),
      );

      await pumpAppWidget(
        tester,
        child: const PlaceSearchScreen(),
        overrides: overrides(state),
      );
      await pumpUntilFound(tester, find.text('Agora'));

      await tester.tap(find.text('Agora'));
      await tester.pump();

      final textField = tester.widget<EditableText>(find.byType(EditableText));
      expect(textField.controller.text, 'Agora');
    });
  });
}
