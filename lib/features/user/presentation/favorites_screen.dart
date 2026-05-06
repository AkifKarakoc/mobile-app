import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/places/data/places_repository.dart';
import 'package:mobile/features/user/application/favorites_provider.dart';

/// Favorites list screen
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('favorites.title').tr(),
        centerTitle: true,
      ),
      body: favoritesAsync.when(
        loading: () => const Center(child: AppLoadingIndicator()),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(favoritesProvider),
        ),
        data: (favorites) {
          if (favorites.isEmpty) {
            return EmptyState(
              icon: Icons.favorite_outline,
              title: 'favorites.empty'.tr(),
              description: 'favorites.empty_description'.tr(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return _FavoriteCard(
                favorite: favorite,
                onRemove: () =>
                    _handleRemoveFavorite(context, ref, favorite.id),
              );
            },
          );
        },
      ),
    );
  }

  void _handleRemoveFavorite(BuildContext context, WidgetRef ref, String id) {
    final messenger = ScaffoldMessenger.of(context);
    final errorColor = Theme.of(context).colorScheme.error;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('favorites.remove').tr(),
        content: Text('favorites.remove_confirm').tr(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('common.cancel').tr(),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              try {
                await ref.read(favoritesProvider.notifier).removeFavorite(id);
                messenger.showSnackBar(
                  SnackBar(content: Text('favorites.removed').tr()),
                );
              } catch (e) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                    backgroundColor: errorColor,
                  ),
                );
              }
            },
            child: Text('favorites.remove').tr(),
          ),
        ],
      ),
    );
  }
}

/// Individual favorite card widget
class _FavoriteCard extends ConsumerWidget {
  final dynamic favorite;
  final VoidCallback onRemove;

  const _FavoriteCard({required this.favorite, required this.onRemove});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeAsync = ref.watch(placeNameProvider(favorite.placeId));

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        leading: Icon(
          Icons.location_on,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: placeAsync.when(
          loading: () => const SizedBox(
            width: 80,
            height: 12,
            child: LinearProgressIndicator(),
          ),
          error: (_, _) => Text(
            'favorites.unknown_place'.tr(),
            style: AppTypography.labelLarge,
          ),
          data: (placeName) => Text(
            placeName,
            style: AppTypography.labelLarge,
          ),
        ),
        subtitle: Text(
          'favorites.saved_at'.tr(args: [
            favorite.savedAt.toString().split('.')[0],
          ]),
          style: AppTypography.bodySmall,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: onRemove,
        ),
        onTap: () {
          context.push(AppRoutes.placeDetailPath(favorite.placeId));
        },
      ),
    );
  }
}

/// Provider to fetch just the place name for a given place ID
final placeNameProvider =
    FutureProvider.family<String, String>((ref, placeId) async {
  final repository = ref.watch(placesRepositoryProvider);
  final place = await repository.getById(placeId);
  return place.name ?? place.nameTr ?? place.nameEn ?? 'favorites.unknown_place'.tr();
});
