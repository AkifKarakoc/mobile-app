import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/snackbar_helper.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/reviews/application/reviews_provider.dart';
import 'package:mobile/features/reviews/presentation/widgets/star_rating.dart';

class ReviewWriteSheet extends ConsumerStatefulWidget {
  const ReviewWriteSheet({super.key, required this.placeId});

  final String placeId;

  @override
  ConsumerState<ReviewWriteSheet> createState() => _ReviewWriteSheetState();
}

class _ReviewWriteSheetState extends ConsumerState<ReviewWriteSheet> {
  int _rating = 0;
  final _commentController = TextEditingController();
  bool _isLoading = false;

  static const int _maxLength = 2000;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_rating == 0) {
      showFloatingSnackBar(context, 'Lütfen bir puan seçin');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref
          .read(placeReviewsProvider(widget.placeId).notifier)
          .submitReview(
            rating: _rating,
            comment: _commentController.text.trim().isEmpty
                ? null
                : _commentController.text.trim(),
          );

      if (mounted) {
        Navigator.of(context).pop();
        showFloatingSnackBar(context, 'Yorumunuz incelemeye alındı');
      }
    } catch (e) {
      if (mounted) {
        showFloatingSnackBar(context, e.toString());
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final commentLength = _commentController.text.length;

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusCircle),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Değerlendirme Yaz', style: AppTypography.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          Center(
            child: StarRatingInput(
              value: _rating,
              onChanged: (value) => setState(() => _rating = value),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _commentController,
            maxLength: _maxLength,
            maxLines: 4,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Yorumunuzu yazın (isteğe bağlı)',
              counterText: '$commentLength / $_maxLength',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton.primary(
            label: 'Gönder',
            onPressed: _isLoading ? null : _submit,
            isLoading: _isLoading,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}
