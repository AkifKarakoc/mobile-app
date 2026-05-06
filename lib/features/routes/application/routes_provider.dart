import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/routes/data/dto/route_response.dart';
import 'package:mobile/features/routes/data/routes_repository.dart';

final routesProvider = FutureProvider<List<RouteResponse>>((ref) async {
  final repository = ref.watch(routesRepositoryProvider);
  return repository.getAll();
});

class RouteDetailNotifier extends FamilyAsyncNotifier<RouteResponse, String> {
  late RoutesRepository _repository;

  @override
  Future<RouteResponse> build(String arg) async {
    _repository = ref.watch(routesRepositoryProvider);
    return _repository.getById(arg);
  }
}

final routeDetailProvider =
    AsyncNotifierProvider.family<RouteDetailNotifier, RouteResponse, String>(
      RouteDetailNotifier.new,
    );
