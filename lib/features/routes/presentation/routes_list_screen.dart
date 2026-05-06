import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/routes/application/routes_provider.dart';
import 'package:mobile/features/routes/data/dto/route_response.dart';

class RoutesListScreen extends ConsumerWidget {
  const RoutesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routesState = ref.watch(routesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('routes.list_title'.tr()),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/home/profile/routes'),
            icon: const Icon(Icons.list_alt, size: 18),
            label: Text('routes.my_routes'.tr()),
          ),
        ],
      ),
      body: routesState.when(
        data: (routes) {
          if (routes.isEmpty) {
            return EmptyState(
              icon: Icons.route_outlined,
              title: 'routes.empty_message'.tr(),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: routes.length,
            itemBuilder: (context, index) {
              final route = routes[index];
              return _RouteTile(route: route);
            },
          );
        },
        loading: () => const AppLoadingIndicator(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(routesProvider),
          retryLabel: 'common.retry'.tr(),
        ),
      ),
    );
  }
}

class _RouteTile extends StatelessWidget {
  final RouteResponse route;

  const _RouteTile({required this.route});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        onTap: () => context.go('/routes/${route.id}'),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (route.thumbnailUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  child: Image.network(
                    route.thumbnailUrl!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                  ),
                ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                route.name,
                style: AppTypography.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              if (route.description != null && route.description!.isNotEmpty)
                Text(
                  route.description!.length > 100
                      ? '${route.description!.substring(0, 100)}...'
                      : route.description!,
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
                    '${route.totalStops} ${'routes.stops'.tr()}',
                    style: AppTypography.bodySmall,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Icon(
                    Icons.access_time,
                    size: AppSpacing.iconSmall,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '${route.estimatedMinutes} ${'routes.minutes'.tr()}',
                    style: AppTypography.bodySmall,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.star,
                    size: AppSpacing.iconSmall,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '${route.expReward} ${'routes.xp_reward'.tr()}',
                    style: AppTypography.bodySmall.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
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
