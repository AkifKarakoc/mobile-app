import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/routes/application/routes_provider.dart';
import 'package:mobile/features/routes/data/dto/user_route_response.dart';
import 'package:mobile/features/routes/data/routes_repository.dart';

final userRoutesProvider = FutureProvider<List<UserRouteResponse>>((ref) async {
  final repository = ref.watch(routesRepositoryProvider);
  return repository.getUserRoutes();
});

class AcceptRouteNotifier extends FamilyAsyncNotifier<void, String> {
  RoutesRepository? _repository;

  @override
  Future<void> build(String arg) async {
    _repository ??= ref.watch(routesRepositoryProvider);
  }

  Future<void> accept() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repository!.acceptRoute(arg);
      ref.invalidate(userRoutesProvider);
      ref.invalidate(routeDetailProvider(arg));
    });
    
    // On error (e.g., 409 already accepted), refresh route detail to show correct status
    if (state.hasError) {
      ref.invalidate(routeDetailProvider(arg));
    }
  }
}

final acceptRouteProvider =
    AsyncNotifierProvider.family<AcceptRouteNotifier, void, String>(
      AcceptRouteNotifier.new,
    );
