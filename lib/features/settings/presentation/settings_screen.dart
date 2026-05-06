import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/features/settings/application/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = context.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr()),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Language section
          _SectionTitle(title: 'settings.language'.tr()),
          _LanguageTile(
            locale: const Locale('tr'),
            label: 'Türkçe',
            selected: locale.languageCode == 'tr',
          ),
          _LanguageTile(
            locale: const Locale('en'),
            label: 'English',
            selected: locale.languageCode == 'en',
          ),
          _LanguageTile(
            locale: const Locale('de'),
            label: 'Deutsch',
            selected: locale.languageCode == 'de',
          ),

          const SizedBox(height: AppSpacing.lg),

          // Theme section
          _SectionTitle(title: 'settings.theme'.tr()),
          _ThemeTile(
            mode: ThemeMode.light,
            label: 'settings.theme_light'.tr(),
            icon: Icons.light_mode_outlined,
            selected: themeMode == ThemeMode.light,
          ),
          _ThemeTile(
            mode: ThemeMode.dark,
            label: 'settings.theme_dark'.tr(),
            icon: Icons.dark_mode_outlined,
            selected: themeMode == ThemeMode.dark,
          ),
          _ThemeTile(
            mode: ThemeMode.system,
            label: 'settings.theme_system'.tr(),
            icon: Icons.brightness_auto_outlined,
            selected: themeMode == ThemeMode.system,
          ),

          const SizedBox(height: AppSpacing.lg),

          // About section
          _SectionTitle(title: 'settings.about'.tr()),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'app.name'.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'app.tagline'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'v0.1.0',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final Locale locale;
  final String label;
  final bool selected;

  const _LanguageTile({
    required this.locale,
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: selected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
          : null,
      onTap: () {
        context.setLocale(locale);
      },
    );
  }
}

class _ThemeTile extends ConsumerWidget {
  final ThemeMode mode;
  final String label;
  final IconData icon;
  final bool selected;

  const _ThemeTile({
    required this.mode,
    required this.label,
    required this.icon,
    required this.selected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: selected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
          : null,
      onTap: () {
        ref.read(themeModeProvider.notifier).setThemeMode(mode);
      },
    );
  }
}
