import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/routes/data/dto/complete_route_stop_response.dart';
import 'package:mobile/features/routes/data/dto/route_response.dart';
import 'package:mobile/features/routes/data/routes_repository.dart';

final routesProvider = FutureProvider<List<RouteResponse>>((ref) async {
  final repository = ref.watch(routesRepositoryProvider);
  return repository.getAll();
});

class RouteDetailNotifier extends FamilyAsyncNotifier<RouteResponse, String> {
  RoutesRepository? _repository;
  String? _routeId;

  @override
  Future<RouteResponse> build(String arg) async {
    _repository ??= ref.watch(routesRepositoryProvider);
    _routeId = arg;
    return _repository!.getById(arg);
  }

  Future<CompleteRouteStopResponse> completeRouteStop({
    required String routePlaceId,
    required double latitude,
    required double longitude,
  }) async {
    final result = await _repository!.completeRouteStop(
      routeId: _routeId!,
      routePlaceId: routePlaceId,
      latitude: latitude,
      longitude: longitude,
    );
    ref.invalidateSelf();
    return result;
  }
}

final routeDetailProvider =
    AsyncNotifierProvider.family<RouteDetailNotifier, RouteResponse, String>(
      RouteDetailNotifier.new,
    );
