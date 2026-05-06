import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/router/routes.dart';
import 'package:mobile/app/theme/app_spacing.dart';
import 'package:mobile/core/widgets/app_button.dart';
import '../application/onboarding_controller.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/page_indicator.dart';

/// Onboarding screen — 3-page swipe carousel with skip/next/finish flow
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button (top right)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: AppButton.text(
                  label: 'onboarding.skip'.tr(),
                  onPressed: () async {
                    await controller.skip();
                    if (context.mounted) {
                      context.go(AppRoutes.login);
                    }
                  },
                ),
              ),
            ),

            // PageView with onboarding pages
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  // Update page index when user swipes
                  ref
                      .read(onboardingControllerProvider.notifier)
                      .setPage(index);
                },
                children: [
                  // Page 1: Discover
                  OnboardingPage(
                    icon: Icons.travel_explore,
                    title: 'onboarding.page1_title'.tr(),
                    description: 'onboarding.page1_description'.tr(),
                  ),

                  // Page 2: Quests & Routes
                  OnboardingPage(
                    icon: Icons.map,
                    title: 'onboarding.page2_title'.tr(),
                    description: 'onboarding.page2_description'.tr(),
                  ),

                  // Page 3: AI Guide
                  OnboardingPage(
                    icon: Icons.emoji_events,
                    title: 'onboarding.page3_title'.tr(),
                    description: 'onboarding.page3_description'.tr(),
                  ),
                ],
              ),
            ),

            // Bottom nav: page indicator + prev/next buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.lg,
              ),
              child: Column(
                children: [
                  // Page indicator
                  PageIndicator(totalPages: 3, currentPage: currentPageIndex),
                  const SizedBox(height: AppSpacing.xl),

                  // Action buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Previous button (visible only if not on first page)
                      if (currentPageIndex > 0)
                        AppButton.secondary(
                          label: 'onboarding.previous'.tr(),
                          onPressed: () {
                            controller.goToPreviousPage();
                          },
                        )
                      else
                        const SizedBox(width: 80), // Placeholder for alignment
                      // Next/Finish button
                      AppButton.primary(
                        label: currentPageIndex == 2
                            ? 'onboarding.finish'.tr()
                            : 'onboarding.next'.tr(),
                        onPressed: () async {
                          if (currentPageIndex == 2) {
                            // Last page: finish and navigate
                            await controller.finish();
                            if (context.mounted) {
                              context.go(AppRoutes.login);
                            }
                          } else {
                            // Not last page: go to next
                            controller.goToNextPage();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
