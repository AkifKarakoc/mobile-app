import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/app/theme/app_typography.dart';
import 'package:mobile/core/widgets/app_loading_indicator.dart';
import 'package:mobile/core/widgets/app_text_field.dart';
import 'package:mobile/core/widgets/empty_state.dart';
import 'package:mobile/core/widgets/error_view.dart';
import 'package:mobile/features/places/application/place_search_provider.dart';
import 'package:mobile/features/places/presentation/widgets/place_search_result_tile.dart';

class PlaceSearchScreen extends ConsumerStatefulWidget {
  const PlaceSearchScreen({super.key});

  @override
  ConsumerState<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends ConsumerState<PlaceSearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(placeSearchProvider);
    _syncController(searchState.query);

    return Scaffold(
      appBar: AppBar(
        title: Text('places.search.title'.tr()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: AppTextField(
                controller: _controller,
                hint: 'places.search.hint'.tr(),
                prefixIcon: Icons.search,
                suffix: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'places.search.clear_query'.tr(),
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          ref.read(placeSearchProvider.notifier).clearQuery();
                        },
                      ),
                textInputAction: TextInputAction.search,
                onChanged: ref.read(placeSearchProvider.notifier).updateQuery,
                onSubmitted: (value) {
                  unawaited(
                    ref
                        .read(placeSearchProvider.notifier)
                        .searchFromRecent(value),
                  );
                },
              ),
            ),
            Expanded(child: _SearchContent(state: searchState)),
          ],
        ),
      ),
    );
  }

  void _syncController(String query) {
    if (_controller.text == query) {
      return;
    }

    _controller.value = TextEditingValue(
      text: query,
      selection: TextSelection.collapsed(offset: query.length),
    );
  }
}

class _SearchContent extends ConsumerWidget {
  const _SearchContent({required this.state});

  final PlaceSearchState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!state.hasQuery) {
      return _RecentSearchesList(recentSearches: state.recentSearches);
    }

    if (state.isQueryTooShort) {
      return EmptyState(
        icon: Icons.search,
        title: 'places.search.min_query_title'.tr(
          namedArgs: {'count': PlaceSearchNotifier.minQueryLength.toString()},
        ),
        description: 'places.search.min_query_description'.tr(),
      );
    }

    return state.results.when(
      loading: () => AppLoadingIndicator(semanticsLabel: 'common.loading'.tr()),
      error: (error, stackTrace) => ErrorView(
        message: 'places.search.error'.tr(),
        retryLabel: 'common.retry'.tr(),
        onRetry: () {
          unawaited(ref.read(placeSearchProvider.notifier).retry());
        },
      ),
      data: (results) {
        if (results.isEmpty) {
          return EmptyState(
            icon: Icons.search_off,
            title: 'places.search.no_results_title'.tr(),
            description: 'places.search.no_results_description'.tr(),
          );
        }

        return ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: results.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final place = results[index];
            return PlaceSearchResultTile(
              place: place,
              onTap: () {
                unawaited(
                  ref.read(placeSearchProvider.notifier).rememberCurrentQuery(),
                );
                context.push(AppRoutes.placeDetailPath(place.id));
              },
              heroTag: 'place-image-${place.id}',
            );
          },
        );
      },
    );
  }
}

class _RecentSearchesList extends ConsumerWidget {
  const _RecentSearchesList({required this.recentSearches});

  final AsyncValue<List<String>> recentSearches;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return recentSearches.when(
      loading: () => AppLoadingIndicator(semanticsLabel: 'common.loading'.tr()),
      error: (error, stackTrace) => ErrorView(
        message: 'places.search.recent_error'.tr(),
        retryLabel: 'common.retry'.tr(),
      ),
      data: (items) {
        if (items.isEmpty) {
          return EmptyState(
            icon: Icons.history,
            title: 'places.search.no_recent_title'.tr(),
            description: 'places.search.no_recent_description'.tr(),
          );
        }

        return ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          itemCount: items.length + 1,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _RecentSearchesHeader(
                onClear: () {
                  unawaited(
                    ref
                        .read(placeSearchProvider.notifier)
                        .clearRecentSearches(),
                  );
                },
              );
            }

            final query = items[index - 1];
            return ListTile(
              leading: const Icon(Icons.history),
              title: Text(query, maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.north_west),
              onTap: () {
                unawaited(
                  ref
                      .read(placeSearchProvider.notifier)
                      .searchFromRecent(query),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _RecentSearchesHeader extends StatelessWidget {
  const _RecentSearchesHeader({required this.onClear});

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'places.search.recent_title'.tr(),
              style: AppTypography.titleMedium,
            ),
          ),
          TextButton.icon(
            onPressed: onClear,
            icon: const Icon(Icons.delete_outline),
            label: Text('places.search.clear_recent'.tr()),
          ),
        ],
      ),
    );
  }
}
