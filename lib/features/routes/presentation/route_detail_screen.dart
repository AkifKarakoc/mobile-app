import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/routes/application/routes_provider.dart';
import 'package:mobile/features/routes/application/user_routes_provider.dart';

class RouteDetailScreen extends ConsumerWidget {
  final String routeId;

  const RouteDetailScreen({super.key, required this.routeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeState = ref.watch(routeDetailProvider(routeId));

    return Scaffold(
      appBar: AppBar(
        title: Text('routes.detail_title'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final acceptState = ref.watch(acceptRouteProvider(routeId));
              return acceptState.maybeWhen(
                loading: () => const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                orElse: () => TextButton(
                  onPressed: acceptState.maybeWhen(
                    data: (_) => null,
                    orElse: () => () {
                      ref.read(acceptRouteProvider(routeId).notifier).accept();
                    },
                  ),
                  child: Text('user_routes.accept_route'.tr()),
                ),
              );
            },
          ),
        ],
      ),
      body: routeState.when(
        data: (route) {
          if (route.places.isEmpty) {
            return EmptyState(
              icon: Icons.route_outlined,
              title: 'routes.empty_message'.tr(),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (route.thumbnailUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    child: Image.network(
                      route.thumbnailUrl!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => const SizedBox.shrink(),
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  route.name,
                  style: AppTypography.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                if (route.description != null && route.description!.isNotEmpty)
                  Text(
                    route.description!,
                    style: AppTypography.bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: AppSpacing.iconMedium,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '${'routes.duration'.tr()}: ${route.estimatedMinutes} ${'routes.minutes'.tr()}',
                      style: AppTypography.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: AppSpacing.iconMedium,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '${'routes.reward'.tr()}: ${route.expReward} ${'routes.xp_reward'.tr()}',
                      style: AppTypography.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Icon(
                      Icons.directions_walk,
                      size: AppSpacing.iconMedium,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '${route.totalStops} ${'user_routes.total_stops'.tr()}',
                      style: AppTypography.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.routeMapPath(routeId)),
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        Positioned(
                          bottom: AppSpacing.md,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: Text(
                              'user_routes.view_map'.tr(),
                              style: AppTypography.labelMedium.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'routes.stops_title'.tr(),
                  style: AppTypography.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                ...route.places.map(
                  (place) => _StopTile(
                    place: place,
                    totalStops: route.places.length,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const AppLoadingIndicator(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(routeDetailProvider(routeId)),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }
}

class _StopTile extends StatelessWidget {
  final dynamic place;
  final int totalStops;

  const _StopTile({required this.place, required this.totalStops});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        onTap: () => context.push(AppRoutes.placeDetailPath(place.placeId)),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  '${place.stopOrder}',
                  style: AppTypography.labelLarge.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.placeName ?? 'Place ID: ${place.placeId}',
                      style: AppTypography.bodyLarge,
                    ),
                    if (place.notes != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${'routes.stop_notes'.tr()}: ${place.notes}',
                        style: AppTypography.bodySmall.copyWith(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${place.estimatedMinutes} ${'routes.minutes'.tr()}',
                      style: AppTypography.bodySmall.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
