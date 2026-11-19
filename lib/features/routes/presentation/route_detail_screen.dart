import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/place_display_utils.dart';
import 'package:mobile/core/widgets/animated_card.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/shimmer_placeholder.dart';
import 'package:mobile/core/widgets/tap_feedback.dart';
import 'package:mobile/features/routes/application/routes_provider.dart';
import 'package:mobile/features/routes/data/dto/route_response.dart';
import 'package:mobile/features/routes/presentation/route_stop_complete_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RouteDetailScreen extends ConsumerWidget {
  final String routeId;
  final String? heroTag;

  const RouteDetailScreen({super.key, required this.routeId, this.heroTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeState = ref.watch(routeDetailProvider(routeId));

    return Scaffold(
      body: routeState.when(
        data: (route) {
          if (route.places.isEmpty) {
            return EmptyState(
              icon: Icons.route_outlined,
              title: 'routes.empty_message'.tr(),
            );
          }
          return _RouteDetailBody(
            route: route,
            routeId: routeId,
            ref: ref,
            heroTag: heroTag,
          );
        },
        loading: () => const DetailShimmer(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(routeDetailProvider(routeId)),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }
}

class _RouteDetailBody extends StatelessWidget {
  const _RouteDetailBody({
    required this.route,
    required this.routeId,
    required this.ref,
    required this.heroTag,
  });

  final RouteResponse route;
  final String routeId;
  final WidgetRef ref;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final completedStops = route.places.where((p) => p.completed).length;
    final totalStops = route.places.length;
    final progress = totalStops > 0 ? completedStops / totalStops : 0.0;
    final isAccepted = route.userStatus != null;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: _RouteBanner(
            route: route,
            heroTag: heroTag ?? 'route-thumb-$routeId',
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (route.description != null &&
                    route.description!.isNotEmpty) ...[
                  Text(
                    route.description!,
                    style: AppTypography.bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                _RouteStats(route: route),
                if (totalStops > 1) ...[
                  const SizedBox(height: AppSpacing.md),
                  _ProgressCard(
                    progress: progress,
                    completed: completedStops,
                    total: totalStops,
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                TapFeedback(
                  onTap: () => context.push(AppRoutes.routeMapPath(routeId)),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
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
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusSm),
                            ),
                            child: Text(
                              'user_routes.view_map'.tr(),
                              style: AppTypography.labelMedium.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary,
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
                ...List.generate(
                  route.places.length,
                  (index) => AnimatedCard(
                    delayMs: 100 + (index * 80),
                    child: _RouteStopTile(
                      routeId: routeId,
                      place: route.places[index],
                      totalStops: route.places.length,
                      gpsThresholdMeters: route.gpsThresholdMeters,
                      isRouteAccepted: isAccepted,
                      index: index,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ],
      ),
      bottomNavigationBar: isAccepted
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: FilledButton.icon(
                  onPressed: () => context.push(AppRoutes.routeMapPath(routeId)),
                  icon: const Icon(Icons.map_outlined),
                  label: Text('user_routes.view_map'.tr()),
                ),
              ),
            )
          : null,
    );
  }
}

class _RouteBanner extends StatelessWidget {
  const _RouteBanner({required this.route, required this.heroTag});

  final RouteResponse route;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        route.thumbnailUrl != null && route.thumbnailUrl!.isNotEmpty
            ? Hero(
                tag: heroTag,
                child: Material(
                  type: MaterialType.transparency,
                  child: CachedNetworkImage(
                    imageUrl: route.thumbnailUrl!,
                    httpHeaders: kNetworkImageHeaders,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: colorScheme.surfaceContainerHighest,
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.route_outlined,
                        size: 64,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                color: colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.route_outlined,
                  size: 64,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                colorScheme.surface.withValues(alpha: 0.3),
                colorScheme.surface.withValues(alpha: 0.9),
              ],
              stops: const [0.4, 0.75, 1.0],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 12,
          right: AppSpacing.md,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.stars, size: 16, color: colorScheme.onTertiaryContainer),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${route.expReward} XP',
                  style: AppTypography.labelMedium.copyWith(
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 12,
          left: AppSpacing.md,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.access_time, size: 16, color: colorScheme.onPrimaryContainer),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${route.estimatedMinutes} ${'routes.minutes'.tr()}',
                  style: AppTypography.labelMedium.copyWith(
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: AppSpacing.md,
          right: AppSpacing.md,
          bottom: AppSpacing.md,
          child: Text(
            route.name,
            style: AppTypography.headlineSmall.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class _RouteStats extends StatelessWidget {
  const _RouteStats({required this.route});

  final RouteResponse route;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        _StatItem(
          icon: Icons.access_time,
          label: '${route.estimatedMinutes} ${'routes.minutes'.tr()}',
        ),
        const SizedBox(width: AppSpacing.md),
        _StatItem(
          icon: Icons.directions_walk,
          label: '${route.totalStops ?? route.places.length} ${'user_routes.total_stops'.tr()}',
        ),
        const SizedBox(width: AppSpacing.md),
        _StatItem(
          icon: Icons.stars,
          label: '${route.expReward} XP',
          color: colorScheme.tertiary,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.label,
    this.color,
  });

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: color ?? colorScheme.primary),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: AppTypography.bodyMedium),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.progress,
    required this.completed,
    required this.total,
  });

  final double progress;
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'routes.progress'.tr(),
                style: AppTypography.titleSmall,
              ),
              Text(
                '$completed/$total',
                style: AppTypography.bodyMedium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          LinearPercentIndicator(
            percent: progress,
            lineHeight: 8,
            backgroundColor: colorScheme.outlineVariant.withValues(alpha: 0.2),
            progressColor: colorScheme.primary,
            barRadius: const Radius.circular(AppSpacing.radiusSm),
          ),
        ],
      ),
    );
  }
}

class _RouteStopTile extends ConsumerWidget {
  final String routeId;
  final RoutePlaceResponse place;
  final int totalStops;
  final int gpsThresholdMeters;
  final bool isRouteAccepted;
  final int index;

  const _RouteStopTile({
    required this.routeId,
    required this.place,
    required this.totalStops,
    required this.gpsThresholdMeters,
    required this.isRouteAccepted,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCompleted = place.completed;
    final isLast = index == totalStops - 1;

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
              Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? colorScheme.tertiaryContainer
                          : colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isCompleted
                          ? Icon(
                              Icons.check,
                              size: 18,
                              color: colorScheme.onTertiaryContainer,
                            )
                          : Text(
                              '${place.stopOrder}',
                              style: AppTypography.labelMedium.copyWith(
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 24,
                      color: isCompleted
                          ? colorScheme.tertiary.withValues(alpha: 0.3)
                          : colorScheme.outlineVariant.withValues(alpha: 0.2),
                    ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.placeName ?? 'Place ID: ${place.placeId}',
                      style: AppTypography.bodyLarge.copyWith(
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                        color: isCompleted
                            ? colorScheme.outlineVariant
                            : null,
                      ),
                    ),
                    if (place.notes != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        place.notes!,
                        style: AppTypography.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (place.estimatedMinutes != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            '${place.estimatedMinutes} ${'routes.minutes'.tr()}',
                            style: AppTypography.bodySmall.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (!isCompleted && place.id != null && isRouteAccepted)
                TextButton(
                  onPressed: () => _navigateToComplete(context, ref),
                  child: Text('route_stop.complete'.tr()),
                )
              else if (isCompleted)
                Icon(Icons.check_circle, color: colorScheme.tertiary)
              else if (!isRouteAccepted)
                Icon(
                  Icons.lock_outline,
                  color: colorScheme.outlineVariant,
                  size: AppSpacing.iconMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToComplete(BuildContext context, WidgetRef ref) {
    final placeId = place.id;
    if (placeId == null) return;
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => RouteStopCompleteScreen(
              routeId: routeId,
              routePlaceId: placeId,
              placeName: place.placeName ?? '',
              targetLatitude: place.latitude,
              targetLongitude: place.longitude,
              gpsThresholdMeters: gpsThresholdMeters,
            ),
          ),
        )
        .then((completed) {
          if (completed == true) {
            ref.invalidate(routeDetailProvider(routeId));
          }
        });
  }
}
