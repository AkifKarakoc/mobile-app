import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/dialog_helper.dart';
import 'package:mobile/core/utils/place_display_utils.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/data/places_repository.dart';
import 'package:mobile/features/user/application/favorites_provider.dart';
import 'package:mobile/features/user/data/dto/favorite_response.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('favorites.title'.tr(), style: AppTypography.titleLarge),
        centerTitle: false,
      ),
      body: favoritesAsync.when(
        loading: () => const Center(child: AppLoadingIndicator()),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(favoritesProvider),
          retryLabel: 'common.retry'.tr(),
        ),
        data: (favorites) {
          if (favorites.isEmpty) {
            return EmptyState(
              icon: Icons.favorite_outline,
              title: 'favorites.empty'.tr(),
              description: 'favorites.empty_description'.tr(),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: favorites.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
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

    showAnimatedDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('favorites.remove'.tr()),
        content: Text('favorites.remove_confirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              try {
                await ref.read(favoritesProvider.notifier).removeFavorite(id);
                messenger.showSnackBar(
                  SnackBar(content: Text('favorites.removed'.tr())),
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
            child: Text('favorites.remove'.tr()),
          ),
        ],
      ),
    );
  }
}

class _FavoriteCard extends ConsumerWidget {
  final FavoriteResponse favorite;
  final VoidCallback onRemove;

  const _FavoriteCard({required this.favorite, required this.onRemove});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final placeAsync = ref.watch(placeDetailProvider(favorite.placeId));

    return InkWell(
      onTap: () => context.push(AppRoutes.placeDetailPath(favorite.placeId)),
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: Container(
        height: 128,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(AppSpacing.radiusLg),
              ),
              child: SizedBox(
                width: 128,
                child: placeAsync.when(
                  loading: () => _placeholderImage(context),
                  error: (_, __) => _placeholderImage(context),
                  data: (place) => _placeImage(context, place),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    placeAsync.when(
                      loading: () => SizedBox(
                        width: 120,
                        height: 16,
                        child: LinearProgressIndicator(
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          color: colorScheme.primary,
                        ),
                      ),
                      error: (_, __) => Text(
                        'favorites.unknown_place'.tr(),
                        style: AppTypography.titleSmall,
                      ),
                      data: (place) => Text(
                        place.name ??
                            place.nameTr ??
                            place.nameEn ??
                            'favorites.unknown_place'.tr(),
                        style: AppTypography.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    placeAsync.maybeWhen(
                      data: (place) => _buildCategoryChip(context, place),
                      orElse: () => const SizedBox.shrink(),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.bookmark_outlined,
                              size: 14,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              _formatSavedDate(favorite.savedAt),
                              style: AppTypography.bodySmall.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: colorScheme.error,
                            size: 20,
                          ),
                          onPressed: onRemove,
                          visualDensity: VisualDensity.compact,
                          tooltip: 'favorites.remove'.tr(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeImage(BuildContext context, PlaceDetailResponse place) {
    final imageUrl = place.photoUrl;

    if (imageUrl == null || imageUrl.isEmpty) {
      return _placeholderImage(context);
    }

    return Image.network(
      imageUrl,
      headers: kNetworkImageHeaders,
      width: 128,
      height: 128,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _placeholderImage(context),
    );
  }

  Widget _placeholderImage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 128,
      height: 128,
      color: colorScheme.primaryContainer.withValues(alpha: 0.3),
      child: Icon(
        Icons.location_on_outlined,
        color: colorScheme.primary,
        size: 32,
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, PlaceDetailResponse place) {
    final colorScheme = Theme.of(context).colorScheme;
    final categoryLabel = formatPlaceCategoryLabel(place.category);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        categoryLabel,
        style: AppTypography.labelSmall.copyWith(
          color: colorScheme.secondary,
        ),
      ),
    );
  }

  String _formatSavedDate(DateTime savedAt) {
    final now = DateTime.now();
    final difference = now.difference(savedAt);

    if (difference.inDays == 0) {
      return 'notifications.just_now'.tr();
    } else if (difference.inDays < 7) {
      return 'notifications.days_ago'.tr(namedArgs: {'count': difference.inDays.toString()});
    } else {
      return '${savedAt.day.toString().padLeft(2, '0')}.${savedAt.month.toString().padLeft(2, '0')}.${savedAt.year}';
    }
  }
}

final placeDetailProvider = FutureProvider.family<PlaceDetailResponse, String>((
  ref,
  placeId,
) async {
  final repository = ref.watch(placesRepositoryProvider);
  return repository.getById(placeId);
});
