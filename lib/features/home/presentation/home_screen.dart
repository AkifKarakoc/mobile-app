import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home.title'.tr()),
        actions: [
          TextButton.icon(
            onPressed: () => context.push(AppRoutes.userQuests),
            icon: const Icon(Icons.flag_outlined, size: 18),
            label: Text('home.my_quests'.tr()),
          ),
          TextButton.icon(
            onPressed: () => context.push(AppRoutes.userRoutes),
            icon: const Icon(Icons.route_outlined, size: 18),
            label: Text('home.my_routes'.tr()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            _HomeCard(
              icon: Icons.flag_outlined,
              title: 'home.quests_title'.tr(),
              subtitle: 'home.quests_subtitle'.tr(),
              onTap: () => context.push(AppRoutes.questsList),
            ),
            const SizedBox(height: AppSpacing.sm),
            _HomeCard(
              icon: Icons.route_outlined,
              title: 'home.routes_title'.tr(),
              subtitle: 'home.routes_subtitle'.tr(),
              onTap: () => context.push(AppRoutes.routesList),
            ),
            const SizedBox(height: AppSpacing.sm),
            _HomeCard(
              icon: Icons.favorite_border,
              title: 'home.favorites_title'.tr(),
              subtitle: 'home.favorites_subtitle'.tr(),
              onTap: () => context.push(AppRoutes.favoritesTab),
            ),
            const SizedBox(height: AppSpacing.sm),
            _HomeCard(
              icon: Icons.checklist_outlined,
              title: 'home.todos_title'.tr(),
              subtitle: 'home.todos_subtitle'.tr(),
              onTap: () => context.push(AppRoutes.todos),
            ),
            const SizedBox(height: AppSpacing.sm),
            _HomeCard(
              icon: Icons.emoji_events_outlined,
              title: 'home.badges_title'.tr(),
              subtitle: 'home.badges_subtitle'.tr(),
              onTap: () => context.push(AppRoutes.badges),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                icon,
                color: theme.colorScheme.onPrimaryContainer,
                size: AppSpacing.iconMedium,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle,
                    style: AppTypography.bodyMedium.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
              size: AppSpacing.iconMedium,
            ),
          ],
        ),
      ),
    );
  }
}
