import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/utils/place_display_utils.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/features/places/data/dto/place_image.dart';
import 'package:photo_view/photo_view.dart';

class PhotoGalleryGrid extends StatelessWidget {
  const PhotoGalleryGrid({super.key, this.photoUrl, this.images});

  final String? photoUrl;
  final List<PlaceImage>? images;

  List<String> get _allPhotos {
    final result = <String>[];
    if (photoUrl != null && photoUrl!.trim().isNotEmpty) {
      result.add(photoUrl!);
    }
    if (images != null) {
      result.addAll(images!.map((img) => img.imageUrl).where((url) => url.trim().isNotEmpty));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final photos = _allPhotos;
    if (photos.isEmpty) {
      return EmptyState(
        icon: Icons.photo_library_outlined,
        title: 'place_detail.photos_empty_title'.tr(),
        description: 'place_detail.photos_empty_description'.tr(),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.xs),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppSpacing.xs,
        mainAxisSpacing: AppSpacing.xs,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final url = photos[index];
        return GestureDetector(
          onTap: () => _showFullScreen(context, url),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            child: CachedNetworkImage(
              imageUrl: url,
              httpHeaders: kNetworkImageHeaders,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              errorWidget: (_, __, ___) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFullScreen(BuildContext context, String url) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          backgroundColor: Colors.black,
          body: PhotoView(
            imageProvider: NetworkImage(url, headers: kNetworkImageHeaders),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }
}
