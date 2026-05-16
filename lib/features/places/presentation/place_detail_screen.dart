import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/snackbar_helper.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/shimmer_placeholder.dart';
import 'package:mobile/features/places/application/place_detail_provider.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/presentation/widgets/favorite_toggle_button.dart';
import 'package:mobile/features/places/presentation/widgets/place_info_tab.dart';
import 'package:mobile/features/places/presentation/widgets/photo_gallery_grid.dart';
import 'package:mobile/features/places/presentation/widgets/quick_actions_row.dart';
import 'package:mobile/features/reviews/presentation/reviews_tab.dart';
import 'package:share_plus/share_plus.dart';

class PlaceDetailScreen extends ConsumerWidget {
  const PlaceDetailScreen({
    super.key,
    required this.placeId,
    this.onDirectionsPressed,
  });

  final String placeId;
  final ValueChanged<PlaceDetailResponse>? onDirectionsPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeAsync = ref.watch(placeDetailProvider(placeId));

    return Scaffold(
      body: placeAsync.when(
        loading: () => const DetailShimmer(),
        error: (_, __) => ErrorView(
          message: 'place_detail.error'.tr(),
          onRetry: () =>
              ref.read(placeDetailProvider(placeId).notifier).refresh(),
        ),
        data: (place) {
          if (!_hasContent(place)) {
            return EmptyState(
              icon: Icons.place_outlined,
              title: 'place_detail.empty_title'.tr(),
              description: 'place_detail.empty_description'.tr(),
            );
          }

          final title = _localizedName(context, place);
          final colorScheme = Theme.of(context).colorScheme;

          return DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 280,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        place.photoUrl != null && place.photoUrl!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: place.photoUrl!,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Container(
                                  color: colorScheme.surfaceContainerHighest,
                                ),
                                errorWidget: (_, __, ___) => Container(
                                  color: colorScheme.surfaceContainerHighest,
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                    size: 64,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              )
                            : Container(
                                color: colorScheme.surfaceContainerHighest,
                                child: Icon(
                                  Icons.photo_camera_outlined,
                                  size: 64,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                colorScheme.surface.withValues(alpha: 0.3),
                                colorScheme.surface.withValues(alpha: 0.85),
                              ],
                              stops: const [0.5, 0.8, 1.0],
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          top: MediaQuery.paddingOf(context).top + 16,
                          end: AppSpacing.md,
                          child: CircleAvatar(
                            backgroundColor:
                                colorScheme.surface.withValues(alpha: 0.92),
                            child: FavoriteToggleButton(placeId: placeId),
                          ),
                        ),
                        PositionedDirectional(
                          top: MediaQuery.paddingOf(context).top + 16,
                          start: AppSpacing.md,
                          child: CircleAvatar(
                            backgroundColor:
                                colorScheme.surface.withValues(alpha: 0.92),
                            child: IconButton(
                              tooltip: 'place_detail.share'.tr(),
                              onPressed: () => _sharePlace(context, place),
                              icon: const Icon(Icons.share_outlined),
                            ),
                          ),
                        ),
                        Positioned(
                          left: AppSpacing.md,
                          right: AppSpacing.md,
                          bottom: AppSpacing.md,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                title,
                                style: AppTypography.headlineSmall.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Wrap(
                                spacing: AppSpacing.xs,
                                runSpacing: AppSpacing.xs,
                                children: [
                                  if (place.category != null &&
                                      place.category!.trim().isNotEmpty)
                                    _InfoPill(
                                      icon: Icons.category_outlined,
                                      label: place.category!,
                                    ),
                                  if (place.avgRating != null)
                                    _InfoPill(
                                      icon: Icons.star_rounded,
                                      label:
                                          '${place.avgRating!.toStringAsFixed(1)}  (${place.reviewCount ?? 0})',
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: QuickActionsRow(
                    place: place,
                    onDirectionsPressed: () =>
                        _handleDirections(context, place),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sm),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarHeaderDelegate(
                    TabBar(
                      tabs: [
                        Tab(text: 'place_detail.tab_info'.tr()),
                        Tab(text: 'place_detail.tab_reviews'.tr()),
                        Tab(text: 'place_detail.tab_photos'.tr()),
                      ],
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                children: [
                  PlaceInfoTab(place: place),
                  ReviewsTab(placeId: placeId),
                  PhotoGalleryGrid(photoUrl: place.photoUrl, images: place.images),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _hasContent(PlaceDetailResponse place) {
    return [
      place.name,
      place.nameTr,
      place.nameEn,
      place.description,
      place.address,
      place.photoUrl,
    ].any((value) => value != null && value.trim().isNotEmpty);
  }

  String _localizedName(BuildContext context, PlaceDetailResponse place) {
    final languageCode = context.locale.languageCode;
    final candidates = [
      if (languageCode == 'tr') place.nameTr,
      if (languageCode == 'en') place.nameEn,
      place.name,
      place.nameTr,
      place.nameEn,
    ];

    for (final candidate in candidates) {
      final trimmed = candidate?.trim();
      if (trimmed != null && trimmed.isNotEmpty) {
        return trimmed;
      }
    }

    return 'place_detail.unknown_place'.tr();
  }

  void _handleDirections(BuildContext context, PlaceDetailResponse place) {
    final callback = onDirectionsPressed;
    if (callback != null) {
      callback(place);
      return;
    }

    if (place.latitude != null && place.longitude != null) {
      final url =
          'https://www.google.com/maps/dir/?api=1&destination=${place.latitude},${place.longitude}';
      Share.share(url);
    } else {
      showFloatingSnackBar(context, 'place_detail.directions_unavailable'.tr());
    }
  }

  void _sharePlace(BuildContext context, PlaceDetailResponse place) {
    final title = _localizedName(context, place);
    final text = place.description?.trim();
    Share.share(
      '$title\n\n${text ?? ''}',
      subject: title,
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSpacing.iconSmall, color: colorScheme.onPrimaryContainer),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  _TabBarHeaderDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_TabBarHeaderDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}
