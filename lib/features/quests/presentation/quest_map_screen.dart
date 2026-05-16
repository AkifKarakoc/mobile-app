import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/core/widgets/shimmer_placeholder.dart';
import 'package:mobile/features/quests/application/quests_provider.dart';
import 'package:mobile/features/quests/data/dto/quest_detail_response.dart';

class QuestMapScreen extends ConsumerStatefulWidget {
  const QuestMapScreen({super.key, required this.questId});

  final String questId;

  @override
  ConsumerState<QuestMapScreen> createState() => _QuestMapScreenState();
}

class _QuestMapScreenState extends ConsumerState<QuestMapScreen> {
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final questAsync = ref.watch(questDetailProvider(widget.questId));

    return Scaffold(
      appBar: AppBar(
        title: Text('quests.map_title'.tr()),
      ),
      body: questAsync.when(
        data: (quest) => _buildMap(context, quest),
        loading: () => const DetailShimmer(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(questDetailProvider(widget.questId)),
        ),
      ),
    );
  }

  Widget _buildMap(BuildContext context, QuestDetailResponse quest) {
    final stepsWithLocation = quest.steps
        .where((s) => s.latitude != null && s.longitude != null)
        .toList();

    if (stepsWithLocation.isEmpty) {
      return Center(
        child: Text('quests.map_no_locations'.tr()),
      );
    }

    _markers.clear();
    for (int i = 0; i < stepsWithLocation.length; i++) {
      final step = stepsWithLocation[i];
      _markers.add(
        Marker(
          markerId: MarkerId('step-${step.id}'),
          position: LatLng(step.latitude!, step.longitude!),
          infoWindow: InfoWindow(
            title: step.placeName ?? 'quests.step'.tr() + ' ${i + 1}',
            snippet: step.isCompleted
                ? 'quests.completed'.tr()
                : 'quests.not_completed'.tr(),
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            step.isCompleted
                ? BitmapDescriptor.hueGreen
                : BitmapDescriptor.hueBlue,
          ),
          onTap: () => _onMarkerTap(context, step),
        ),
      );
    }

    final centerLat = stepsWithLocation
            .map((s) => s.latitude!)
            .reduce((a, b) => a + b) /
        stepsWithLocation.length;
    final centerLng = stepsWithLocation
            .map((s) => s.longitude!)
            .reduce((a, b) => a + b) /
        stepsWithLocation.length;

    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(centerLat, centerLng),
              zoom: 12,
            ),
            markers: _markers,
            onMapCreated: (_) {},
          ),
        ),
        _StepList(steps: stepsWithLocation),
      ],
    );
  }

  void _onMarkerTap(BuildContext context, StepResponse step) {
    context.push(AppRoutes.placeDetailPath(step.placeId));
  }
}

class _StepList extends StatelessWidget {
  const _StepList({required this.steps});

  final List<StepResponse> steps;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        itemCount: steps.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final step = steps[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: step.isCompleted
                  ? colorScheme.tertiaryContainer
                  : colorScheme.primaryContainer,
              child: Text(
                '${index + 1}',
                style: AppTypography.labelMedium.copyWith(
                  color: step.isCompleted
                      ? colorScheme.onTertiaryContainer
                      : colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            title: Text(
              step.placeName ?? 'quests.step'.tr() + ' ${index + 1}',
              style: AppTypography.bodyMedium.copyWith(
                decoration: step.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: step.isCompleted
                    ? colorScheme.outlineVariant
                    : null,
              ),
            ),
            subtitle: Text(
              step.hint ?? '',
              style: AppTypography.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: step.isCompleted
                ? Icon(Icons.check_circle, color: colorScheme.tertiary)
                : null,
            onTap: () {},
          );
        },
      ),
    );
  }
}
