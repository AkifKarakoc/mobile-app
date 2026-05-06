import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/auth/application/auth_notifier.dart';
import 'package:mobile/features/user/application/profile_provider.dart';

/// User profile screen
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(title: Text('profile.title').tr(), centerTitle: true),
      body: profileAsync.when(
        loading: () => const Center(child: AppLoadingIndicator()),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(profileProvider),
        ),
        data: (user) {
          if (user == null) {
            return Center(child: Text('common.error_generic'.tr()));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Avatar section
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      // Profile photo circle
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        backgroundImage: user.profilePhotoUrl != null
                            ? NetworkImage(user.profilePhotoUrl!)
                            : null,
                        child: user.profilePhotoUrl == null
                            ? Icon(
                                Icons.person,
                                size: 60,
                                color: Theme.of(context).colorScheme.outline,
                              )
                            : null,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // User name
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: AppTypography.headlineSmall,
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Email
                      Text(
                        user.email,
                        style: AppTypography.bodyMedium.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),

                // Level and XP section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Column(
                    children: [
                      // Level circle
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'profile.level'.tr(args: [user.level.toString()]),
                            style: AppTypography.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // XP bar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'profile.xp_label'.tr(
                              args: [user.expPoints.toString()],
                            ),
                            style: AppTypography.labelMedium,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              minHeight: 8,
                              value:
                                  (user.expPoints % 1000) /
                                  1000, // Simplified: 1000 XP per level
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.outline,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Column(
                    children: [
                      // Edit profile button
                      AppButton.primary(
                        label: 'profile.edit'.tr(),
                        onPressed: () => _navigateToEditProfile(context),
                        fullWidth: true,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Quests button
                      AppButton.secondary(
                        label: 'profile.quests'.tr(),
                        icon: Icons.flag_outlined,
                        onPressed: () => _navigateToQuests(context),
                        fullWidth: true,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Routes button
                      AppButton.secondary(
                        label: 'profile.routes'.tr(),
                        icon: Icons.route_outlined,
                        onPressed: () => _navigateToRoutes(context),
                        fullWidth: true,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Favorites button
                      AppButton.secondary(
                        label: 'profile.favorites'.tr(),
                        onPressed: () => _navigateToFavorites(context),
                        fullWidth: true,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Todos button
                      AppButton.secondary(
                        label: 'profile.todos'.tr(),
                        icon: Icons.checklist_outlined,
                        onPressed: () => _navigateToTodos(context),
                        fullWidth: true,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Badges button
                      AppButton.secondary(
                        label: 'profile.badges'.tr(),
                        icon: Icons.emoji_events_outlined,
                        onPressed: () => _navigateToBadges(context),
                        fullWidth: true,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Settings button
                      AppButton.secondary(
                        label: 'settings.title'.tr(),
                        onPressed: () => _navigateToSettings(context),
                        fullWidth: true,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Logout button
                      AppButton.text(
                        label: 'profile.logout'.tr(),
                        onPressed: () => _handleLogout(context, ref),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    context.push(AppRoutes.profileEdit);
  }

  void _navigateToFavorites(BuildContext context) {
    context.push(AppRoutes.favoritesTab);
  }

  void _navigateToSettings(BuildContext context) {
    context.push(AppRoutes.settings);
  }

  void _navigateToRoutes(BuildContext context) {
    context.push(AppRoutes.routesList);
  }

  void _navigateToQuests(BuildContext context) {
    context.push(AppRoutes.questsList);
  }

  void _navigateToBadges(BuildContext context) {
    context.push(AppRoutes.badges);
  }

  void _navigateToTodos(BuildContext context) {
    context.push(AppRoutes.todos);
  }

  void _handleLogout(BuildContext context, WidgetRef ref) {
    showDialog(
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
