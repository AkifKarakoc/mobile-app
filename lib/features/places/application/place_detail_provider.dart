import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/data/places_repository.dart';

class PlaceDetailNotifier
    extends AutoDisposeFamilyAsyncNotifier<PlaceDetailResponse, String> {
  late final PlacesRepository _repository;

  @override
  FutureOr<PlaceDetailResponse> build(String arg) {
    _repository = ref.watch(placesRepositoryProvider);
    return _repository.getById(arg);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.getById(arg));
  }
}

final placeDetailProvider = AsyncNotifierProvider.autoDispose
    .family<PlaceDetailNotifier, PlaceDetailResponse, String>(
      PlaceDetailNotifier.new,
    );
