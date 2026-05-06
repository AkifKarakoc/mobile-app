import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/favorites/application/favorites_provider.dart';

class FavoriteToggleButton extends ConsumerWidget {
  const FavoriteToggleButton({
    super.key,
    required this.placeId,
    this.size = 28,
  });

  final String placeId;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(favoriteStatusProvider(placeId));
    final favoritesAsync = ref.watch(favoritesProvider);
    final isBusy = favoritesAsync.isLoading || statusAsync.isLoading;

    return statusAsync.when(
      loading: () => _BusyFavoriteButton(size: size),
      error: (_, _) => IconButton(
        tooltip: 'place_detail.favorite_status_error'.tr(),
        onPressed: () => ref.invalidate(favoritesProvider),
        icon: Icon(
          Icons.favorite_border,
          size: size,
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      data: (status) {
        final isFavorited = status.isFavorited;

        return IconButton(
          tooltip:
              (isFavorited
                      ? 'place_detail.remove_favorite'
                      : 'place_detail.add_favorite')
                  .tr(),
          onPressed: isBusy
              ? null
              : () => _toggleFavorite(
                  context,
                  ref,
                  currentlyFavorited: isFavorited,
                  favoriteId: status.favoriteId,
                ),
          icon: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_border,
            size: size,
            color: isFavorited
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.onSurface,
          ),
        );
      },
    );
  }

  Future<void> _toggleFavorite(
    BuildContext context,
    WidgetRef ref, {
    required bool currentlyFavorited,
    required String? favoriteId,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    final errorColor = Theme.of(context).colorScheme.error;

    try {
      await ref
          .read(favoritesProvider.notifier)
          .toggleFavorite(
            placeId,
            currentlyFavorited: currentlyFavorited,
            favoriteId: favoriteId,
          );
      if (!context.mounted) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            (currentlyFavorited
                    ? 'place_detail.favorite_removed'
                    : 'place_detail.favorite_added')
                .tr(),
          ),
        ),
      );
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text('place_detail.favorite_error'.tr()),
          backgroundColor: errorColor,
        ),
      );
    }
  }
}

class _BusyFavoriteButton extends StatelessWidget {
  const _BusyFavoriteButton({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'common.loading'.tr(),
      onPressed: null,
      icon: SizedBox.square(
        dimension: size * 0.75,
        child: const CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
