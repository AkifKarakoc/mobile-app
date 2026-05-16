import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/utils/snackbar_helper.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/features/routes/application/routes_provider.dart';
import 'package:mobile/core/network/api_exception.dart';
import 'package:permission_handler/permission_handler.dart';

class RouteStopCompleteScreen extends ConsumerStatefulWidget {
  final String routeId;
  final String routePlaceId;
  final String placeName;
  final double? targetLatitude;
  final double? targetLongitude;
  final int gpsThresholdMeters;

  const RouteStopCompleteScreen({
    super.key,
    required this.routeId,
    required this.routePlaceId,
    required this.placeName,
    this.targetLatitude,
    this.targetLongitude,
    this.gpsThresholdMeters = 200,
  });

  @override
  ConsumerState<RouteStopCompleteScreen> createState() =>
      _RouteStopCompleteScreenState();
}

class _RouteStopCompleteScreenState
    extends ConsumerState<RouteStopCompleteScreen> {
  Position? _position;
  bool _isSubmitting = false;
  String? _errorMessage;
  double? _distanceToTarget;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    try {
      final locationStatus = await Permission.location.request().timeout(
        const Duration(seconds: 5),
        onTimeout: () => PermissionStatus.denied,
      );

      if (!mounted) return;

      if (locationStatus.isDenied || locationStatus.isPermanentlyDenied) {
        setState(() {
          _errorMessage = 'route_stop.location_permission'.tr();
        });
        if (locationStatus.isPermanentlyDenied) {
          await openAppSettings();
        }
        return;
      }

      await _getCurrentLocation();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'route_stop.gps_error'.tr();
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final hasPermission = await Geolocator.isLocationServiceEnabled();
      if (!hasPermission) {
        setState(() {
          _errorMessage = 'route_stop.gps_error'.tr();
        });
        return;
      }

      final position =
          await Geolocator.getCurrentPosition(
            locationSettings: AndroidSettings(
              accuracy: LocationAccuracy.high,
              timeLimit: const Duration(seconds: 5),
            ),
          ).timeout(
            const Duration(seconds: 8),
            onTimeout: () {
              throw TimeoutException('Konum alınamadı - zaman aşımı');
            },
          );

      if (position.accuracy > 50) {
        setState(() {
          _errorMessage = 'route_stop.gps_accuracy_error'.tr();
        });
        return;
      }

      double? distance;
      if (widget.targetLatitude != null && widget.targetLongitude != null) {
        distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          widget.targetLatitude!,
          widget.targetLongitude!,
        );
      }

      setState(() {
        _position = position;
        _distanceToTarget = distance;
        _errorMessage = null;
      });
    } on TimeoutException {
      setState(() {
        _errorMessage = 'route_stop.gps_error'.tr();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'route_stop.gps_error'.tr();
      });
    }
  }

  Future<void> _submitCompletion() async {
    if (_position == null) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final result = await ref
          .read(routeDetailProvider(widget.routeId).notifier)
          .completeRouteStop(
            routePlaceId: widget.routePlaceId,
            latitude: _position!.latitude,
            longitude: _position!.longitude,
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('Doğrulama zaman aşımına uğradı');
            },
          );

      if (!mounted) return;

      showFloatingSnackBar(
        context,
        result.routeCompleted
            ? 'route_stop.route_completed'.tr()
            : 'route_stop.stop_completed'.tr(
                args: [result.expEarned.toString()],
              ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      );

      Navigator.of(context).pop(true);
    } on TimeoutException {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Doğrulama işlemi çok uzun sürdü, tekrar deneyin.';
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      if (!mounted) return;
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
        title: Text('route_stop.title'.tr()),
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
                    _buildPlaceInfo(),
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
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceInfo() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.primary,
                size: AppSpacing.iconLarge,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  widget.placeName,
                  style: AppTypography.headlineSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'route_stop.instructions'.tr(),
            style: AppTypography.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                      ? 'route_stop.location_acquired'.tr()
                      : 'route_stop.location_permission'.tr(),
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
          if (_distanceToTarget != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(
                  Icons.near_me,
                  size: AppSpacing.iconMedium,
                  color: _distanceToTarget! <= widget.gpsThresholdMeters
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    _formatDistance(_distanceToTarget!),
                    style: AppTypography.bodyMedium.copyWith(
                      color: _distanceToTarget! <= widget.gpsThresholdMeters
                          ? Theme.of(context).colorScheme.tertiary
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDistance(double meters) {
    if (meters < 1000) {
      return 'route_stop.distance_meters'.tr(
        namedArgs: {'distance': meters.round().toString()},
      );
    }
    return 'route_stop.distance_kilometers'.tr(
      namedArgs: {'distance': (meters / 1000).toStringAsFixed(1)},
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

  Widget _buildActionButton() {
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
      child: AppButton(
        label: 'route_stop.complete'.tr(),
        variant: AppButtonVariant.primary,
        icon: Icons.check_circle_outline,
        onPressed: (_position != null && !_isSubmitting)
            ? _submitCompletion
            : null,
        isLoading: _isSubmitting,
      ),
    );
  }
}
