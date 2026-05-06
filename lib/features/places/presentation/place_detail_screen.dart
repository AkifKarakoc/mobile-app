import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/widgets/app_loading_indicator.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/places/application/place_detail_provider.dart';
import 'package:mobile/features/places/data/dto/place_detail_response.dart';
import 'package:mobile/features/places/presentation/widgets/place_info_tab.dart';
import 'package:mobile/features/places/presentation/widgets/place_photo_header.dart';
import 'package:mobile/features/reviews/presentation/reviews_tab.dart';

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
        loading: () => const AppLoadingIndicator(),
        error: (_, _) => ErrorView(
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

          return DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 0,
                  title: Text(title),
                  actions: [
                    IconButton(
                      tooltip: 'place_detail.refresh'.tr(),
                      onPressed: () => ref
                          .read(placeDetailProvider(placeId).notifier)
                          .refresh(),
                      icon: const Icon(Icons.refresh_outlined),
                    ),
                  ],
                ),
                PlacePhotoHeader(
                  place: place,
                  title: title,
                  onDirectionsPressed: () => _handleDirections(context, place),
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
                  _PhotosTab(place: place),
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('place_detail.directions_unavailable'.tr())),
    );
  }
}

class _PhotosTab extends StatelessWidget {
  const _PhotosTab({required this.place});

  final PlaceDetailResponse place;

  @override
  Widget build(BuildContext context) {
    final photoUrl = place.photoUrl;
    if (photoUrl == null || photoUrl.trim().isEmpty) {
      return EmptyState(
        icon: Icons.photo_library_outlined,
        title: 'place_detail.photos_empty_title'.tr(),
        description: 'place_detail.photos_empty_description'.tr(),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: Image.network(
            photoUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, _, _) => EmptyState(
              icon: Icons.broken_image_outlined,
              title: 'place_detail.photos_empty_title'.tr(),
              description: 'place_detail.photos_empty_description'.tr(),
            ),
          ),
        ),
      ],
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
