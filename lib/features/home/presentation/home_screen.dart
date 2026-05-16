import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/active_quest_banner.dart';
import 'package:mobile/core/widgets/animated_card.dart';
import 'package:mobile/core/widgets/hero_header.dart';
import 'package:mobile/core/widgets/nearby_popular_places.dart';
import 'package:mobile/core/widgets/shimmer_placeholder.dart';
import 'package:mobile/features/user/application/profile_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      body: profileAsync.when(
        loading: () => const HomeShimmer(),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'common.error_generic'.tr(),
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton.icon(
                onPressed: () => ref.invalidate(profileProvider),
                icon: const Icon(Icons.refresh),
                label: Text('common.retry'.tr()),
              ),
            ],
          ),
        ),
        data: (user) {
          if (user == null) {
            return Center(
              child: Text('common.error_generic'.tr()),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(profileProvider),
            child: CustomScrollView(
              slivers: [
                // Hero header (pinned)
                SliverToBoxAdapter(
                  child: HeroHeader(
                    firstName: user.firstName,
                    lastName: user.lastName,
                    profilePhotoUrl: user.profilePhotoUrl,
                    level: user.level,
                    expPoints: user.expPoints,
                  ),
                ),

                // Active quest/route banner
                const SliverToBoxAdapter(
                  child: ActiveQuestBanner(),
                ),

                // Nearby popular places
                const SliverToBoxAdapter(
                  child: NearbyPopularPlaces(),
                ),

                // Content section
                SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section title
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.md,
                          ),
                          child: Text(
                            'home.explore'.tr(),
                            style: AppTypography.titleLarge,
                          ),
                        ),

                        // 2-column grid: Quests + Routes
                        Row(
                          children: [
                            Expanded(
                              child: AnimatedCard(
                                delayMs: 100,
                                onTap: () =>
                                    context.push(AppRoutes.questsList),
                                child: _FeatureCard(
                                  icon: Icons.flag_outlined,
                                  title: 'home.quests_title'.tr(),
                                  subtitle: 'home.quests_subtitle'.tr(),
                                  gradient: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withValues(alpha: 0.7),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: AnimatedCard(
                                delayMs: 200,
                                onTap: () =>
                                    context.push(AppRoutes.routesList),
                                child: _FeatureCard(
                                  icon: Icons.route_outlined,
                                  title: 'home.routes_title'.tr(),
                                  subtitle: 'home.routes_subtitle'.tr(),
                                  gradient: [
                                    Theme.of(context).colorScheme.secondary,
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withValues(alpha: 0.7),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppSpacing.sm),

                        // 2-column grid: Favorites + Todos
                        Row(
                          children: [
                            Expanded(
                              child: AnimatedCard(
                                delayMs: 300,
                                onTap: () =>
                                    context.push(AppRoutes.favoritesTab),
                                child: _FeatureCard(
                                  icon: Icons.favorite_border,
                                  title: 'home.favorites_title'.tr(),
                                  subtitle: 'home.favorites_subtitle'.tr(),
                                  gradient: [
                                    Theme.of(context).colorScheme.error,
                                    Theme.of(context)
                                        .colorScheme
                                        .error
                                        .withValues(alpha: 0.7),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: AnimatedCard(
                                delayMs: 400,
                                onTap: () => context.push(AppRoutes.todos),
                                child: _FeatureCard(
                                  icon: Icons.checklist_outlined,
                                  title: 'home.todos_title'.tr(),
                                  subtitle: 'home.todos_subtitle'.tr(),
                                  gradient: [
                                    Theme.of(context).colorScheme.tertiary,
                                    Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withValues(alpha: 0.7),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppSpacing.sm),

                        // Badges (full width)
                        AnimatedCard(
                          delayMs: 500,
                          onTap: () => context.push(AppRoutes.badges),
                          child: _FeatureCard(
                            icon: Icons.emoji_events_outlined,
                            title: 'home.badges_title'.tr(),
                            subtitle: 'home.badges_subtitle'.tr(),
                            gradient: [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withValues(alpha: 0.7),
                            ],
                            fullWidth: true,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xl),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Feature card with gradient background, icon, and text.
class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final bool fullWidth;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.white;

    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(
              icon,
              color: textColor,
              size: AppSpacing.iconMedium,
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleMedium.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: textColor.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),

          // Chevron
          Icon(
            Icons.chevron_right,
            color: textColor.withValues(alpha: 0.7),
            size: AppSpacing.iconMedium,
          ),
        ],
      ),
    );
  }
}
