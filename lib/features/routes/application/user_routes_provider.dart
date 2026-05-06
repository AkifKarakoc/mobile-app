import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/routes/data/dto/user_route_response.dart';
import 'package:mobile/features/routes/data/routes_repository.dart';

final userRoutesProvider = FutureProvider<List<UserRouteResponse>>((ref) async {
  final repository = ref.watch(routesRepositoryProvider);
  return repository.getUserRoutes();
});

class AcceptRouteNotifier extends FamilyAsyncNotifier<void, String> {
  late RoutesRepository _repository;

  @override
  Future<void> build(String arg) async {
    _repository = ref.watch(routesRepositoryProvider);
  }

  Future<void> accept() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.acceptRoute(arg));
  }
}

final acceptRouteProvider =
    AsyncNotifierProvider.family<AcceptRouteNotifier, void, String>(
      AcceptRouteNotifier.new,
    );
