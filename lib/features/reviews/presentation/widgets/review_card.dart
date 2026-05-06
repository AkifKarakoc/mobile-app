import 'package:flutter/material.dart';
import 'package:mobile/app/theme/app_colors.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/features/reviews/data/dto/review_response.dart';
import 'package:mobile/features/reviews/presentation/widgets/star_rating.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
    this.currentUserId,
    this.onDelete,
  });

  final ReviewResponse review;
  final String? currentUserId;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isOwner = currentUserId != null && review.userId == currentUserId;
    final initials = review.userId.length >= 2
        ? review.userId.substring(0, 2).toUpperCase()
        : review.userId.toUpperCase();
    final displayName = review.userId.length >= 8
        ? review.userId.substring(0, 8)
        : review.userId;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    initials,
                    style: AppTypography.labelMedium.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(displayName, style: AppTypography.titleSmall),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _formatDate(review.createdAt),
                        style: AppTypography.bodySmall.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isOwner && onDelete != null)
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline),
                    color: AppColors.errorLight,
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Yorumu sil',
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            StarRatingDisplay(rating: review.rating),
            if (review.comment != null && review.comment!.trim().isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(review.comment!.trim(), style: AppTypography.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(String createdAt) {
    try {
      final dt = DateTime.parse(createdAt).toLocal();
      return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}';
    } catch (_) {
      return createdAt;
    }
  }
}
