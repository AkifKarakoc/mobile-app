import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router/routes.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';
import 'level_ring.dart';

/// Returns the EXP required to advance from the given level to the next.
int getRequiredExpForLevel(int level) {
  if (level <= 4) return 100;
  if (level <= 9) return 200;
  if (level <= 14) return 350;
  return 500;
}

/// Returns the total EXP required to reach the given level (starting from level 1).
int getExpRequiredToReachLevel(int level) {
  int total = 0;
  for (int i = 1; i < level; i++) {
    total += getRequiredExpForLevel(i);
  }
  return total;
}

/// Hero header widget for the home screen.
///
/// Displays a welcome message, user avatar, level ring, and XP progress bar.
/// Used at the top of the home screen to show user status at a glance.
class HeroHeader extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String? profilePhotoUrl;
  final int level;
  final int expPoints;

  const HeroHeader({
    super.key,
    required this.firstName,
    required this.lastName,
    this.profilePhotoUrl,
    required this.level,
    required this.expPoints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final topPadding = MediaQuery.paddingOf(context).top;

    // Calculate progress within current level
    final expForCurrentLevel = expPoints - getExpRequiredToReachLevel(level);
    final requiredForNext = getRequiredExpForLevel(level);
    final progress = requiredForNext > 0 ? expForCurrentLevel / requiredForNext : 0.0;
    final expToNext = requiredForNext - expForCurrentLevel;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        topPadding + AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                  theme.colorScheme.surfaceContainerHighest,
                ]
              : [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withValues(alpha: 0.7),
                ],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: greeting + avatar
          Row(
            children: [
              // Greeting
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'home.welcome'.tr(args: [firstName]),
                      style: AppTypography.headlineSmall.copyWith(
                        color: isDark
                            ? theme.colorScheme.onSurface
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'home.welcome_subtitle'.tr(),
                      style: AppTypography.bodyMedium.copyWith(
                        color: isDark
                            ? theme.colorScheme.onSurfaceVariant
                            : Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // Avatar
              GestureDetector(
                onTap: () {
                  context.push(AppRoutes.profileView);
                },
                child: Hero(
                  tag: 'profile-avatar',
                  child: Material(
                    type: MaterialType.transparency,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: isDark
                          ? theme.colorScheme.surfaceContainerHighest
                          : Colors.white.withValues(alpha: 0.3),
                      backgroundImage: profilePhotoUrl != null
                          ? NetworkImage(profilePhotoUrl!)
                          : null,
                      child: profilePhotoUrl == null
                          ? Icon(
                              Icons.person,
                              size: 28,
                              color: isDark
                                  ? theme.colorScheme.onSurfaceVariant
                                  : Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Level + XP row
          Row(
            children: [
              // Level ring
              LevelRing(level: level, size: 60, showLabel: false),
              const SizedBox(width: AppSpacing.md),

              // XP progress
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'home.xp_to_next'.tr(
                        args: [expToNext.toString()],
                      ),
                      style: AppTypography.labelMedium.copyWith(
                        color: isDark
                            ? theme.colorScheme.onSurfaceVariant
                            : Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        minHeight: 6,
                        backgroundColor: isDark
                            ? theme.colorScheme.surfaceContainerHighest
                            : Colors.white.withValues(alpha: 0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDark ? theme.colorScheme.primary : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
