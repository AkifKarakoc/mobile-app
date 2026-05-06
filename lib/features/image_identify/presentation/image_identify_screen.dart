import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/app/theme/app_colors.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/loading_indicator.dart';
import 'package:mobile/features/image_identify/application/image_identify_provider.dart';
import 'package:mobile/features/image_identify/data/dto/image_analysis_response.dart';
import 'package:mobile/features_shared/permissions/permission_helper.dart' as perms;

class ImageIdentifyScreen extends ConsumerStatefulWidget {
  const ImageIdentifyScreen({super.key});

  @override
  ConsumerState<ImageIdentifyScreen> createState() =>
      _ImageIdentifyScreenState();
}

class _ImageIdentifyScreenState extends ConsumerState<ImageIdentifyScreen> {
  File? _selectedPhoto;
  Position? _currentPosition;
  bool _locationLoading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() => _locationLoading = true);
    try {
      final hasPermission = await perms.checkLocationPermission();
      if (!hasPermission) {
        final granted = await perms.requestLocationPermission();
        if (!granted) {
          setState(() => _locationLoading = false);
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      setState(() {
        _currentPosition = position;
        _locationLoading = false;
      });
    } catch (_) {
      setState(() => _locationLoading = false);
    }
  }

  Future<void> _takePhoto() async {
    final hasPermission = await perms.checkCameraPermission();
    if (!hasPermission) {
      final granted = await perms.requestCameraPermission();
      if (!granted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('image_identify.camera_permission'.tr())),
          );
        }
        return;
      }
    }

    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() => _selectedPhoto = File(photo.path));
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() => _selectedPhoto = File(photo.path));
    }
  }

  Future<void> _identify() async {
    if (_selectedPhoto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('image_identify.no_photo'.tr())),
      );
      return;
    }

    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('image_identify.gps_error'.tr())),
      );
      return;
    }

    final bytes = await _selectedPhoto!.readAsBytes();
    final multipartFile = MultipartFile.fromBytes(
      bytes,
      filename: 'photo.jpg',
      contentType: DioMediaType('image', 'jpeg'),
    );

    if (mounted) {
      await ref.read(imageIdentifyProvider.notifier).identifyImage(
        photo: multipartFile,
        latitude: _currentPosition!.latitude,
        longitude: _currentPosition!.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final identifyState = ref.watch(imageIdentifyProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text('image_identify.title'.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPhotoSection(),
            const SizedBox(height: AppSpacing.md),
            _buildLocationSection(),
            const SizedBox(height: AppSpacing.md),
            AppButton.primary(
              label: 'image_identify.identify'.tr(),
              icon: Icons.auto_awesome,
              onPressed: _selectedPhoto != null && !_locationLoading
                  ? _identify
                  : null,
              isLoading: identifyState.isLoading,
              fullWidth: true,
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildResultSection(identifyState),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoSection() {
    if (_selectedPhoto != null) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            child: Image.file(
              _selectedPhoto!,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: _takePhoto,
                icon: const Icon(Icons.camera_alt),
                label: Text('image_identify.take_photo'.tr()),
              ),
              const SizedBox(width: AppSpacing.sm),
              TextButton.icon(
                onPressed: _pickFromGallery,
                icon: const Icon(Icons.photo_library),
                label: Text('image_identify.choose_gallery'.tr()),
              ),
            ],
          ),
        ],
      );
    }

    return EmptyState(
      icon: Icons.camera_alt_outlined,
      title: 'image_identify.take_photo'.tr(),
      description: 'image_identify.choose_gallery'.tr(),
      actionLabel: 'image_identify.take_photo'.tr(),
      onAction: _takePhoto,
    );
  }

  Widget _buildLocationSection() {
    if (_locationLoading) {
      return Row(
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'image_identify.location_permission'.tr(),
            style: AppTypography.bodyMedium,
          ),
        ],
      );
    }

    if (_currentPosition != null) {
      return Row(
        children: [
          Icon(
            Icons.location_on,
            color: Theme.of(context).colorScheme.primary,
            size: AppSpacing.iconMedium,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '${_currentPosition!.latitude.toStringAsFixed(4)}, ${_currentPosition!.longitude.toStringAsFixed(4)}',
            style: AppTypography.bodyMedium,
          ),
        ],
      );
    }

    return Row(
      children: [
        Icon(
          Icons.location_off,
          color: Theme.of(context).colorScheme.error,
          size: AppSpacing.iconMedium,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          'image_identify.gps_error'.tr(),
          style: AppTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        TextButton(
          onPressed: _fetchLocation,
          child: Text('common.retry'.tr()),
        ),
      ],
    );
  }

  Widget _buildResultSection(AsyncValue<ImageAnalysisResponse> state) {
    return state.when(
      data: (result) => _ResultCard(result: result),
      loading: () => const AppLoadingIndicator(),
      error: (error, stack) => ErrorView(
        message: error.toString(),
        onRetry: _identify,
        retryLabel: 'common.retry'.tr(),
      ),
      skipLoadingOnReload: false,
    );
  }
}

class _ResultCard extends StatelessWidget {
  final ImageAnalysisResponse result;

  const _ResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final isLowConfidence = result.confidence < 0.5;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'image_identify.result_title'.tr(),
              style: AppTypography.titleMedium.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              result.placeName,
              style: AppTypography.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'image_identify.confidence'.tr(),
              style: AppTypography.labelMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            LinearProgressIndicator(
              value: result.confidence,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                isLowConfidence
                    ? AppColors.warningLight
                    : Theme.of(context).colorScheme.primary,
              ),
              minHeight: 8,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${(result.confidence * 100).toStringAsFixed(1)}%',
              style: AppTypography.bodySmall.copyWith(
                color: isLowConfidence
                    ? AppColors.warningLight
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
            if (isLowConfidence) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                'image_identify.low_confidence'.tr(),
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.warningLight,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            Text(
              'image_identify.description'.tr(),
              style: AppTypography.labelMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              result.description,
              style: AppTypography.bodyMedium,
            ),
            if (result.imageUrl.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                child: Image.network(
                  result.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
