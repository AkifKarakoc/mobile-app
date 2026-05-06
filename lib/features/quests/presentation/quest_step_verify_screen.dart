import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/quests/application/quests_provider.dart';
import 'package:mobile/features/quests/presentation/quest_verify_result_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class QuestStepVerifyScreen extends ConsumerStatefulWidget {
  final String questId;
  final String stepId;

  const QuestStepVerifyScreen({
    super.key,
    required this.questId,
    required this.stepId,
  });

  @override
  ConsumerState<QuestStepVerifyScreen> createState() =>
      _QuestStepVerifyScreenState();
}

class _QuestStepVerifyScreenState extends ConsumerState<QuestStepVerifyScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _photo;
  Position? _position;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final locationStatus = await Permission.location.request();
    if (locationStatus.isDenied || locationStatus.isPermanentlyDenied) {
      setState(() {
        _errorMessage = 'quest_verify.location_permission'.tr();
      });
      if (locationStatus.isPermanentlyDenied) {
        await openAppSettings();
      }
      return;
    }

    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final hasPermission = await Geolocator.isLocationServiceEnabled();
      if (!hasPermission) {
        setState(() {
          _errorMessage = 'quest_verify.gps_error'.tr();
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.best,
          timeLimit: const Duration(seconds: 15),
        ),
      );

      if (position.accuracy > 50) {
        setState(() {
          _errorMessage = 'quest_verify.gps_accuracy_error'.tr();
        });
        return;
      }

      setState(() {
        _position = position;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'quest_verify.gps_error'.tr();
      });
    }
  }

  Future<void> _takePhoto() async {
    final cameraStatus = await Permission.camera.request();
    if (cameraStatus.isDenied || cameraStatus.isPermanentlyDenied) {
      setState(() {
        _errorMessage = 'quest_verify.camera_permission'.tr();
      });
      if (cameraStatus.isPermanentlyDenied) {
        await openAppSettings();
      }
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _photo = File(image.path);
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'quest_verify.taking_photo'.tr();
      });
    }
  }

  Future<void> _submitVerification() async {
    if (_photo == null || _position == null) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final multipartFile = await MultipartFile.fromFile(
        _photo!.path,
        filename: 'quest_verification.jpg',
      );

      final result = await ref.read(questDetailProvider(widget.questId).notifier)
          .verifyStep(
        stepId: widget.stepId,
        photo: multipartFile,
        latitude: _position!.latitude,
        longitude: _position!.longitude,
      );

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => QuestVerifyResultScreen(result: result),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('quest_verify.title'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildPhotoArea(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildGpsStatus(),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      _buildErrorBanner(),
                    ],
                  ],
                ),
              ),
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoArea() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: _photo != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              child: Image.file(
                _photo!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'quest_verify.take_photo'.tr(),
                    style: AppTypography.bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildGpsStatus() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            _position != null
                ? Icons.location_on
                : Icons.location_off_outlined,
            color: _position != null
                ? Theme.of(context).colorScheme.tertiary
                : Theme.of(context).colorScheme.outlineVariant,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              _position != null
                  ? 'quest_verify.location_accuracy'.tr(
                      args: [
                        _position!.accuracy.toStringAsFixed(1),
                      ],
                    )
                  : 'quest_verify.location_permission'.tr(),
              style: AppTypography.bodyMedium,
            ),
          ),
          if (_position != null)
            IconButton(
              icon: const Icon(Icons.refresh, size: AppSpacing.iconMedium),
              onPressed: _getCurrentLocation,
            ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        _errorMessage!,
        style: AppTypography.bodySmall.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: AppSpacing.elevationSm,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              label: _photo != null
                  ? 'quest_verify.retake_photo'.tr()
                  : 'quest_verify.take_photo'.tr(),
              variant: AppButtonVariant.secondary,
              icon: Icons.camera_alt_outlined,
              onPressed: _isSubmitting ? null : _takePhoto,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: AppButton(
              label: 'quest_verify.submit'.tr(),
              variant: AppButtonVariant.primary,
              onPressed: (_photo != null && _position != null && !_isSubmitting)
                  ? _submitVerification
                  : null,
              isLoading: _isSubmitting,
            ),
          ),
        ],
      ),
    );
  }
}
