import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/utils/snackbar_helper.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_loading_indicator.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/features/reviews/application/reviews_provider.dart';
import 'package:mobile/features/reviews/presentation/review_write_sheet.dart';
import 'package:mobile/features/reviews/presentation/widgets/review_card.dart';
import 'package:mobile/features/user/application/profile_provider.dart';

class ReviewsTab extends ConsumerWidget {
  const ReviewsTab({super.key, required this.placeId});

  final String placeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(placeReviewsProvider(placeId));
    final currentUserId = ref.watch(profileProvider).valueOrNull?.id;

    return reviewsAsync.when(
      loading: () => const AppLoadingIndicator(),
      error: (error, _) => EmptyState(
        icon: Icons.error_outline,
        title: 'Yorumlar yüklenemedi',
        description: error.toString(),
      ),
      data: (reviews) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: AppButton.primary(
              label: 'Yorum Yaz',
              onPressed: () => _showWriteReviewSheet(context, ref, placeId),
              fullWidth: true,
            ),
          ),
          Expanded(
            child: reviews.isEmpty
                ? const EmptyState(
                    icon: Icons.rate_review_outlined,
                    title: 'Henüz yorum yok',
                    description: 'Bu yer hakkında ilk yorumu sen yap!',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return ReviewCard(
                        review: review,
                        currentUserId: currentUserId,
                        onDelete:
                            currentUserId != null &&
                                review.userId == currentUserId
                            ? () => _deleteReview(context, ref, review.id)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showWriteReviewSheet(
    BuildContext context,
    WidgetRef ref,
    String placeId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      builder: (_) => ReviewWriteSheet(placeId: placeId),
    );
  }

  Future<void> _deleteReview(
    BuildContext context,
    WidgetRef ref,
    String reviewId,
  ) async {
    try {
      await ref
          .read(placeReviewsProvider(placeId).notifier)
          .deleteReview(reviewId);
    } catch (e) {
      if (context.mounted) {
        showFloatingSnackBar(context, e.toString());
      }
    }
  }
}
