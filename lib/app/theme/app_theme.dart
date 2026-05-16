import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Smart Tourism Guide tema sistemi
/// Light ve dark tema tanımları
abstract final class AppTheme {
  // Light theme
  /// Light tema tanımı — sky blue primary, ocean blue secondary
  static ThemeData get light {
    const seedColor = AppColors.primaryLight;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      tertiary: AppColors.secondaryDarkLight,
      error: AppColors.errorLight,
      surface: AppColors.surfaceLight,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      // Text theme
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        displayMedium: AppTypography.displayMedium.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        displaySmall: AppTypography.displaySmall.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headlineLarge: AppTypography.headlineLarge.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headlineMedium: AppTypography.headlineMedium.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headlineSmall: AppTypography.headlineSmall.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        titleLarge: AppTypography.titleLarge.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        titleMedium: AppTypography.titleMedium.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        titleSmall: AppTypography.titleSmall.copyWith(
          color: AppColors.textSecondaryLight,
        ),
        bodyLarge: AppTypography.bodyLarge.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        bodyMedium: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        bodySmall: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondaryLight,
        ),
        labelLarge: AppTypography.labelLarge.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        labelMedium: AppTypography.labelMedium.copyWith(
          color: AppColors.textSecondaryLight,
        ),
        labelSmall: AppTypography.labelSmall.copyWith(
          color: AppColors.textSecondaryLight,
        ),
      ),
      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: AppColors.textPrimaryLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: 56,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppSpacing.radiusMd),
            bottomRight: Radius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),
      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: AppSpacing.elevationSm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          side: const BorderSide(color: AppColors.dividerLight, width: 1),
        ),
        margin: const EdgeInsets.all(AppSpacing.md),
      ),
      // ElevatedButton theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          elevation: AppSpacing.elevationSm,
        ),
      ),
      // TextButton theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),
      // OutlinedButton theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 1),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariantLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.dividerLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.dividerLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        labelStyle: AppTypography.labelMedium.copyWith(
          color: AppColors.textSecondaryLight,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textTertiary,
        ),
        errorStyle: AppTypography.bodySmall.copyWith(color: colorScheme.error),
      ),
      // Scaffold background
      scaffoldBackgroundColor: AppColors.backgroundLight,
      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerLight,
        thickness: 1,
        space: AppSpacing.md,
      ),
      // FloatingActionButton theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: AppSpacing.elevationMd,
      ),
    );
  }

  // Dark theme
  /// Dark tema tanımı — sky blue primary (lighter), ocean blue secondary
  static ThemeData get dark {
    const seedColor = AppColors.primaryDark;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      tertiary: AppColors.secondaryDark,
      error: AppColors.errorDark,
      surface: AppColors.surfaceDark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      // Text theme
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        displayMedium: AppTypography.displayMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        displaySmall: AppTypography.displaySmall.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineLarge: AppTypography.headlineLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineMedium: AppTypography.headlineMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineSmall: AppTypography.headlineSmall.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleLarge: AppTypography.titleLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleMedium: AppTypography.titleMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleSmall: AppTypography.titleSmall.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        bodyLarge: AppTypography.bodyLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodyMedium: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodySmall: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        labelLarge: AppTypography.labelLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        labelMedium: AppTypography.labelMedium.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        labelSmall: AppTypography.labelSmall.copyWith(
          color: AppColors.textSecondaryDark,
        ),
      ),
      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: 56,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppSpacing.radiusMd),
            bottomRight: Radius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),
      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: AppSpacing.elevationSm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          side: const BorderSide(color: AppColors.dividerDark, width: 1),
        ),
        margin: const EdgeInsets.all(AppSpacing.md),
      ),
      // ElevatedButton theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          elevation: AppSpacing.elevationSm,
        ),
      ),
      // TextButton theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),
      // OutlinedButton theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 1),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariantDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.dividerDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.dividerDark, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        labelStyle: AppTypography.labelMedium.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        errorStyle: AppTypography.bodySmall.copyWith(color: colorScheme.error),
      ),
      // Scaffold background
      scaffoldBackgroundColor: AppColors.backgroundDark,
      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: AppSpacing.md,
      ),
      // FloatingActionButton theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: AppSpacing.elevationMd,
      ),
    );
  }
}
