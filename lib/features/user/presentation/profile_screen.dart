import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/dialog_helper.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/hero_header.dart' show getRequiredExpForLevel, getExpRequiredToReachLevel;
import 'package:mobile/features/auth/application/auth_notifier.dart';
import 'package:mobile/features/user/application/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: profileAsync.when(
        loading: () => const Center(child: AppLoadingIndicator()),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(profileProvider),
          retryLabel: 'common.retry'.tr(),
        ),
        data: (user) {
          if (user == null) {
            return Center(child: Text('common.error_generic'.tr()));
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildProfileHeader(context, user),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    children: [
                      _buildLevelCard(context, user),
                      const SizedBox(height: AppSpacing.md),
                      _buildActionGrid(context),
                      const SizedBox(height: AppSpacing.lg),
                      _buildLogoutButton(context, ref),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, dynamic user) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  colorScheme.primaryContainer.withValues(alpha: 0.4),
                  colorScheme.surfaceContainerHighest,
                ]
              : [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.7),
                ],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: AppSpacing.lg),
            Hero(
              tag: 'profile-avatar',
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () => context.push(AppRoutes.profileEdit),
                  borderRadius: BorderRadius.circular(60),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: isDark
                        ? colorScheme.surfaceContainerHighest
                        : Colors.white.withValues(alpha: 0.3),
                    backgroundImage: user.profilePhotoUrl != null
                        ? NetworkImage(user.profilePhotoUrl!)
                        : null,
                    child: user.profilePhotoUrl == null
                        ? Icon(
                            Icons.person,
                            size: 50,
                            color: isDark
                                ? colorScheme.onSurfaceVariant
                                : Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '${user.firstName} ${user.lastName}',
              style: AppTypography.headlineSmall.copyWith(
                color: isDark ? colorScheme.onSurface : Colors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              user.email,
              style: AppTypography.bodyMedium.copyWith(
                color: isDark
                    ? colorScheme.onSurfaceVariant
                    : Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, dynamic user) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Calculate progress within current level using tiered system
    final expForCurrentLevel = user.expPoints - getExpRequiredToReachLevel(user.level);
    final requiredForNext = getRequiredExpForLevel(user.level);
    final progress = requiredForNext > 0 ? expForCurrentLevel / requiredForNext : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  colorScheme.primaryContainer,
                ],
              ),
            ),
            child: Center(
              child: Text(
                '${user.level}',
                style: AppTypography.headlineSmall.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'profile.level'.tr(namedArgs: {'level': user.level.toString()}),
                  style: AppTypography.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'profile.xp_label'.tr(args: [user.expPoints.toString()]),
                  style: AppTypography.bodySmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: progress),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  builder: (context, value, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 6,
                      backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    final actions = [
      (Icons.flag_outlined, 'profile.quests'.tr(), AppRoutes.userQuests),
      (Icons.route_outlined, 'profile.routes'.tr(), AppRoutes.userRoutes),
      (Icons.favorite_outline, 'profile.favorites'.tr(), AppRoutes.favoritesTab),
      (Icons.checklist_outlined, 'profile.todos'.tr(), AppRoutes.todos),
      (Icons.emoji_events_outlined, 'profile.badges'.tr(), AppRoutes.badges),
      (Icons.settings_outlined, 'settings.title'.tr(), AppRoutes.settings),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.1,
      children: actions.map((action) {
        return _ActionCard(
          icon: action.$1,
          label: action.$2,
          onTap: () => context.push(action.$3),
        );
      }).toList(),
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => _handleLogout(context, ref),
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: colorScheme.error.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: colorScheme.error.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: colorScheme.error, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'profile.logout'.tr(),
              style: AppTypography.titleSmall.copyWith(
                color: colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context, WidgetRef ref) {
    showAnimatedDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('profile.logout'.tr()),
        content: Text('profile.logout_confirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await ref.read(authNotifierProvider.notifier).logout();
              if (context.mounted) {
                context.go(AppRoutes.login);
              }
            },
            child: Text('profile.logout'.tr()),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: colorScheme.primary,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
