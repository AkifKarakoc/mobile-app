import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/place_display_utils.dart';
import 'package:mobile/core/widgets/app_loading_indicator.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/routes/application/user_routes_provider.dart';
import 'package:mobile/features/routes/data/dto/user_route_response.dart';

class UserRoutesScreen extends ConsumerStatefulWidget {
  const UserRoutesScreen({super.key});

  @override
  ConsumerState<UserRoutesScreen> createState() => _UserRoutesScreenState();
}

class _UserRoutesScreenState extends ConsumerState<UserRoutesScreen> {
  String _filter = 'IN_PROGRESS';

  @override
  Widget build(BuildContext context) {
    final routesState = ref.watch(userRoutesProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('user_routes.title'.tr(), style: AppTypography.titleLarge),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        centerTitle: false,
      ),
      body: routesState.when(
        data: (routes) => Column(
          children: [
            _buildFilterChips(context),
            const SizedBox(height: AppSpacing.sm),
            Expanded(child: _buildContent(context, routes)),
          ],
        ),
        loading: () => const Center(child: AppLoadingIndicator()),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(userRoutesProvider),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filters = [
      ('user_routes.in_progress'.tr(), 'IN_PROGRESS'),
      ('user_routes.completed'.tr(), 'COMPLETED'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: SegmentedButton<String>(
        segments: filters
            .map(
              (f) => ButtonSegment<String>(
                value: f.$2,
                label: Text(f.$1),
                icon: Icon(
                  f.$2 == 'IN_PROGRESS'
                      ? Icons.route_outlined
                      : Icons.check_circle_outline,
                ),
              ),
            )
            .toList(),
        selected: {_filter},
        onSelectionChanged: (selected) {
          setState(() => _filter = selected.first);
        },
        style: SegmentedButton.styleFrom(
          backgroundColor: colorScheme.surfaceContainerLow,
          selectedBackgroundColor: colorScheme.primaryContainer,
          selectedForegroundColor: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<UserRouteResponse> routes) {
    final filtered = routes.where((r) => r.status == _filter).toList();

    if (filtered.isEmpty) {
      return EmptyState(
        icon: _filter == 'IN_PROGRESS'
            ? Icons.route_outlined
            : Icons.flag_outlined,
        title: _filter == 'IN_PROGRESS'
            ? 'user_routes.no_routes'.tr()
            : 'user_routes.no_completed_routes'.tr(),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) => _UserRouteCard(route: filtered[index]),
    );
  }
}

class _UserRouteCard extends StatelessWidget {
  final UserRouteResponse route;

  const _UserRouteCard({required this.route});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCompleted = route.status == 'COMPLETED';

    return InkWell(
      onTap: () => context.push(AppRoutes.routeDetailPath(route.routeId)),
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context, isCompleted),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    route.routeName ?? 'user_routes.no_routes'.tr(),
                    style: AppTypography.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (route.routeDescription != null &&
                      route.routeDescription!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      route.routeDescription!,
                      style: AppTypography.bodySmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.directions_walk_outlined,
                        label:
                            '${route.totalStops} ${'user_routes.total_stops'.tr()}',
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _InfoChip(
                        icon: Icons.access_time_outlined,
                        label: '${route.totalStops * 15} ${'user_routes.estimated_time'.tr()}',
                      ),
                      const Spacer(),
                      _StatusBadge(isCompleted: isCompleted),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, bool isCompleted) {
    final colorScheme = Theme.of(context).colorScheme;

    if (route.routeThumbnailUrl == null) {
      return _buildPlaceholderHeader(context, isCompleted);
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppSpacing.radiusLg),
        topRight: Radius.circular(AppSpacing.radiusLg),
      ),
      child: Stack(
        children: [
          Image.network(
            route.routeThumbnailUrl!,
            headers: kNetworkImageHeaders,
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _buildPlaceholderHeader(context, isCompleted),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    colorScheme.surfaceContainerLow.withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderHeader(BuildContext context, bool isCompleted) {
    final colorScheme = Theme.of(context).colorScheme;
    final gradientColors = isCompleted
        ? [
            colorScheme.tertiary.withValues(alpha: 0.7),
            colorScheme.tertiaryContainer.withValues(alpha: 0.5),
          ]
        : [
            colorScheme.primary.withValues(alpha: 0.7),
            colorScheme.primaryContainer.withValues(alpha: 0.5),
          ];

    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusLg),
          topRight: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      child: Center(
        child: Icon(
          isCompleted ? Icons.flag : Icons.route,
          color: colorScheme.onPrimaryContainer,
          size: 40,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.primary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isCompleted;

  const _StatusBadge({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isCompleted ? colorScheme.tertiary : colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.play_arrow,
            size: 14,
            color: color,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            isCompleted
                ? 'user_routes.completed'.tr()
                : 'user_routes.in_progress'.tr(),
            style: AppTypography.labelSmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
