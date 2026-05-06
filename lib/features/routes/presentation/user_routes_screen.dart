import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/app_loading_indicator.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/routes/application/user_routes_provider.dart';
import 'package:mobile/features/routes/data/dto/user_route_response.dart';

class UserRoutesScreen extends ConsumerWidget {
  const UserRoutesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routesState = ref.watch(userRoutesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('user_routes.title'.tr()),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: routesState.when(
        data: (routes) {
          if (routes.isEmpty) {
            return EmptyState(
              icon: Icons.route_outlined,
              title: 'user_routes.no_routes'.tr(),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: routes.length,
            itemBuilder: (context, index) {
              final route = routes[index];
              return _UserRouteCard(route: route);
            },
          );
        },
        loading: () => const AppLoadingIndicator(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(userRoutesProvider),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }
}

class _UserRouteCard extends StatelessWidget {
  final UserRouteResponse route;

  const _UserRouteCard({required this.route});

  @override
  Widget build(BuildContext context) {
    final statusColor = route.status == 'COMPLETED'
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.tertiary;

    final statusLabel = route.status == 'COMPLETED'
        ? 'user_routes.completed'.tr()
        : 'user_routes.in_progress'.tr();

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        onTap: () => context.push(AppRoutes.routeDetailPath(route.routeId)),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (route.routeThumbnailUrl != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  child: Image.network(
                    route.routeThumbnailUrl!,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              Row(
                children: [
                  Expanded(
                    child: Text(
                      route.routeName,
                      style: AppTypography.headlineSmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      statusLabel,
                      style: AppTypography.labelSmall.copyWith(
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                route.routeDescription.length > 100
                    ? '${route.routeDescription.substring(0, 100)}...'
                    : route.routeDescription,
                style: AppTypography.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(
                    Icons.directions_walk,
                    size: AppSpacing.iconSmall,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '${route.totalStops} ${'user_routes.total_stops'.tr()}',
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
